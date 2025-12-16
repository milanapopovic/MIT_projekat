import 'package:flutter/material.dart';
import 'package:fashion_app1/widgets/title_text.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Center(
      child: TitelesTextWidget(label: "Search Screen"),
     ),
    );
  }
}