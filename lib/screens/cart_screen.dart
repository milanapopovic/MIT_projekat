import 'package:fashion_app1/cart/cart_state.dart';
import 'package:fashion_app1/screens/checkout_screen.dart';
import 'package:fashion_app1/screens/product_details_screen.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:fashion_app1/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CartScreen extends StatelessWidget {
  final VoidCallback onContinueShopping;
  const CartScreen({super.key, required this.onContinueShopping});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartState>();
    return Scaffold(
      appBar: AppBar(
        title: const BrandAppBarTitle(title: 'Fashion Store'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
       body: cart.isEmpty
          ? EmptyCartWidget(
              onShopNow: onContinueShopping,
            )
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final it = cart.items[i];

                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailsScreen(
                                  title: it.title,
                                  category: it.category,
                                  priceRsd: it.priceRsd,
                                  imageUrl: it.imageUrl,
                                  description: it.description,
                                  initialSelectedSize: it.size,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    it.imageUrl,
                                    width: 72,
                                    height: 72,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 72,
                                      height: 72,
                                      color: Colors.black12,
                                      child: const Icon(Icons.image),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        it.title,
                                        style: const TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 4),
                                      Text("${_formatPrice(it.priceRsd)} RSD"),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Qty: ${it.qty}${it.size != null ? " | Size: ${it.size}" : ""}",
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SizedBox(
                                  height: 36,
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.red.shade400,
                                    ),
                                    onPressed: () {
                                      context.read<CartState>().removeItem(it.id);
                                    },
                                    child: const Text("Remove"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Total: ${_formatPrice(cart.totalRsd)} RSD",
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 44,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                              );
                            },
                            child: const Text("Checkout"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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