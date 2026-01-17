import 'package:fashion_app1/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;

  const PageHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ⬇ NEMA prostora gore
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 22,
            padding: EdgeInsets.zero, 
            constraints: const BoxConstraints(),
            color: AppColors.brand,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
