
import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';

class FoodDetailScreen extends StatelessWidget {
  final FoodItem food;
  final FoodToGoViewModel viewModel;

  const FoodDetailScreen({
    super.key,
    required this.food,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FOOD DETAILS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LowFiCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const WireframeImage(),
              const SizedBox(height: 16),
              Text(
                food.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Outlet: ${food.outlet}'),
              const SizedBox(height: 8),
              Text(food.description),
              const SizedBox(height: 8),
              Text(
                'PHP ${food.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              AnimatedBuilder(
                animation: viewModel,
                builder: (context, child) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          viewModel.toggleFavorite(food);
                        },
                        icon: Icon(
                          viewModel.isFavorite(food.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                      ),
                      const Text('Favorite'),
                    ],
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: WireframeButton(
                  label: 'ADD TO CART',
                  onPressed: () async {
                    await viewModel.addToCart(food);

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${food.name} added to cart.'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
