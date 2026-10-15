# Food to Go — Flutter Prototype

## Project Description

Food to Go is a low-fidelity Flutter prototype for a college canteen food-ordering application. It allows students to browse canteen outlets, view available food items, add items to a cart, manage quantities, and place a sample order.

The prototype focuses on basic UI design, functional buttons, screen navigation, and an organized MVVM-style project structure.

## Objectives

- Create a simple, low-fidelity food-ordering interface.
- Implement navigation between screens.
- Allow users to browse food items from different outlets.
- Implement basic cart functionality and total price calculations.
- Organize the source code using the Model-View-ViewModel (MVVM) pattern.
- Initialize a local Git repository for version control.

## Features

- **Home Screen** — Displays the available canteen outlets.
- **Menu Screen** — Displays food items, descriptions, and prices for the selected outlet.
- **Shopping Cart** — Allows users to add items, increase or decrease quantities, remove items, and view the total price.
- **Order Confirmation** — Displays a confirmation message after the user places a sample order.
- **Functional Navigation** — Allows users to move between the different screens.
- **Low-Fidelity UI** — Uses simple bordered boxes, placeholder images, and outlined buttons.

## Sample Canteen Outlets

| Outlet | Sample Items |
|---|---|
| WaffleTime | Classic Waffle, Chocolate Waffle, Cheese Waffle |
| Burp’nGo | Classic Burger, Cheese Burger, French Fries |
| Coffee Shop | Iced Coffee, Hot Coffee, Chocolate Drink |

## Technology Stack

- **Framework:** Flutter
- **Programming Language:** Dart
- **State Management:** ChangeNotifier and AnimatedBuilder
- **Navigation:** Flutter Navigator and MaterialPageRoute
- **Version Control:** Git
- **Data Storage:** In-memory sample data

No additional state-management or navigation packages are required for this starter implementation.

## Project Structure

```text
food_to_go/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── food_item.dart
│   │   └── cart_item.dart
│   ├── viewmodels/
│   │   └── food_to_go_viewmodel.dart
│   ├── views/
│   │   ├── home_screen.dart
│   │   ├── menu_screen.dart
│   │   ├── cart_screen.dart
│   │   └── confirmation_screen.dart
│   └── widgets/
│       └── low_fi_card.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

## MVVM Architecture

The application follows an MVVM-style structure to separate the user interface, application logic, and data models.

### Model

The Model defines the data used by the application.

- `food_item.dart` — Represents a food item, including its name, outlet, description, and price.
- `cart_item.dart` — Represents a cart item, including its quantity and subtotal.

### View

The View displays the interface and handles user interactions.

- `home_screen.dart` — Displays the available outlets.
- `menu_screen.dart` — Displays the menu for the selected outlet.
- `cart_screen.dart` — Displays cart items and manages cart-related interactions.
- `confirmation_screen.dart` — Displays the sample order confirmation.
- `low_fi_card.dart` — Contains reusable low-fidelity UI components.

### ViewModel

`food_to_go_viewmodel.dart` manages the application's sample data and cart logic.

Its responsibilities include:

- Providing the list of outlets and food items.
- Filtering food items by outlet.
- Adding and removing cart items.
- Updating item quantities.
- Calculating subtotals and the total price.
- Notifying the UI when data changes.

## Navigation Flow

The application uses Flutter's built-in `Navigator` for screen navigation.

```text
Home Screen
    |
    v
Menu Screen
    |
    v
Cart Screen
    |
    v
Confirmation Screen
    |
    v
Back to Home
```

Users can also open the cart from the Home Screen or Menu Screen.

### Navigation Implementation

- `Navigator.push()` opens a new screen.
- `MaterialPageRoute` defines the destination screen.
- `Navigator.popUntil()` returns to the Home Screen.
- The same ViewModel instance is passed between screens to maintain consistent cart data during navigation.

## Requirements

- Flutter SDK installed.
- Dart SDK compatible with the project's Flutter installation.
- Visual Studio Code or another Flutter-compatible IDE.
- Android emulator or connected Android device.
- Git installed for version control.

## Installation and Setup

### 1. Create the Flutter Project

```powershell
flutter create food_to_go
cd food_to_go
code .
```

### 2. Create the Source Files

Create the folders and Dart files listed in the project structure, then paste the corresponding source code into each file.

### 3. Retrieve Dependencies

```powershell
flutter pub get
```

### 4. Check for Code Issues

```powershell
flutter analyze
```

### 5. Run the Application

Start an Android emulator or connect a compatible device, then execute:

```powershell
flutter run
```

## Functional Testing

The following scenarios can be used to test the prototype.

- Verify that all three canteen outlets appear on the Home Screen.
- Select an outlet and verify that its corresponding menu opens.
- Add a food item to the cart.
- Verify that the cart count updates.
- Increase and decrease item quantities.
- Remove an item from the cart.
- Verify that the subtotal and total price update correctly.
- Place a sample order and verify that the Confirmation Screen appears.
- Return to the Home Screen and verify that the cart has been cleared.

## Initial Git Repository

Initialize the local Git repository from the project directory.

```powershell
git init
git status
```

Stage the project files:

```powershell
git add .
git status
```

Create the initial commit:

```powershell
git commit -m "Initial commit: Food to Go Flutter prototype"
```

Verify the commit:

```powershell
git log -1 --oneline
```

If Git requires a username and email, configure your own details:

```powershell
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

The project is now tracked in a local Git repository. A GitHub repository can be added separately if remote hosting is required.

## Current Limitations

- The menu uses sample data.
- Cart data is stored in memory and resets when the application restarts.
- No database or backend service is connected.
- No real payment processing or order submission is implemented.
- Food images are placeholders.
- The order confirmation is for demonstration purposes only.

## Future Improvements

- Add actual food images and improved UI styling.
- Add persistent storage for cart and order data.
- Connect the application to a database or backend.
- Add order history and order status tracking.
- Implement real-time menu availability.
- Improve responsiveness for different screen sizes.
- Create a separate Figma wireframe prototype.

## Project Status

**Starter Prototype**

This project provides the initial UI, navigation, basic cart functionality, MVVM-style organization, and Git version-control setup for the Food to Go application.
