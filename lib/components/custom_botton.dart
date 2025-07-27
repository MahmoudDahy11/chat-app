import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBotton extends StatelessWidget {
  CustomBotton({super.key, required this.text, this.onTap});
  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
