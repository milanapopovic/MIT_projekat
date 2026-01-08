import 'package:flutter/foundation.dart';

class CartItem {
  final String id; 
  final String title;
  final String category;
  final int priceRsd;
  final String imageUrl;
  final  List<String> sizes;
  final String description;
  final String? size;
  int qty;

  CartItem({
    required this.id,
    required this.title,
    required this.category,
    required this.priceRsd,
    required this.imageUrl,
    required this.qty,
    required this.sizes,
    required this.description,
    this.size,
  });

  int get subtotal => priceRsd * qty;
}

class CartState extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  bool get isEmpty => _items.isEmpty;

  int get totalRsd {
    int sum = 0;
    for (final it in _items.values) {
      sum += it.subtotal;
    }
    return sum;
  }

  void addItem({
    required String productId,
    required String title,
    required String category,
    required int priceRsd,
    required String imageUrl,
    required List<String> sizes,
    required String description,
    String? size,
    int qty = 1,
  }) {
    final key = "${productId}_${size ?? 'nosize'}";

    if (_items.containsKey(key)) {
      _items[key]!.qty += qty;
    } else {
      _items[key] = CartItem(
        id: key,
        title: title,
        category: category,
        priceRsd: priceRsd,
        imageUrl: imageUrl,
        size: size,
        qty: qty,
        sizes : sizes,
        description: description,
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
