import 'package:fashion_app1/auth/auth_state.dart';
import 'package:fashion_app1/cart/cart_state.dart';
import 'package:fashion_app1/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String title;
  final String category;
  final int priceRsd;
  final String imageUrl;
  final String? initialSelectedSize;

  final List<String> sizes; 
  final String description; 

  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.priceRsd,
    required this.imageUrl,
    this.sizes = const [],
    this.description = "",
    this.initialSelectedSize,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedSize;
  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    final showSizes = _sizesToShow();

  if (widget.initialSelectedSize != null &&
      showSizes.contains(widget.initialSelectedSize)) {
        selectedSize = widget.initialSelectedSize;
  } else {
    selectedSize = null;
  }
    }
    bool _hasSizes() {
      return widget.category != 'bags' &&
      widget.category != 'accessories' &&
      _sizesToShow().isNotEmpty;
    }
  List<String> _sizesForCategory(String category) {
    final c = category.toLowerCase();

    if (c == 'shoes') return const ['36', '37', '38', '39', '40', '41'];
    if (c == 'jeans' || c == 'pants' || c == 'skirts' || c == 'shorts') {
      return const ['34', '36', '38', '40', '42', '44'];
    }
    if (c == 't-shirts' ||
        c == 'tops' ||
        c == 'hoodies' ||
        c == 'sweaters' ||
        c == 'jackets' ||
        c == 'coats' ||
        c == 'blazers') {
      return const ['XS', 'S', 'M', 'L', 'XL'];
    }
    return const ['S', 'M', 'L', 'XL'];
  }

  List<String> _sizesToShow() {
    if (widget.sizes.isNotEmpty) return widget.sizes;
    return _sizesForCategory(widget.category);
  }
  bool _canUserInteract({required String actionName}) {
    final auth = context.read<AuthState>();

    if (auth.isGuest || auth.email == null) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        const SnackBar(content: Text('You must be logged in')),
      );
      return false;
    }

    if (auth.isAdmin) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(content: Text('Admin is not allowed to  $actionName')),
      );
      return false;
    }

    return true;
  }

  void _toggleWishlist(String productId, bool isWishlisted) {
    if (!_canUserInteract(actionName: 'add items to the wishlist')) return;

    context.read<WishlistState>().toggle(
          productId: productId,
          title: widget.title,
          category: widget.category,
          priceRsd: widget.priceRsd,
          imageUrl: widget.imageUrl,
          description: widget.description,
        );

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          isWishlisted ? "Removed from wishlist" : "Added to wishlist",
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final productId = widget.title.toLowerCase().replaceAll(' ', '_');
    final isWishlisted = context.watch<WishlistState>().contains(productId);
    return Scaffold(
      appBar: AppBar(
        title: const BrandAppBarTitle(title: 'Fashion Store'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () => _toggleWishlist(productId, isWishlisted),       
          ),
        ],

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  widget.imageUrl,
                  height: 360, 
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 360,
                    color: AppColors.brandSoft,
                    child: const Center(child: Icon(Icons.image, size: 50)),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    "Price:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  Text(
                    "${_formatPrice(widget.priceRsd)} RSD",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.brand,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (_hasSizes()) ...[
                const Text(
                  "Size:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),

                Wrap(
                  spacing: 10,
                  children: _sizesToShow().map((s) {
                    final isSelected = (s == selectedSize);
                    return ChoiceChip(
                      label: Text(s),
                      selected: isSelected,
                      onSelected: (_) => setState(() => selectedSize = s),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 18),
              ],

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (!_hasSizes() || selectedSize != null)
                              ? Colors.green.shade400
                              : Colors.grey.shade400,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: (_hasSizes() && selectedSize == null)
                          ? null
                          : () {
                              if (!_canUserInteract(
                                    actionName: 'add items to the cart')) {
                                  return;
                                }

                              context.read<CartState>().addItem(
                                    productId: productId,
                                    title: widget.title,
                                    category: widget.category,
                                    priceRsd: widget.priceRsd,
                                    imageUrl: widget.imageUrl,
                                    sizes: _sizesToShow(),
                                    description: widget.description,
                                    size: _hasSizes() ? selectedSize : null,
                                    qty: 1,
                                  );

                              final messenger = ScaffoldMessenger.of(context);
                              messenger.hideCurrentSnackBar();
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _hasSizes()
                                        ? "Added to cart ($selectedSize)"
                                        : "Added to cart",
                                  ),
                                ),
                              );
                            },
                        child: const Text("Add to cart"),
                      ),

                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: Icon(
                      isWishlisted ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.black,
                    ),
                    onPressed: () => _toggleWishlist(productId, isWishlisted),
                  ),

                ],
              ),
              const SizedBox(height: 20),

                if (widget.description.trim().isNotEmpty) ...[
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.description),
                ],

            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    final s = price.toString();
    if (s.length <= 3) return s;
    final head = s.substring(0, s.length - 3);
    final tail = s.substring(s.length - 3);
    return "$head $tail";
  }
}
