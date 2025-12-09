# ☕ Coffee Shop Full Ecosystem (Monorepo)

A complete, production-ready coffee shop solution built with **Flutter**. This project demonstrates a powerful **Monorepo** architecture, sharing business logic and models between a Customer Mobile App and an Admin Dashboard.

## 🚀 Key Features

- **📱 Customer Mobile App:** Smooth UI for browsing menus, customizing orders, and tracking delivery.
- **💻 Admin Dashboard:** Web/Tablet control panel for managing products, orders, and analytics.
- **🔗 Shared Architecture:** A dedicated `shared_module` ensuring 100% code consistency (Models, Constants, Utilities) across apps.

## 🛠 Tech Stack

- **Framework:** Flutter (Mobile & Web)
- **Language:** Dart
- **Architecture:** Clean Architecture & MVVM
- **State Management:** Cubit / Bloc
- **Backend:** Firebase (Auth, Firestore, Storage)
- **Code Sharing:** Monorepo Strategy (Shared Dart Packages)

## 📂 Project Structure

The project is divided into three main distinct parts to separate concerns while maximizing code reusability:

```text
Coffee_Shop_Full_Project/
│
├── 📱 mobile_app/       # The customer-facing mobile application
├── 💻 admin_panel/      # The management dashboard for admins
└── 📦 shared_module/    # Common code (Models, Styles, Constants) used by both apps

Customer App (Mobile)	Admin Panel (Dashboard)
<img src="screenshots/mobile_home.png" width="250">	<img src="screenshots/admin_dash.png" width="400">
Home Screen	Overview Dashboard

