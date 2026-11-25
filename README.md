# Food to Go — Flutter Food Ordering Application

## 1. Project Overview

**Food to Go** is a Flutter-based food ordering application prototype designed for college students who want an easier way to order food from their campus canteen.

The main idea behind this project is to make food ordering more convenient, especially for students who have limited time between classes and would rather spend less time waiting in line.

Through the application, students can browse different canteen outlets, check available food items and prices, add their selections to a shopping cart, save their favorite foods, and place sample orders.

The application also generates order tickets that students can use to review their orders and monitor their current order status.

Although this is still a prototype, the application already includes working navigation, functional buttons, state management, and local data storage. This allows important information, such as favorites, cart items, and order tickets, to remain saved even after closing and reopening the application.

## 2. Main Objectives

The main objectives of Food to Go are:

- To create a simple and easy-to-understand food ordering interface.
- To provide students with access to different canteen outlets and their menus.
- To allow users to add, remove, and manage food items in their shopping cart.
- To calculate the total price automatically based on the selected items and quantities.
- To provide a Favorites feature where users can save food items they frequently order.
- To generate order tickets after successfully placing an order.
- To allow users to monitor and manage their generated order tickets.
- To save important application data locally so that it remains available after restarting the application.
- To organize the project using the Model-View-ViewModel (MVVM) approach.

## 3. Main Features and Their Functions

### 3.1 Home Screen

The Home Screen serves as the main page of the application.

It displays the available canteen outlets, allowing students to choose where they want to order their food.

It also provides access to other important sections, such as Favorites, Shopping Cart, and Order Tickets.

**Main purpose:** To give users one central location where they can access the application's main features.

### 3.2 Canteen Menu

After selecting an outlet, the application displays its available food items.

Each food item includes its name, description, and price. Users can also add food items directly to their cart or mark them as favorites.

For example, selecting WaffleTime displays its available waffle products instead of showing the menus from other outlets.

**Main purpose:** To make browsing and selecting food easier without mixing the products from different outlets.

### 3.3 Food Details Screen

The Food Details Screen provides additional information about a selected food item.

Users can view its name, description, outlet, and price. From this screen, they can also add the food item to their cart or save it to their favorites.

**Main purpose:** To let users review their food selection before adding it to their order.

### 3.4 Shopping Cart

The Shopping Cart contains all the food items selected by the user.

Users can:
- Add more food items.
- Increase or decrease item quantities.
- Remove unwanted items.
- View the subtotal of individual items.
- See the overall order total.

The total price automatically changes whenever the user modifies the quantity or removes an item.

**Main purpose:** To give students a place to review and manage their orders before checking out.

### 3.5 Favorites System

The Favorites feature allows users to save food items they frequently order or want to purchase later.

Instead of searching through the canteen menus again, users can simply open the Favorites Screen to view their saved items.

Users can also remove items from their favorites or add them directly to their shopping cart.

The favorite list is saved locally, so the selected items remain available even after restarting the application.

**Main purpose:** To make frequently ordered food easier to access and reduce the need to browse through the menus repeatedly.

### 3.6 Order Confirmation

After reviewing their shopping cart, users can proceed with placing their order.

Once the order is submitted, the application generates a unique ticket ID and records the selected food items, quantities, prices, total amount, and date of creation.

The Confirmation Screen then displays the order information and generated ticket number.

**Main purpose:** To provide users with confirmation that their sample order has been successfully recorded by the application.

### 3.7 Order Ticket Management

The Order Ticket System allows users to view and manage their previously generated tickets.

Each ticket contains:
- A unique ticket ID.
- The date and time the order was created.
- The names of the ordered food items.
- The selected quantities.
- Individual food prices.
- The total order amount.
- The current order status.

The system also includes the following functions:

**A. Order Status Cycle**

Instead of having separate buttons for every status, the application uses one button to move the ticket through its different stages.

The status follows this sequence:

Pending → Preparing → Ready → Completed → Pending

Each time the user presses the button, the ticket automatically moves to the next status.

For example:
- Pending means the order has been placed.
- Preparing means the order is being prepared.
- Ready means the order is ready for pickup.
- Completed means the order has been marked as finished.

The cycle is simulated within the application and is not connected to an actual canteen staff system.

**B. Soft Delete / Archive**

Users can archive tickets they no longer need to see in their active ticket list.

Instead of immediately removing the ticket, the application moves it to a separate Archived section.

This is useful when users want to keep their previous order records without having them mixed with their active tickets.

**C. Restore Ticket**

If a ticket was archived accidentally or needs to be viewed again, users can restore it.

The restored ticket returns to the Active section with its previous order information and status.

**D. Permanent Delete**

For tickets that users no longer want to keep, the application provides a permanent delete function.

Before deleting a ticket, the application displays a confirmation message to prevent accidental deletion.

Once confirmed, the selected ticket is permanently removed from the application's locally stored ticket records.

**Main purpose:** To give users more control over their order history, including updating statuses, organizing old tickets, restoring archived records, and deleting unwanted tickets.

## 4. Sample Canteen Outlets

The prototype currently contains three sample canteen outlets:

| Canteen Outlet | Sample Food Items |
|---|---|
| WaffleTime | Classic Waffle, Chocolate Waffle, Cheese Waffle |
| Burp’nGo | Classic Burger, Cheese Burger, French Fries |
| Coffee Shop | Iced Coffee, Hot Coffee, Chocolate Drink |

These sample products are currently stored directly in the application's source code.

## 5. Technology Used

The following technologies and tools were used in developing Food to Go:

| Technology | Purpose |
|---|---|
| Flutter | Used to build the application's user interface. |
| Dart | Main programming language used for the application. |
| ChangeNotifier | Handles changes in application data and state. |
| AnimatedBuilder | Updates the interface when the ViewModel's data changes. |
| Navigator | Handles movement between application screens. |
| MaterialPageRoute | Defines how users navigate to another screen. |
| SharedPreferences | Stores application data locally on the device. |
| JSON | Organizes the saved information into a format that can be stored and retrieved. |
| Git | Tracks project changes and maintains version history. |

### Why SharedPreferences and JSON?

For this prototype, SharedPreferences was used instead of setting up an external database.

The application converts important information into JSON before saving it. When the application starts again, the saved JSON data is retrieved and converted back into Dart objects.

In simpler terms, it works like saving information in a small local storage area so the application does not have to start from zero every time it is opened.

This also allows the basic features to work without requiring an internet connection.

## 6. Project Structure and Code Organization

The project follows an MVVM-style structure. This approach separates the application's data, user interface, and main functions into different files.

The purpose is to keep the code organized and make it easier to understand, maintain, and update.

### Project Directory

```text
food_to_go/
│
├── lib/
│   ├── main.dart
│   │
│   ├── models/
│   │   ├── food_item.dart
│   │   ├── cart_item.dart
│   │   └── order_ticket.dart
│   │
│   ├── viewmodels/
│   │   └── food_to_go_viewmodel.dart
│   │
│   ├── views/
│   │   ├── home_screen.dart
│   │   ├── menu_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── confirmation_screen.dart
│   │   ├── favorites_screen.dart
│   │   ├── food_detail_screen.dart
│   │   └── tickets_screen.dart
│   │
│   └── widgets/
│       └── low_fi_card.dart
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

### 6.1 Model

The Model contains the application's data.

It describes what information each object should have.

The project uses three main model files:

- **food_item.dart** — Stores information about individual food products, such as their ID, name, outlet, description, and price.
- **cart_item.dart** — Stores the selected food item and its quantity in the shopping cart. It also calculates the subtotal.
- **order_ticket.dart** — Stores the information for each generated order ticket, including the ticket ID, ordered items, total amount, status, and archive state. It also handles converting ticket information into JSON and retrieving it from JSON.

### 6.2 View

The View contains the screens and visual components that users interact with.

Each screen has its own responsibility:

- **home_screen.dart** — Displays the available canteen outlets and main navigation options.
- **menu_screen.dart** — Displays the food items available from the selected outlet.
- **cart_screen.dart** — Displays the user's selected food items and manages quantities.
- **confirmation_screen.dart** — Shows the generated ticket number and order confirmation.
- **favorites_screen.dart** — Displays saved food items and allows users to access them directly.
- **food_detail_screen.dart** — Displays additional information about a selected food item.
- **tickets_screen.dart** — Displays active and archived tickets, including the status cycle, archive, restore, and delete functions.
- **low_fi_card.dart** — Contains reusable low-fidelity UI components used to maintain a consistent interface.

### 6.3 ViewModel

The ViewModel acts as the connection between the Model and the View.

In simpler terms, it handles most of the application's important operations so that the individual screens do not have to manage all the data themselves.

The `food_to_go_viewmodel.dart` file handles:

- Providing the list of available outlets and food items.
- Filtering food items based on the selected outlet.
- Adding and removing items from the shopping cart.
- Increasing and decreasing food quantities.
- Calculating item subtotals and the overall total.
- Adding and removing favorite food items.
- Retrieving saved favorites.
- Generating unique order ticket IDs.
- Creating and maintaining order records.
- Cycling through the different ticket statuses.
- Archiving and restoring tickets.
- Permanently deleting tickets.
- Saving and retrieving application data.
- Notifying the interface whenever information changes.

By separating these responsibilities, the application becomes easier to manage because the interface and the actual data-processing functions are not all placed inside one file.

## 7. How the Application Saves Information

Food to Go uses SharedPreferences together with JSON to save its information locally.

The following information is stored:

| Storage Key | Information Saved |
|---|---|
| favorites | IDs of the food items saved as favorites. |
| cart | Food item IDs and their selected quantities. |
| tickets | Ticket IDs, ordered items, prices, totals, dates, statuses, and archive information. |

### How the Saving Process Works

1. When the application starts, the ViewModel initializes SharedPreferences.
2. The application checks if there is previously saved information.
3. If saved information exists, the JSON data is retrieved and converted back into Dart objects.
4. When users add favorites, modify their cart, or manage tickets, the ViewModel updates the information.
5. The updated information is converted into JSON and saved locally.
6. When the application is opened again, the saved information is loaded.

This means that users do not lose their saved favorites, cart information, and order tickets simply because they closed the application.

## 8. Application Navigation

The application uses Flutter's built-in Navigator system to move between screens.

The general navigation flow is:

```text
                 HOME SCREEN
                      |
        +-------------+-------------+
        |             |             |
        v             v             v
       MENU        FAVORITES      TICKETS
        |             |
        v             v
    FOOD ITEMS    FOOD DETAILS
        |             |
        +------+------+
               |
               v
             CART
               |
               v
      ORDER CONFIRMATION
               |
               v
        TICKETS SCREEN
```

Users can also access the Shopping Cart directly from the Home Screen or Menu Screen.

### How Navigation Works

- `Navigator.push()` opens another screen.
- `Navigator.pushReplacement()` replaces the current screen.
- `MaterialPageRoute` defines the screen that will be opened.
- `Navigator.popUntil()` returns to a previous screen based on a specified route.
- `Navigator.pushAndRemoveUntil()` opens a new screen while removing previous navigation routes.

The same ViewModel instance is passed between screens so that the application maintains consistent information when users move from one section to another.

## 9. Functional Testing

The following tests can be performed to check whether the main features are working correctly.

### Home Screen and Menu

- Check if all three canteen outlets are displayed.
- Select an outlet and verify that its corresponding menu appears.
- Check if the correct food names, descriptions, and prices are displayed.

### Shopping Cart

- Add a food item to the cart.
- Increase and decrease its quantity.
- Remove an item from the cart.
- Check if the cart count changes correctly.
- Verify that the subtotal and total price are calculated correctly.

### Favorites

- Mark a food item as a favorite.
- Open the Favorites Screen and check if the selected item appears.
- Open its details directly from Favorites.
- Add a favorite item to the cart.
- Remove an item from Favorites.
- Restart the application and check if the saved favorites remain.

### Order Tickets

- Add food items to the cart and place an order.
- Verify that a unique ticket ID is generated.
- Check if the ticket contains the correct food items and quantities.
- Verify that the total amount is correct.
- Press the status button and check if the status moves to the next stage.
- Continue pressing the button to verify the complete status cycle.
- Archive an active ticket.
- Check if the archived ticket disappears from the Active section.
- Restore the archived ticket.
- Verify that it returns to the Active section.
- Permanently delete a ticket and check if it is removed after confirmation.

### Local Data Storage

- Add items to the cart and restart the application.
- Save favorite food items and check if they remain available.
- Generate tickets and restart the application.
- Verify that active and archived tickets remain saved.
- Test the application without an internet connection.

## 10. Current Limitations

Although the application already supports several working features, there are still some limitations:

- The food menu currently uses sample data instead of retrieving products from an actual canteen database.
- Application information is stored locally rather than in a centralized database.
- Saved information is limited to the device or browser where the application is running.
- Clearing application data or browser storage may remove saved information.
- There is no synchronization between different devices.
- There is no actual online payment system.
- Order status changes are simulated manually within the application.
- There is no separate canteen staff interface for receiving and managing orders.
- Food images are currently represented by placeholders.
- The application is still a prototype and is not yet intended for actual commercial food ordering.

## 11. Possible Future Improvements

The application can still be improved by adding:

- Actual food images and a more polished user interface.
- A centralized database for storing food items, user information, and orders.
- User registration and login.
- A separate interface for canteen staff.
- Real-time order status updates.
- Notifications when an order is ready for pickup.
- Actual payment methods and payment confirmation.
- Automatic food availability updates.
- Better order tracking and pickup identification.
- Cloud synchronization between different devices.

These improvements would help turn the current prototype into a more complete food ordering application.

## 12. Project Status

**Status: Enhanced Flutter Food Ordering Prototype**

Food to Go has progressed from a basic low-fidelity interface into a functional food ordering prototype.

It currently demonstrates food browsing, cart management, favorite food storage, order confirmation, ticket generation, ticket status management, and local data persistence.

The project also demonstrates how the MVVM approach can be used to organize a Flutter application by separating the user interface, data models, and application logic.

Although some features are still simulated and the application does not yet use a centralized database or actual canteen staff system, it provides a working foundation for further development.

**Overall, the purpose of Food to Go is to demonstrate how a simple mobile application can make the campus food ordering process more organized, accessible, and convenient for students.**