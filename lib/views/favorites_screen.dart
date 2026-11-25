import 'package:flutter/material.dart';

import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';
import 'food_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final FoodToGoViewModel viewModel;

  const FavoritesScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY FAVORITES'),
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          final favorites = viewModel.favoriteFoods;

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 60,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'You have no favorite foods yet.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add foods from the menu to see them here.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final food = favorites[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LowFiCard(
                  child: Row(
                    children: [
                      const WireframeImage(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FoodDetailScreen(
                                  food: food,
                                  viewModel: viewModel,
                                ),
                              ),
                            );
                          },
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
                              Text(food.outlet),
                              Text(
                                'PHP ${food.price.toStringAsFixed(2)}',
                              ),
                              Text(
                                food.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                'Tap to view details',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            tooltip: 'Remove favorite',
                            onPressed: () async {
                              await viewModel.toggleFavorite(food);

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${food.name} removed from favorites.',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            tooltip: 'Add to cart',
                            onPressed: () async {
                              await viewModel.addToCart(food);

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${food.name} added to cart.',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
