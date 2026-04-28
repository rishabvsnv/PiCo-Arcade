import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final VoidCallback onStart;

  const StartButton({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStart,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFFF7A00),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              offset: const Offset(4, 5),
              blurRadius: 6,
            ),
          ],
        ),
        child: const Center(
          child: Text("START", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
