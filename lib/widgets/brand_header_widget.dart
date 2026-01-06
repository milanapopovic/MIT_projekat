import 'package:fashion_app1/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Fashion Store",
          style: TextStyle(
            fontFamily: "Pacifico",
            fontSize: 34,
            letterSpacing: 1,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          "Welcome back",
          style: TextStyle(color: AppColors.textMuted),
        ),
      ],
    );
  }
}
