# Food to Go — Flutter Food Ordering Application

## Project Description

Food to Go is a low-fidelity Flutter prototype for a college canteen food-ordering application. It allows students to browse canteen outlets, view available food items, add items to a cart, manage quantities, save favorite foods, and place sample orders.

The application also includes a local JSON-based storage system that allows important information, such as cart items, favorite foods, and order tickets, to persist even after the application is closed or restarted. Users can access their favorite food items directly without navigating through the corresponding outlet.

The prototype focuses on basic UI design, functional buttons, screen navigation, local data persistence, and an organized MVVM-style project structure.

## Objectives

- Create a simple, low-fidelity food-ordering interface.
- Implement navigation between screens.
- Allow users to browse food items from different outlets.
- Implement cart functionality and total price calculations.
- Allow users to save and manage their favorite food items.
- Provide direct access to favorite food items from the Favorites Screen.
- Generate and manage order tickets after checkout.
- Implement local JSON-based storage for offline data persistence.
- Organize the source code using the Model-View-ViewModel (MVVM) pattern.
- Maintain a local Git repository for version control.

## Features

- **Home Screen** — Displays the available canteen outlets and provides access to Favorites, Shopping Cart, and Order Tickets.

- **Menu Screen** — Displays food items, descriptions, and prices for the selected outlet. Users can add items to their cart or mark them as favorites.

- **Shopping Cart** — Allows users to add items, increase or decrease quantities, remove items, and view the total price.

- **Favorites System** — Allows users to save and remove individual food items from their favorites list.

- **Direct Favorite Access** — Displays saved food items in a dedicated Favorites Screen. Users can open a food item's details or add it directly to their cart without navigating through its outlet.

- **Food Details Screen** — Displays the selected food item's name, description, outlet, and price. Users can also manage favorites and add the item to their cart.

- **Order Ticket Generation** — Automatically generates a unique ticket ID when a user places an order. Each ticket contains the ordered items, quantities, prices, total amount, creation date, and order status.

- **Order Ticket History** — Allows users to view previously generated tickets and their corresponding order information.

- **Order Status Management** — Provides sample status updates, including Pending, Preparing, Ready, and Completed.

- **JSON-Based Offline Storage** — Saves cart items, favorite foods, and order tickets locally using JSON encoding and SharedPreferences.

- **Data Persistence** — Restores previously saved favorites, cart items, and order tickets when the application is reopened.

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
- **Local Data Storage:** SharedPreferences
- **Data Format:** JSON
- **JSON Processing:** Dart `dart:convert` library
- **Version Control:** Git

The application uses SharedPreferences to store JSON-encoded data locally. This allows the prototype to retain important application information without requiring an internet connection or an external database.

## Project Structure

```text
food_to_go/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── food_item.dart
│   │   ├── cart_item.dart
│   │   └── order_ticket.dart
│   ├── viewmodels/
│   │   └── food_to_go_viewmodel.dart
│   ├── views/
│   │   ├── home_screen.dart
│   │   ├── menu_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── confirmation_screen.dart
│   │   ├── favorites_screen.dart
│   │   ├── food_detail_screen.dart
│   │   └── tickets_screen.dart
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

- `food_item.dart` — Represents a food item, including its ID, name, outlet, description, and price.
- `cart_item.dart` — Represents a cart item, including its quantity and subtotal.
- `order_ticket.dart` — Represents an order ticket, including its unique ticket ID, creation date, ordered items, total amount, and order status. It also handles JSON conversion through `toJson()` and `fromJson()`.

### View

The View displays the interface and handles user interactions.

- `home_screen.dart` — Displays the available outlets and navigation options.
- `menu_screen.dart` — Displays the menu for the selected outlet and provides favorite and cart actions.
- `cart_screen.dart` — Displays cart items and manages cart-related interactions.
- `confirmation_screen.dart` — Displays the order confirmation and generated ticket number.
- `favorites_screen.dart` — Displays saved favorite food items and provides direct access to their details.
- `food_detail_screen.dart` — Displays detailed information about an individual food item.
- `tickets_screen.dart` — Displays saved order tickets and their corresponding statuses.
- `low_fi_card.dart` — Contains reusable low-fidelity UI components.

### ViewModel

`food_to_go_viewmodel.dart` manages the application's data, state, and business logic.

Its responsibilities include:

- Providing the list of outlets and food items.
- Filtering food items by outlet.
- Adding and removing cart items.
- Updating item quantities.
- Calculating subtotals and the total price.
- Managing favorite food items.
- Retrieving favorite items directly from the menu data.
- Generating unique order ticket IDs.
- Creating and maintaining order ticket records.
- Updating ticket statuses.
- Saving and loading application data using JSON.
- Notifying the UI when application data changes.

## JSON-Based Local Storage

The application uses SharedPreferences to store JSON-encoded application data locally.

The following information is saved:

| Storage Key | Stored Information |
|---|---|
| `favorites` | List of favorite food item IDs |
| `cart` | Food item IDs and their quantities |
| `tickets` | Order ticket records, including ordered items, prices, totals, dates, and statuses |

### Storage Process

1. When the application starts, the ViewModel initializes SharedPreferences.
2. Previously saved JSON data is retrieved from local storage.
3. The JSON data is decoded and converted back into the application's Dart objects.
4. When users modify their cart, favorites, or tickets, the updated information is encoded into JSON.
5. The updated JSON data is saved locally.
6. When the application is reopened, the saved information is loaded again.

This approach provides basic offline data persistence without requiring Firebase, an external database, or a backend server.

## Order Ticket System

The Order Ticket System generates a ticket whenever a user successfully places an order.

Each ticket contains:

- Unique ticket ID.
- Date and time of order creation.
- List of ordered food items.
- Food item names and outlet information.
- Individual food prices.
- Ordered quantities.
- Total order amount.
- Current order status.

### Sample Ticket Information

```text
FOOD TO GO
--------------------------------
Ticket ID: FTG-1799999999999

ORDER ITEMS

2x Classic Waffle       PHP 90.00
1x Iced Coffee          PHP 50.00

--------------------------------
TOTAL:                  PHP 140.00

STATUS: PENDING
--------------------------------
```

The generated ticket is saved locally and can be accessed through the Tickets Screen even after restarting the application.

The prototype also provides sample order status updates:

- Pending
- Preparing
- Ready
- Completed

These status changes are currently simulated within the application and are not connected to an actual canteen staff system.

## Navigation Flow

The application uses Flutter's built-in `Navigator` for screen navigation.

```text
                 Home Screen
                      |
          +-----------+-----------+
          |           |           |
          v           v           v
       Menu       Favorites     Tickets
          |           |
          v           v
     Food Items   Food Details
          |           |
          +-----+-----+
                |
                v
             Cart
                |
                v
       Order Confirmation
                |
                v
          Tickets Screen
```

Users can also open the cart directly from the Home Screen or Menu Screen.

### Navigation Implementation

- `Navigator.push()` opens a new screen.
- `Navigator.pushReplacement()` replaces the current screen after checkout.
- `MaterialPageRoute` defines the destination screen.
- `Navigator.popUntil()` returns to the Home Screen.
- `Navigator.pushAndRemoveUntil()` navigates to the ticket history while removing previous navigation routes.
- The same ViewModel instance is passed between screens to maintain consistent application state.

## Requirements

- Flutter SDK installed.
- Dart SDK compatible with the project's Flutter installation.
- Visual Studio Code or another Flutter-compatible IDE.
- Android emulator, connected Android device, or supported Flutter Web browser.
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

### 3. Install Dependencies

Add the following package under `dependencies` in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  shared_preferences: ^2.5.3
```

### 4. Retrieve Dependencies

```powershell
flutter pub get
```

### 5. Check for Code Issues

```powershell
flutter analyze
```

### 6. Run the Application

Start an Android emulator, connect a compatible device, or use a supported browser.

For Android:

```powershell
flutter run
```

For Flutter Web:

```powershell
flutter run -d chrome
```

## Functional Testing

The following scenarios can be used to test the application's functionality.

### Home and Menu

- Verify that all three canteen outlets appear on the Home Screen.
- Select an outlet and verify that its corresponding menu opens.
- Verify that the correct food items, descriptions, and prices are displayed.

### Shopping Cart

- Add a food item to the cart.
- Verify that the cart count updates.
- Increase and decrease item quantities.
- Remove an item from the cart.
- Verify that the subtotal and total price update correctly.

### Favorites

- Mark a food item as a favorite from the Menu Screen.
- Open the Favorites Screen and verify that the selected item appears.
- Open a favorite food item directly without navigating through its outlet.
- Add a favorite food item directly to the cart.
- Remove an item from the Favorites Screen.
- Restart the application and verify that favorite items remain saved.

### Order Tickets

- Add food items to the cart.
- Place an order and verify that a unique ticket ID is generated.
- Verify that the Confirmation Screen displays the correct order information.
- Open the Tickets Screen and verify that the generated ticket appears.
- Verify that the ticket contains the correct items, quantities, prices, and total amount.
- Change the ticket status and verify that the updated status is displayed.

### Offline Storage and Data Persistence

- Add food items to the cart and verify that the cart information is saved.
- Mark food items as favorites and verify that they remain saved after restarting.
- Place an order and verify that the ticket remains available after restarting.
- Test the application without an internet connection.
- Verify that locally stored information can still be retrieved.

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

Create a commit for the updated application:

```powershell
git commit -m "Update Food to Go with favorites, tickets, and JSON storage"
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

- The menu uses hardcoded sample food data.
- Local application data is stored using SharedPreferences rather than a centralized database.
- Saved information is limited to the current device or browser storage.
- Clearing application data or browser site data may remove saved information.
- No cloud synchronization between different devices is implemented.
- No real payment processing or online order submission is implemented.
- Ticket status updates are manually simulated and are not connected to an actual canteen staff interface.
- No automatic outlet notifications are implemented.
- Food images are placeholders.
- The application is a prototype and is not yet intended for actual commercial food ordering.

## Future Improvements

- Add actual food images and improved UI styling.
- Connect the application to a centralized database or backend.
- Implement separate outlet-based order management.
- Create a dedicated canteen staff interface for managing incoming tickets.
- Add pickup numbers for easier order identification.
- Implement real-time order status updates.
- Add payment methods and payment confirmation.
- Implement real-time menu availability.
- Add user accounts and cloud synchronization.
- Improve responsiveness for different screen sizes.
- Create a separate Figma wireframe prototype.

## Project Status

**Enhanced Flutter Prototype**

Food to Go has progressed beyond its initial stateless implementation. The application now includes state management, local JSON-based data persistence, favorite food management, direct access to favorite items, order ticket generation, ticket history, and sample order status management.

The project demonstrates how a simple Flutter food-ordering prototype can support basic offline functionality while maintaining an organized MVVM-style structure.