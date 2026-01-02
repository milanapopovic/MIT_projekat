import 'package:fashion_app1/widgets/brand_app_bar_title';
import 'package:fashion_app1/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool cartIsEmpty = true;
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
       body: cartIsEmpty
          ? EmptyCartWidget(
              onShopNow: () {             
              },
            )
          : const SizedBox.shrink(),
    );
  }
}