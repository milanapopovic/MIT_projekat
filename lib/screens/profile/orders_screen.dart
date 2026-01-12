import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/orders/orders_state.dart';
import 'package:fashion_app1/screens/profile/order_details_screen.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:fashion_app1/widgets/page_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final orders = context.watch<OrdersState>().orders;
 

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        elevation: 0,
        title: const BrandAppBarTitle(title: 'Fashion Store'),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PageHeader(title: 'All orders'),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: orders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 54,
                            color: AppColors.brand.withAlpha(180),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'No orders yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Your completed orders will appear here.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: orders.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final o = orders[index];
                        final preview = _buildPreview(o);
                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => OrderDetailsScreen(order: o)),
                            );
                          },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.brandLine),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(10),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: AppColors.brand.withAlpha(200),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order #${o.orderNumber}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                     '${_formatDate(o.date)} • ${_formatPrice(o.totalRsd)} RSD',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
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
  String _buildPreview(OrderItem o) {
  if (o.lines.isEmpty) return "";
  final firstTwo = o.lines.take(2).map((it) => "${it.title} x${it.qty}").toList();
  final rest = o.lines.length - firstTwo.length;
  return rest > 0 ? "${firstTwo.join(", ")} + $rest more" : firstTwo.join(", ");
}

}



