
import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';

class FoodToGoViewModel extends ChangeNotifier {
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

  List<CartItem> get cartItems => _cart.values.toList();

  int get cartCount =>
      _cart.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _cart.values.fold(0.0, (sum, item) => sum + item.subtotal);

  List<FoodItem> foodsForOutlet(String outlet) {
    return foods.where((food) => food.outlet == outlet).toList();
  }

  void addToCart(FoodItem food) {
    if (_cart.containsKey(food.id)) {
      _cart[food.id]!.quantity++;
    } else {
      _cart[food.id] = CartItem(food: food);
    }

    notifyListeners();
  }

  void decreaseQuantity(int foodId) {
    final item = _cart[foodId];
    if (item == null) return;

    item.quantity--;

    if (item.quantity <= 0) {
      _cart.remove(foodId);
    }

    notifyListeners();
  }

  void increaseQuantity(int foodId) {
    final item = _cart[foodId];
    if (item == null) return;

    item.quantity++;
    notifyListeners();
  }

  void removeFromCart(int foodId) {
    _cart.remove(foodId);
    notifyListeners();
  }

  void placeOrder() {
    _cart.clear();
    notifyListeners();
  }
}
