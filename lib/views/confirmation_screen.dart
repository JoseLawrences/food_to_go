import 'package:flutter/material.dart';

import '../models/order_ticket.dart';
import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';
import 'tickets_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final OrderTicket ticket;
  final FoodToGoViewModel viewModel;

  const ConfirmationScreen({
    super.key,
    required this.ticket,
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
        child: SingleChildScrollView(
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
                const SizedBox(height: 12),
                const Text('Your order ticket has been saved.'),
                const Divider(color: Colors.black),
                const Text(
                  'YOUR TICKET NUMBER',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                SelectableText(
                  ticket.ticketId,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...ticket.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.quantity}x ${item.name}',
                          ),
                        ),
                        Text(
                          'PHP ${item.subtotal.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(color: Colors.black),
                Text(
                  'TOTAL: PHP ${ticket.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Status: PENDING'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: WireframeButton(
                    label: 'VIEW MY TICKETS',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketsScreen(
                            viewModel: viewModel,
                          ),
                        ),
                        (route) => route.isFirst,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: WireframeButton(
                    label: 'BACK TO HOME',
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
