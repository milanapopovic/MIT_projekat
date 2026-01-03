import 'package:flutter/material.dart';

class BrandAppBarTitle extends StatelessWidget {
  final String title;
  const BrandAppBarTitle({super.key, this.title = 'Fashion Store'});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Pacifico',
        fontSize: 22,
        letterSpacing: 1,
      ),
    );
  }
}
