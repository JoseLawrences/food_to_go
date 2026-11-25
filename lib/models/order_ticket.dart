//import 'food_item.dart';

class OrderTicket {
  final String ticketId;
  final DateTime dateCreated;
  final List<TicketItem> items;
  final double total;
  String status;
  bool isArchived;

  OrderTicket({
    required this.ticketId,
    required this.dateCreated,
    required this.items,
    required this.total,
    this.status = 'Pending',
    this.isArchived = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'dateCreated': dateCreated.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'status': status,
      'isArchived': isArchived,
    };
  }

  factory OrderTicket.fromJson(Map<String, dynamic> json) {
    return OrderTicket(
      ticketId: json['ticketId'],
      dateCreated: DateTime.parse(json['dateCreated']),
      items: (json['items'] as List)
          .map((item) => TicketItem.fromJson(item))
          .toList(),
      total: (json['total'] as num).toDouble(),
      status: json['status'] ?? 'Pending',
      isArchived: json['isArchived'] ?? false,
    );
  }
}

class TicketItem {
  final int foodId;
  final String name;
  final String outlet;
  final double price;
  final int quantity;

  TicketItem({
    required this.foodId,
    required this.name,
    required this.outlet,
    required this.price,
    required this.quantity,
  });

  double get subtotal => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'name': name,
      'outlet': outlet,
      'price': price,
      'quantity': quantity,
    };
  }

  factory TicketItem.fromJson(Map<String, dynamic> json) {
    return TicketItem(
      foodId: json['foodId'],
      name: json['name'],
      outlet: json['outlet'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}
