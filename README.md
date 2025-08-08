<h1>Task Manager App</h1>
A Flutter-based task management application with local storage and intuitive task status tracking.

<h2>📱 Demo</h2>
[![Demo Preview](Taskmanager_vid.gif)](Taskmanager_vid.mp4)

<h2>🛠️ Tech Stack</h2>
<p align="center"> <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/> <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/> <img src="https://img.shields.io/badge/SharedPreferences-FF6B6B?style=for-the-badge&logo=database&logoColor=white" alt="Local Storage"/> </p>
<h2>✨ Features</h2>
Task status management (Not Started → In Progress → Completed)

Local data persistence with SharedPreferences

Interactive task details popup

Date picker for task scheduling

Priority-based task ordering

Color-coded status indicators

## 🚀 Setup

```bash
git clone https://github.com/akshitrajput/TaskManagerUI.git
cd taskmanager
flutter pub get
flutter run

📁 Structure

lib/
├── models/
│   └── task.dart
├── services/
│   └── storage_service.dart
├── widgets/
│   └── task_card.dart
├── screens/
│   └── task_list_screen.dart
└── utils/
    └── date_formatter.dart

Built with Flutter for cross-platform compatibility and smooth user experience.