
import 'package:flutter/material.dart';
import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';

class ConfirmationScreen extends StatelessWidget {
  final FoodToGoViewModel viewModel;

  const ConfirmationScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORDER CONFIRMATION'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: LowFiCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 65,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Order Placed!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your sample order has been confirmed.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'This is a prototype. No real payment or order '
                  'submission is performed.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                WireframeButton(
                  label: 'Back to Home',
                  onPressed: () {
                    viewModel.placeOrder();
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
