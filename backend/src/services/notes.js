import { prisma } from "../application/database.js";
import { HttpException } from "../middleware/error.js";

// Create a new note
export const createNote = async (userId, request) => {
  const note = await prisma.notes.create({
    data: {
      name: request.name,
      description: request.description,
      userId: userId,
    },
  });

  return note;
};

// Get paginated notes for a user
export const getNotes = async (userId, page = 1, limit = 5) => {
  const skip = (page - 1) * limit;

  const totalNotes = await prisma.notes.count({
    where: { userId },
  });

  let notes = [];
  if (totalNotes > 0) {
    notes = await prisma.notes.findMany({
      where: { userId },
      skip,
      take: limit,
    });
  }

  const totalPages = Math.ceil(totalNotes / limit);
  return {
    message: "Notes retrieved successfully",
    data: notes,
    paging: {
      page,
      page_size: limit,
      total_item: totalNotes,
      total_page: totalPages,
    },
  };
};

// Get a single note by ID and user
export const getNote = async (userId, noteId) => {
  const note = await prisma.notes.findFirst({
    where: {
      id: noteId,
      userId: userId,
    },
  });

  if (!note) {
    throw new HttpException(404, "Note not found");
  }

  return note;
};

// Update note by ID and user
export const updateNote = async (userId, noteId, request) => {
  const result = await prisma.notes.updateMany({
    where: {
      id: noteId,
      userId: userId,
    },
    data: {
      name: request.name,
      description: request.description,
    },
  });

  if (result.count === 0) {
    throw new HttpException(404, "Note not found or you are not authorized");
  }

  return {
    message: "Note updated successfully",
  };
};

// Delete note by ID and user
export const deleteNote = async (userId, noteId) => {
  const findNote = await prisma.notes.findFirst({
    where: {
      id: noteId,
      userId: userId,
    },
  });

  if (!findNote) {
    throw new HttpException(404, "Note not found");
  }

  await prisma.notes.delete({
    where: { id: noteId },
  });

  return {
    message: "Note deleted successfully",
  };
};
