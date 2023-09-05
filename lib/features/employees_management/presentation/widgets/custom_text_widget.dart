import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final bool shrink;
  final String text;

  const CustomText({super.key, required this.text, this.shrink = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: shrink ? 1 : 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }
}
