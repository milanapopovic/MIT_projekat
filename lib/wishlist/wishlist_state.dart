import 'package:flutter/foundation.dart';

class WishlistItem {
  final String productId;
  final String title;
  final String category;
  final int priceRsd;
  final String imageUrl;
  final String description;

  const WishlistItem({
    required this.productId,
    required this.title,
    required this.category,
    required this.priceRsd,
    required this.imageUrl,
    this.description = "",
  });
}

class WishlistState extends ChangeNotifier {
  final List<WishlistItem> _items = [];

  List<WishlistItem> get items => List.unmodifiable(_items);

  bool contains(String productId) {
    return _items.any((e) => e.productId == productId);
  }

  void add({
    required String productId,
    required String title,
    required String category,
    required int priceRsd,
    required String imageUrl,
    String description = "",
  }) {
    if (contains(productId)) return;
    _items.add(
      WishlistItem(
        productId: productId,
        title: title,
        category: category,
        priceRsd: priceRsd,
        imageUrl: imageUrl,
        description: description,
      ),
    );
    notifyListeners();
  }

  void remove(String productId) {
    _items.removeWhere((e) => e.productId == productId);
    notifyListeners();
  }

  void toggle({
    required String productId,
    required String title,
    required String category,
    required int priceRsd,
    required String imageUrl,
    String description = "",
  }) {
    if (contains(productId)) {
      remove(productId);
    } else {
      add(
        productId: productId,
        title: title,
        category: category,
        priceRsd: priceRsd,
        imageUrl: imageUrl,
        description: description,
      );
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
