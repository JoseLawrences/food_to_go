
import 'package:flutter/material.dart';
import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  final FoodToGoViewModel viewModel;

  const HomeScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FOOD TO GO'),
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
          const Text(
            'Welcome to Food to Go!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose a canteen outlet to browse its menu.',
          ),
          const SizedBox(height: 20),
          const Text(
            'AVAILABLE OUTLETS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...viewModel.outlets.map((outlet) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LowFiCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WireframeImage(),
                    const SizedBox(height: 10),
                    Text(
                      outlet,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'View available food and drinks.',
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: WireframeButton(
                        label: 'View Menu',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MenuScreen(
                                viewModel: viewModel,
                                outlet: outlet,
                              ),
                            ),
                          );
                        },
                      ),
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
