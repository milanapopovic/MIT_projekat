import 'package:flutter/material.dart';
import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String title;
  final String category;
  final int priceRsd;
  final String imageUrl;

  final List<String> sizes;
  final String description;

  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.priceRsd,
    required this.imageUrl,
    this.sizes = const ["S", "M", "L", "XL"],
    this.description = "",
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
    selectedSize = null;  
    }
    bool _hasSizes() {
      return widget.category != 'bags' &&
      widget.category != 'accessories' &&
      widget.sizes.isNotEmpty;
    }


  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              setState(() {
                isWishlisted = !isWishlisted;
              });
            },
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
                  children: widget.sizes.map((s) {
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      _hasSizes()
                                          ? "Privremeno: Add to cart ($selectedSize)"
                                          : "Privremeno: Add to cart",
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
                    onPressed: () {
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });
                    },
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
