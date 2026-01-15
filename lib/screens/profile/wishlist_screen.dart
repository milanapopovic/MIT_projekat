import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/screens/home_screen.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:fashion_app1/widgets/page_header_widget.dart';
import 'package:fashion_app1/widgets/product_widget.dart';
import 'package:fashion_app1/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const BrandAppBarTitle(title: 'Fashion Store'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PageHeader(title: 'Wishlist'),

          Expanded(
            child: Consumer<WishlistState>(
              builder: (context, wish, _) {
                if (wish.items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bookmark_border,
                            size: 52,
                            color: AppColors.brand.withAlpha(180),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Your wishlist is empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Save items you like and come back later.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: 200,
                            height: 46,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.brandSoft,
                                foregroundColor: AppColors.brand,
                                side: BorderSide(color: AppColors.brandBorder),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Continue shopping',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: wish.items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final p = wish.items[index];

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: ProductWidget(
                              title: p.title,
                              category: p.category,
                              priceRsd: p.priceRsd,
                              imageUrl: p.imageUrl,
                              description: p.description,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Material(
                              color: Colors.white,
                              shape: const CircleBorder(),
                              child: IconButton(
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 34,
                                  minHeight: 34,
                                ),
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  context.read<WishlistState>().remove(
                                    p.productId,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
