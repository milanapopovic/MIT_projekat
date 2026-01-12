import 'package:flutter/material.dart';
import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:fashion_app1/orders/orders_state.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderItem order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BrandAppBarTitle(title: 'Fashion Store'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "Order #${order.orderNumber}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              "${_formatDate(order.date)} • ${_formatPrice(order.totalRsd)} RSD",
              style: const TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.brandLine),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Items", style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  ...order.lines.map((it) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              it.imageUrl,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 56,
                                height: 56,
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
                                Text(it.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                                const SizedBox(height: 4),
                                Text(
                                  "Qty: ${it.qty}${it.size != null ? " | Size: ${it.size}" : ""}",
                                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "${_formatPrice(it.subtotalRsd)} RSD",
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.brandLine),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  _row("Subtotal", "${_formatPrice(order.subtotalRsd)} RSD"),
                  const SizedBox(height: 6),
                  _row("Delivery", "${_formatPrice(order.deliveryFeeRsd)} RSD"),
                  const Divider(height: 18),
                  _row("Total", "${_formatPrice(order.totalRsd)} RSD", isTotal: true),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Delivery: ${order.deliveryMethod} • Payment: ${order.paymentMethod}",
                      style: const TextStyle(color: Colors.black54, fontSize: 12),
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

  Widget _row(String left, String right, {bool isTotal = false}) {
    return Row(
      children: [
        Text(left, style: TextStyle(fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600)),
        const Spacer(),
        Text(right, style: TextStyle(fontWeight: isTotal ? FontWeight.w900 : FontWeight.w800)),
      ],
    );
  }

  String _formatDate(DateTime d) => '${d.day}.${d.month}.${d.year}.';

  String _formatPrice(int price) {
    final s = price.toString();
    if (s.length <= 3) return s;
    final head = s.substring(0, s.length - 3);
    final tail = s.substring(s.length - 3);
    return "$head $tail";
  }
}
