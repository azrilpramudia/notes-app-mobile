# 📝 Notes App

A full-stack mobile note-taking app built with **Flutter (Frontend)** and **Express.js (Backend)**.

---

## 🧰 Tech Stack

### Frontend

- ✅ [Flutter](https://flutter.dev/)
- ✅ Dart
- ✅ shared_preferences (local storage)
- ✅ REST API integration

### Backend

- ✅ [Express.js](https://expressjs.com/)
- ✅ Node.js
- ✅ MySQL
- ✅ CORS, jsonwebtoken, etc

---

## 📱 Frontend (Flutter)

### 🔧 Setup Instructions

```bash
# Clone frontend repo
git clone https://github.com/azrilpramudia/notes-app-mobile.git
cd notes-app-mobile

# Install dependencies
flutter pub get

# Run the app
flutter run
```

> Gunakan emulator Android Studio atau device fisik.

---

## 🌐 Backend (Express.js)

### 🔧 Setup Instructions

```bash
# Clone backend repo
git clone https://github.com/azrilpramudia/notes-api.git
cd notes-api

# Install dependencies
npm install

# Jalankan server
npm run dev
```

Default base URL backend:

```
http://localhost:3000
```

> 🔁 Sesuaikan base URL pada file `lib/services/api.dart` di Flutter jika berbeda.

---

## 🔗 API Endpoints (Sample)

| Method | Endpoint     | Description     |
| ------ | ------------ | --------------- |
| GET    | `/notes`     | Get all notes   |
| POST   | `/notes`     | Create new note |
| PUT    | `/notes/:id` | Update note     |
| DELETE | `/notes/:id` | Delete note     |

---

## 📂 Project Structure

### Flutter (Frontend)

```
frontend/
├── lib/
│   ├── auth
│   ├── notes/
|   |── main.dart
│   └── splash.dart
├── android/
├── ios/
└── pubspec.yaml
```

### Express.js (Backend)

```
backend/src
├── application/
├── controllers/
├── middleware/
├── route/
└── services/
└── main.js
```
