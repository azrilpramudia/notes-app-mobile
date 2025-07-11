import { prisma } from "../application/database.js";
import { HttpException } from "../middleware/error.js";
import { hash, verify } from "argon2";
import jwt from "jsonwebtoken";
import "dotenv/config";

// Register
export const register = async (request) => {
  const findUser = await prisma.users.findFirst({
    where: {
      username: request.username,
    },
  });

  if (findUser) {
    throw new HttpException(409, "Username already exists");
  }

  request.password = await hash(request.password);

  const user = await prisma.users.create({
    data: {
      fullname: request.fullname,
      username: request.username,
      password: request.password,
    },
    select: {
      id: true,
      fullname: true,
      username: true,
      created_at: true,
    },
  });

  return {
    message: "User created successfully",
    user,
  };
};

// Login
export const login = async (request) => {
  const user = await prisma.users.findUnique({
    where: {
      username: request.username,
    },
  });

  if (!user) {
    throw new HttpException(401, "invalid credentials");
  }

  const isPasswordValid = await verify(user.password, request.password);

  if (!isPasswordValid) {
    throw new HttpException(401, "invalid credentials");
  }

  const token = jwt.sign(
    { id: user.id },
    process.env.JWT_KEY
  );

  return {
    message: "Login successful",
    access_token: token,
  };
};
