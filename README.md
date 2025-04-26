# 🐐 Goat Monitoring App 🐐

Welcome to the **Goat Monitoring App**, a Flutter-based mobile application designed to track the health and well-being of goats! 🐐✨

The app allows farmers and caretakers to monitor important goat data such as their conditions, pregnancy status, and more, providing an easy-to-use interface with a backend powered by SQLite for data persistence.

---

## 🛠 Features

- 📱 **Mitra Management**: Track and manage `mitra` (partners) data such as their name, village, and associated goat information.
- 🐐 **Goat Data Tracking**: Add, update, and view data related to each goat, including condition, pregnancy stage, and photos.
- 📸 **Photo Gallery**: Upload and manage images for each goat to visually track their progress.
- 💾 **SQLite Database**: All data is stored locally for offline access.

---


## 📦 Installation

Follow these steps to run the Goat Monitoring App on your local machine:

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (Make sure Flutter is installed on your system)
- [Android Studio](https://developer.android.com/studio) (or any IDE that supports Flutter development)
- [SQLite](https://www.sqlite.org/) (Integrated into Flutter through the `sqflite` plugin)

### Steps to Get Started

1. Clone this repository:

    ```bash
    git clone https://github.com/yourusername/goat-monitoring-app.git
    ```

2. Navigate to the project directory:

    ```bash
    cd goat-monitoring-app
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

---

## 💡 How It Works

### 1. **Mitra Management**

- You can **add new mitra** with their details (name, village, checker name, companion name) using a simple form.
- View a list of all **mitra**, and click on each to manage associated goat data.

### 2. **Goat Data Tracking**

- For each `mitra`, you can add **goat information** such as:
  - Goat Number
  - Health Condition
  - Description ( Age,Color,Etc)
  - Photo of the Goat

### 3. **Photo Management**

- Take/upload **photos of the goats** and store them alongside their data for better visual tracking.
  
---

## 🛠 Tech Stack

- **Flutter**: For building cross-platform mobile applications.
- **SQLite**: For local data storage.
- **GetX**: For state management and easy navigation.
- **Sqflite**: For SQLite integration in Flutter.

---

## 🔧 Development Setup

To get the project up and running locally for development, follow these steps:

1. Install **Flutter**: Follow the setup guide on [Flutter's official website](https://flutter.dev/docs/get-started/install).
2. Install the **sqflite** plugin for SQLite:

    ```bash
    flutter pub add sqflite
    ```

3. Install **GetX** for state management:

    ```bash
    flutter pub add get
    ```

4. Run the app on an Android/iOS simulator or connected device:

    ```bash
    flutter run
    ```

---

## 🌟 Contribution

Feel free to fork the repository, create branches, and contribute by submitting pull requests!

### How to Contribute

1. Fork the repo
2. Create a new branch (`git checkout -b feature/your-feature-name`)
3. Make your changes and commit (`git commit -m 'Add your changes'`)
4. Push to your branch (`git push origin feature/your-feature-name`)
5. Open a pull request and describe your changes!

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

---



## 🔗 Links

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Documentation](https://pub.dev/packages/get)
- [SQLite Documentation](https://www.sqlite.org/docs.html)

---

## 💬 Feedback

Your feedback is valuable! Share your thoughts, suggestions, and any bug reports to help us improve the app.

---

> _"Success is the sum of small efforts, repeated day in and day out."_ – Robert Collier

---
