
import 'package:flutter/material.dart';
import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';
import 'confirmation_screen.dart';

class CartScreen extends StatelessWidget {
  final FoodToGoViewModel viewModel;

  const CartScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR CART'),
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          final items = viewModel.cartItems;

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 55,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    WireframeButton(
                      label: 'Continue Shopping',
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: LowFiCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.food.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'PHP ${item.food.price.toStringAsFixed(2)} each',
                            ),
                            Text(
                              'Subtotal: PHP ${item.subtotal.toStringAsFixed(2)}',
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              crossAxisAlignment:
                                  WrapCrossAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    viewModel.decreaseQuantity(
                                      item.food.id,
                                    );
                                  },
                                  child: const Text('-'),
                                ),
                                Text('${item.quantity}'),
                                OutlinedButton(
                                  onPressed: () {
                                    viewModel.increaseQuantity(
                                      item.food.id,
                                    );
                                  },
                                  child: const Text('+'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    viewModel.removeFromCart(
                                      item.food.id,
                                    );
                                  },
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total: PHP ${viewModel.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    WireframeButton(
                      label: 'Place Order',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ConfirmationScreen(
                              viewModel: viewModel,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
