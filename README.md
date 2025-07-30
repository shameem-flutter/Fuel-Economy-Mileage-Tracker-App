# 🚗 Fuel Economy & Mileage Tracker App

A Flutter application to track mileage (km/l) and fuel economy (₹/km) for Cars, Bikes, and Buses. Built with Firebase integration and clean UI.

---

## 📱 Features

- Vehicle type selection (Car, Bike, Bus)
- Input start and end odometer readings
- Input fuel filled (liters) and fuel price (₹/L)
- Calculates:
  - **Mileage** = km/l
  - **Fuel Economy** = ₹/km
- View detailed trip history (Firestore)
- Firebase Authentication
- Responsive UI with dark mode support

---

## 🛠️ State Management & Packages Used

- **State Management:** `flutter_riverpod`
- **Packages Used:**
  - [`firebase_auth`](https://pub.dev/packages/firebase_auth)
  - [`cloud_firestore`](https://pub.dev/packages/cloud_firestore)
  - [`firebase_core`](https://pub.dev/packages/firebase_core)

---

## 📸 Screenshots

| Login Screen              | Home Input Screen         |
|--------------------------|---------------------------|
| ![](screenshots/login1.png) | ![](screenshots/homepage2.png) |

| Summary View              | Trip History View         |
|--------------------------|---------------------------|
| ![](screenshots/summary3.png) | ![](screenshots/history5.png) |

| Alternate Summary Style   |
|--------------------------|
| ![](screenshots/summary4.png) |

---

## 🚀 Getting Started

### 🔧 Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/shameem-flutter/Fuel-Economy-Mileage-Tracker-App.git
   cd Fuel-Economy-Mileage-Tracker-App

2. **Install dependencies:**
   ```bash
   flutter pub get

3. **Firebase Setup:**
   - Add `google-services.json` to `/android/app/`
   - Add `GoogleService-Info.plist` to `/ios/Runner/`
   
