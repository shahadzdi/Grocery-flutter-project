# 🛒 FreshGrocery App

A modern, responsive, and full-stack grocery shopping application built with **Flutter** and **Supabase**. This project focuses on clean code architecture, real-time data handling, and a professional user experience.

## 📝 Project Description
**Grocery** is an all-in-one shopping solution that allows users to browse daily fresh products, manage their shopping carts in real-time, and securely handle their accounts. The app features a nature-inspired design using a professional color palette to reflect freshness and quality.

## 📱 App Screens
The application consists of 5 essential screens to ensure a complete user flow:
* **Welcome Screen**: Visual introduction to the app.
* **Sign Up Screen**: Secure account creation via Supabase Auth.
* **Log In Screen**: User authentication for existing accounts.
* **Products List**: A dynamic 3-column grid showing all available groceries with stock status.
* **Shopping Cart**: Real-time management of items with live total price calculation.

## ✨ Main Features
* **User Authentication**: Email and password sign-up and login integrated with **Supabase Auth**.
* **Live Product Catalog**: Displays products with details such as price, stock status (Low Stock/Out of Stock), and descriptions.
* **Automated Cart Management**: Add or remove items, with quantity updates directly synced to the database.
* **Responsive UI**: Developed using custom extensions to ensure the layout adapts perfectly to various screen sizes.

## 🏗️ Code Quality & Structure
The project follows a highly organized folder structure to ensure maintainability and readability:
* `screens/`: UI screens logic.
* `models/`: Data modeling and JSON parsing (`GroceriesModel`).
* `services/`: Backend integration logic (`DataBase` service).
* `widgets/`: Reusable UI components (Custom Buttons, TextFields, Cards).
* `extensions/`: Custom Dart extensions for Navigation and Responsiveness.
* `constants/`: Global app styling and colors.

## 🚀 Creativity & Extra Features
Beyond the bootcamp requirements, I implemented several advanced features:
* **Real-time Database Streams**: Researched and implemented Supabase **Streams** in the Shopping Cart. This allows the UI to update instantly when the database changes without reloading the screen.
* **Dynamic Stock Feedback**: Added logic to visually inform users of stock levels (e.g., "Low stock" warnings) directly on the product grid.
* **Interactive SnackBars**: Custom visual feedback when adding items to the cart to enhance user engagement.

## 🛠️ Tech Stack
* **Frontend**: **Flutter** (Dart).
* **Backend**: **Supabase** (Auth, PostgreSQL, Real-time Streams).

### 📱 App Screenshots

| Welcome | Sign Up | Login | Products List | Shopping Cart |
| :---: | :---: | :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/eeca2476-10ad-40d6-a5cd-eb1b93f1f3dd" width="180"> | <img src="https://github.com/user-attachments/assets/277602f0-8133-432e-ab69-efd27169f2d5" width="180"> | <img src="https://github.com/user-attachments/assets/2615bfaf-f2ba-4d95-917a-875030adad0d" width="180"> | <img src="https://github.com/user-attachments/assets/917da1d1-2836-41f5-b64e-9a4ed8f20475" width="180"> | <img src="https://github.com/user-attachments/assets/22086c26-bad4-4b26-b119-c6a6b0e7bdb7" width="180"> |

### 🗄️ Database Screenshot (Supabase)
Below is the `cart` table structure in Supabase:

![Supabase Cart Table](https://github.com/user-attachments/assets/8feb21d8-03c8-4937-b424-9c8d0e8761df)