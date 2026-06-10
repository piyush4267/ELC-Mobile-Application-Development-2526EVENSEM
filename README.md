# 📱 Student Information Management App
### Flutter + PHP + MySQL (XAMPP)

---

## 👨‍🎓 Assignment Details

| Field | Details |
|---|---|
| **Name** | Piyush Anand |
| **Roll Number** | 1025170118 |
| **Course** | Mobile Application Development |
| **Assignment** | Student Information Management App with Backend Database Integration |

---

## 📁 Project Structure

```
1025170118/
├── 📁 flutter_app/          ← Flutter frontend
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   │   └── student.dart
│   │   ├── services/
│   │   │   └── api_service.dart
│   │   └── screens/
│   │       ├── home_screen.dart
│   │       └── details_screen.dart
│   └── pubspec.yaml
├── 📁 backend/              ← PHP API files
│   ├── insert_student.php
│   └── fetch_students.php
├── 📁 sql/
│   └── student_db.sql       ← Database setup script
├── 📁 screenshots/
│   ├── 1_xampp_running.png
│   ├── 2_database_created.png
│   ├── 3_students_table.png
│   ├── 4_php_test.png
│   ├── 5_home_screen.png
│   ├── 6_form_filled.png
│   ├── 7_success_message.png
│   └── 8_show_details.png
└── 📄 README.md
```

---

## ⚙️ Setup Instructions

### Step 1 — Database (XAMPP)

1. Start **Apache** and **MySQL** in XAMPP Control Panel
2. Open **phpMyAdmin** → `http://localhost/phpmyadmin`
3. Click **Import** tab → choose `sql/student_db.sql` → click **Go**
   This creates the `student_db` database and `students` table automatically ✅

### Step 2 — Backend (PHP)

1. Copy **both PHP files** from `backend/` into:
   ```
   C:\xampp\htdocs\student_api\
   ```
   Create the `student_api` folder if it doesn't exist.

2. Test in your browser:
   ```
   http://localhost/student_api/fetch_students.php
   ```
   Should return JSON like `{"success":true,"count":4,"students":[...]}` ✅

### Step 3 — Flutter App

1. Open `flutter_app/` in VS Code

2. Set the correct IP address in `lib/services/api_service.dart`:

   | Where you run | IP to use |
   |---|---|
   | Chrome (Web) | `http://localhost/student_api` |
   | Android Emulator | `http://10.0.2.2/student_api` |
   | Physical Android device | `http://YOUR_PC_IP/student_api` |

   Find your PC IP: open CMD → type `ipconfig` → look for IPv4 Address.

3. Run:
   ```bash
   flutter pub get

   # For Chrome
   flutter run -d chrome --web-browser-flag "--disable-web-security"

   # For Android Emulator
   flutter run
   ```

---

## 🔄 Application Workflow

```
User opens app
      ↓
Fills form → Name, Roll Number, Email ID, CGPA
      ↓
Clicks Submit → HTTP POST → insert_student.php
      ↓
PHP stores data in MySQL database
      ↓
Success / Failure message shown
      ↓
Clicks Show Details → HTTP GET → fetch_students.php
      ↓
All student records displayed on screen ✅
```

---

## 🔌 API Reference

### POST `/student_api/insert_student.php`
**Request Body (JSON):**
```json
{
  "name": "Piyush Anand",
  "roll_number": "1025170118",
  "email": "piyush@example.com",
  "cgpa": "9.1"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Student registered successfully!",
  "id": 5
}
```

### GET `/student_api/fetch_students.php`
**Response:**
```json
{
  "success": true,
  "count": 1,
  "students": [
    {
      "id": "1",
      "name": "Piyush Anand",
      "roll_number": "1025170118",
      "email": "piyush@example.com",
      "cgpa": "9.10"
    }
  ]
}
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter / Dart |
| HTTP | `http` package |
| Backend | PHP 8 |
| Database | MySQL via XAMPP |
| Server | Apache via XAMPP |

---

## 📸 Screenshots

| Registration Form | Success Message | Student Records |
|---|---|---|
| ![Home Screen](output_results_and_screenshots\5_home_screen.png) | ![Success](output_results_and_screenshots\7_success_message.png) | ![Details](output_results_and_screenshots\8_show_details.png) |

---

## ⚠️ Important Notes

- Always keep **XAMPP running** while using the app
- Always **stop MySQL properly** before shutting down PC to avoid database corruption
- For Chrome testing, the `--disable-web-security` flag is required for localhost API calls
