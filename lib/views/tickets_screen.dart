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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MY ORDER TICKETS'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.receipt_long),
                text: 'Active',
              ),
              Tab(
                icon: Icon(Icons.archive_outlined),
                text: 'Archived',
              ),
            ],
          ),
        ),
        body: AnimatedBuilder(
          animation: viewModel,
          builder: (context, child) {
            return TabBarView(
              children: [
                _buildTicketList(
                  context,
                  viewModel.activeTickets,
                  false,
                ),
                _buildTicketList(
                  context,
                  viewModel.archivedTickets,
                  true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTicketList(
    BuildContext context,
    List<OrderTicket> tickets,
    bool isArchived,
  ) {
    if (tickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isArchived ? Icons.archive_outlined : Icons.receipt_long,
              size: 55,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(
              isArchived
                  ? 'No archived tickets.'
                  : 'No active tickets available.',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _TicketCard(
            ticket: tickets[index],
            viewModel: viewModel,
            isArchived: isArchived,
          ),
        );
      },
    );
  }
}

class _TicketCard extends StatelessWidget {
  final OrderTicket ticket;
  final FoodToGoViewModel viewModel;
  final bool isArchived;

  const _TicketCard({
    required this.ticket,
    required this.viewModel,
    required this.isArchived,
  });

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: const Text('Delete Ticket?'),
              content: Text(
                'Are you sure you want to permanently delete '
                'ticket ${ticket.ticketId}? '
                'This action cannot be undone.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext, true);
                  },
                  child: const Text('Delete Permanently'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _deleteTicket(BuildContext context) async {
    final confirmed = await _confirmDelete(context);

    if (!confirmed || !context.mounted) return;

    await viewModel.deleteTicket(ticket.ticketId);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ticket permanently deleted.'),
      ),
    );
  }

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

          const SizedBox(height: 12),

          // CURRENT STATUS

          const Text(
            'ORDER STATUS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              ticket.status.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ACTIVE TICKET CONTROLS

          if (!isArchived) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.autorenew),
                label: Text(
                  'NEXT STATUS: ${_nextStatus()}',
                ),
                onPressed: () async {
                  await viewModel.cycleTicketStatus(
                    ticket.ticketId,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.archive_outlined),
                    label: const Text('Archive'),
                    onPressed: () async {
                      await viewModel.archiveTicket(
                        ticket.ticketId,
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ticket moved to archive.'),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () => _deleteTicket(context),
                  ),
                ),
              ],
            ),
          ],

          // ARCHIVED TICKET CONTROLS

          if (isArchived) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.restore),
                    label: const Text('Restore'),
                    onPressed: () async {
                      await viewModel.restoreTicket(
                        ticket.ticketId,
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ticket restored.'),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () => _deleteTicket(context),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _nextStatus() {
    const statuses = [
      'Pending',
      'Preparing',
      'Ready',
      'Completed',
    ];

    final index = statuses.indexOf(ticket.status);

    if (index == -1) return 'Pending';

    return statuses[(index + 1) % statuses.length];
  }
}
