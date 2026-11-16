
import 'package:flutter/material.dart';

import '../models/order_ticket.dart';
import '../viewmodels/food_to_go_viewmodel.dart';
import '../widgets/low_fi_card.dart';

class TicketsScreen extends StatelessWidget {
  final FoodToGoViewModel viewModel;

  const TicketsScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY ORDER TICKETS'),
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          final tickets = viewModel.tickets;

          if (tickets.isEmpty) {
            return const Center(
              child: Text('No order tickets available.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _TicketCard(
                  ticket: ticket,
                  viewModel: viewModel,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final OrderTicket ticket;
  final FoodToGoViewModel viewModel;

  const _TicketCard({
    required this.ticket,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LowFiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FOOD TO GO',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.black),
          Text(
            'Ticket ID: ${ticket.ticketId}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Date: ${ticket.dateCreated.toLocal()}',
          ),
          const SizedBox(height: 12),
          const Text(
            'ORDER ITEMS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ...ticket.items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'PHP ${ticket.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'STATUS: ${ticket.status.toUpperCase()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Prototype status controls.
          // These simulate canteen staff updating an order.
          Wrap(
            spacing: 6,
            children: [
              'Pending',
              'Preparing',
              'Ready',
              'Completed',
            ].map((status) {
              return OutlinedButton(
                onPressed: () {
                  viewModel.updateTicketStatus(
                    ticket.ticketId,
                    status,
                  );
                },
                child: Text(status),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
