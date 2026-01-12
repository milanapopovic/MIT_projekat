import 'package:flutter/foundation.dart';

class OrderLine {
  final String title;
  final String category;
  final int priceRsd;
  final String imageUrl;
  final String? size;
  final int qty;

  const OrderLine({
    required this.title,
    required this.category,
    required this.priceRsd,
    required this.imageUrl,
    required this.qty,
    this.size,
  });

  int get subtotalRsd => priceRsd * qty;
}

class OrderItem {
  final String orderNumber; 
  final DateTime date;
  final int totalRsd;

  final int subtotalRsd;
  final int deliveryFeeRsd;
  final String deliveryMethod; 
  final String paymentMethod;  

  final List<OrderLine> lines;

  const OrderItem({
    required this.orderNumber,
    required this.date,
    required this.totalRsd,
    required this.subtotalRsd,
    required this.deliveryFeeRsd,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.lines,
  });
}

class OrdersState extends ChangeNotifier {
  final List<OrderItem> _orders = [];
  int _counter = 0;

  List<OrderItem> get orders => List.unmodifiable(_orders);

  String _nextOrderNumber() {
    _counter += 1;
    return _counter.toString().padLeft(5, '0');
  }

  void addOrder({
    required int subtotalRsd,
    required int deliveryFeeRsd,
    required int totalRsd,
    required String deliveryMethod,
    required String paymentMethod,
    required List<OrderLine> lines,
  }) {
    final newOrder = OrderItem(
      orderNumber: _nextOrderNumber(),
      date: DateTime.now(),
      totalRsd: totalRsd,
      subtotalRsd: subtotalRsd,
      deliveryFeeRsd: deliveryFeeRsd,
      deliveryMethod: deliveryMethod,
      paymentMethod: paymentMethod,
      lines: lines,
    );

    _orders.insert(0, newOrder);
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
