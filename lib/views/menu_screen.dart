
import 'package:flutter/material.dart';
import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';
import 'cart_screen.dart';

class MenuScreen extends StatelessWidget {
  final FoodToGoViewModel viewModel;
  final String outlet;

  const MenuScreen({
    super.key,
    required this.viewModel,
    required this.outlet,
  });

  @override
  Widget build(BuildContext context) {
    final foods = viewModel.foodsForOutlet(outlet);

    return Scaffold(
      appBar: AppBar(
        title: Text(outlet),
        actions: [
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(
                        viewModel: viewModel,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Cart (${viewModel.cartCount})',
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '$outlet Menu',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select your food and add it to your cart.',
          ),
          const SizedBox(height: 16),
          ...foods.map((food) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LowFiCard(
                child: Row(
                  children: [
                    const WireframeImage(),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(food.description),
                          Text(
                            'PHP ${food.price.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                    WireframeButton(
                      label: 'Add',
                      onPressed: () {
                        viewModel.addToCart(food);

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(
                                '${food.name} added to cart',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
