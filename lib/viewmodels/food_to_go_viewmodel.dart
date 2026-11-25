import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../models/order_ticket.dart';

class FoodToGoViewModel extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool isInitialized = false;

  final List<String> outlets = [
    'WaffleTime',
    'Burp’nGo',
    'Coffee Shop',
  ];

  final List<FoodItem> foods = const [
    FoodItem(
      id: 1,
      name: 'Classic Waffle',
      outlet: 'WaffleTime',
      price: 45,
      description: 'Plain waffle',
    ),
    FoodItem(
      id: 2,
      name: 'Chocolate Waffle',
      outlet: 'WaffleTime',
      price: 60,
      description: 'Waffle with chocolate',
    ),
    FoodItem(
      id: 3,
      name: 'Cheese Waffle',
      outlet: 'WaffleTime',
      price: 55,
      description: 'Waffle with cheese',
    ),
    FoodItem(
      id: 4,
      name: 'Classic Burger',
      outlet: 'Burp’nGo',
      price: 65,
      description: 'Burger with vegetables',
    ),
    FoodItem(
      id: 5,
      name: 'Cheese Burger',
      outlet: 'Burp’nGo',
      price: 80,
      description: 'Burger with cheese',
    ),
    FoodItem(
      id: 6,
      name: 'French Fries',
      outlet: 'Burp’nGo',
      price: 40,
      description: 'Crispy fries',
    ),
    FoodItem(
      id: 7,
      name: 'Iced Coffee',
      outlet: 'Coffee Shop',
      price: 50,
      description: 'Cold coffee',
    ),
    FoodItem(
      id: 8,
      name: 'Hot Coffee',
      outlet: 'Coffee Shop',
      price: 45,
      description: 'Hot brewed coffee',
    ),
    FoodItem(
      id: 9,
      name: 'Chocolate Drink',
      outlet: 'Coffee Shop',
      price: 55,
      description: 'Chocolate beverage',
    ),
  ];

  final Map<int, CartItem> _cart = {};
  final Set<int> _favorites = {};
  final List<OrderTicket> _tickets = [];

  // STATUS CYCLE

  static const List<String> ticketStatuses = [
    'Pending',
    'Preparing',
    'Ready',
    'Completed',
  ];

  // GETTERS

  List<CartItem> get cartItems => _cart.values.toList();

  // Active tickets only.
  List<OrderTicket> get tickets => activeTickets;

  List<OrderTicket> get activeTickets => List.unmodifiable(
        _tickets.where((ticket) => !ticket.isArchived),
      );

  List<OrderTicket> get archivedTickets => List.unmodifiable(
        _tickets.where((ticket) => ticket.isArchived),
      );

  List<FoodItem> get favoriteFoods =>
      foods.where((food) => _favorites.contains(food.id)).toList();

  bool isFavorite(int foodId) => _favorites.contains(foodId);

  int get cartCount => _cart.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _cart.values.fold(0.0, (sum, item) => sum + item.subtotal);

  List<FoodItem> foodsForOutlet(String outlet) {
    return foods.where((food) => food.outlet == outlet).toList();
  }

  FoodItem? foodById(int id) {
    try {
      return foods.firstWhere((food) => food.id == id);
    } catch (_) {
      return null;
    }
  }

  // INITIALIZE AND LOAD SAVED DATA

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();

    _loadFavorites();
    _loadCart();
    _loadTickets();

    isInitialized = true;
    notifyListeners();
  }

  // SAVE DATA

  Future<void> _saveData() async {
    await _prefs.setString(
      'favorites',
      jsonEncode(_favorites.toList()),
    );

    await _prefs.setString(
      'cart',
      jsonEncode(
        _cart.values
            .map((item) => {
                  'foodId': item.food.id,
                  'quantity': item.quantity,
                })
            .toList(),
      ),
    );

    await _prefs.setString(
      'tickets',
      jsonEncode(
        _tickets.map((ticket) => ticket.toJson()).toList(),
      ),
    );
  }

  // LOAD FAVORITES

  void _loadFavorites() {
    final data = _prefs.getString('favorites');

    if (data == null) return;

    try {
      final List decoded = jsonDecode(data);
      _favorites.addAll(decoded.map((id) => id as int));
    } catch (_) {
      _favorites.clear();
    }
  }

  // LOAD CART

  void _loadCart() {
    final data = _prefs.getString('cart');

    if (data == null) return;

    try {
      final List decoded = jsonDecode(data);

      for (final item in decoded) {
        final food = foodById(item['foodId']);

        if (food != null) {
          _cart[food.id] = CartItem(
            food: food,
            quantity: item['quantity'],
          );
        }
      }
    } catch (_) {
      _cart.clear();
    }
  }

  // LOAD TICKETS

  void _loadTickets() {
    final data = _prefs.getString('tickets');

    if (data == null) return;

    try {
      final List decoded = jsonDecode(data);

      _tickets.addAll(
        decoded.map(
          (item) => OrderTicket.fromJson(item),
        ),
      );
    } catch (_) {
      _tickets.clear();
    }
  }

  // FAVORITES

  Future<void> toggleFavorite(FoodItem food) async {
    if (_favorites.contains(food.id)) {
      _favorites.remove(food.id);
    } else {
      _favorites.add(food.id);
    }

    notifyListeners();
    await _saveData();
  }

  // CART

  Future<void> addToCart(FoodItem food) async {
    if (_cart.containsKey(food.id)) {
      _cart[food.id]!.quantity++;
    } else {
      _cart[food.id] = CartItem(food: food);
    }

    notifyListeners();
    await _saveData();
  }

  Future<void> increaseQuantity(int foodId) async {
    final item = _cart[foodId];
    if (item == null) return;

    item.quantity++;

    notifyListeners();
    await _saveData();
  }

  Future<void> decreaseQuantity(int foodId) async {
    final item = _cart[foodId];
    if (item == null) return;

    item.quantity--;

    if (item.quantity <= 0) {
      _cart.remove(foodId);
    }

    notifyListeners();
    await _saveData();
  }

  Future<void> removeFromCart(int foodId) async {
    _cart.remove(foodId);

    notifyListeners();
    await _saveData();
  }

  // TICKET GENERATION

  Future<OrderTicket?> placeOrder() async {
    if (_cart.isEmpty) return null;

    final now = DateTime.now();

    final ticket = OrderTicket(
      ticketId: 'FTG-${now.millisecondsSinceEpoch}',
      dateCreated: now,
      items: _cart.values.map((item) {
        return TicketItem(
          foodId: item.food.id,
          name: item.food.name,
          outlet: item.food.outlet,
          price: item.food.price,
          quantity: item.quantity,
        );
      }).toList(),
      total: totalPrice,
    );

    _tickets.insert(0, ticket);
    _cart.clear();

    notifyListeners();
    await _saveData();

    return ticket;
  }

  // FIND TICKET

  OrderTicket? _findTicket(String ticketId) {
    try {
      return _tickets.firstWhere(
        (ticket) => ticket.ticketId == ticketId,
      );
    } catch (_) {
      return null;
    }
  }

  // CYCLE TICKET STATUS
  // Pending -> Preparing -> Ready -> Completed -> Pending

  Future<void> cycleTicketStatus(String ticketId) async {
    final ticket = _findTicket(ticketId);

    if (ticket == null || ticket.isArchived) return;

    final currentIndex = ticketStatuses.indexOf(ticket.status);

    final nextIndex =
        currentIndex == -1 ? 0 : (currentIndex + 1) % ticketStatuses.length;

    ticket.status = ticketStatuses[nextIndex];

    notifyListeners();
    await _saveData();
  }

  // MANUAL STATUS UPDATE (KEPT FOR COMPATIBILITY)

  Future<void> updateTicketStatus(
    String ticketId,
    String newStatus,
  ) async {
    final ticket = _findTicket(ticketId);

    if (ticket == null || ticket.isArchived) return;
    if (!ticketStatuses.contains(newStatus)) return;

    ticket.status = newStatus;

    notifyListeners();
    await _saveData();
  }

  // SOFT DELETE / ARCHIVE

  Future<void> archiveTicket(String ticketId) async {
    final ticket = _findTicket(ticketId);

    if (ticket == null) return;

    ticket.isArchived = true;

    notifyListeners();
    await _saveData();
  }

  // RESTORE ARCHIVED TICKET

  Future<void> restoreTicket(String ticketId) async {
    final ticket = _findTicket(ticketId);

    if (ticket == null) return;

    ticket.isArchived = false;

    notifyListeners();
    await _saveData();
  }

  // PERMANENT DELETE

  Future<void> deleteTicket(String ticketId) async {
    _tickets.removeWhere(
      (ticket) => ticket.ticketId == ticketId,
    );

    notifyListeners();
    await _saveData();
  }
}
