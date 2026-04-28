import 'package:flutter/material.dart';

class DPad extends StatelessWidget {
  final VoidCallback onUp;
  final VoidCallback onDown;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  const DPad({
    super.key,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
  });

  Widget _btn(VoidCallback onTap, IconData icon, double size) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFFFF7A00),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              offset: const Offset(3, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;

        // 🔥 FIXED
        final btnSize = (size / 3.2).clamp(45.0, 80.0);

        return SizedBox(
          width: size,
          height: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _btn(onUp, Icons.keyboard_arrow_up, btnSize),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _btn(onLeft, Icons.keyboard_arrow_left, btnSize),
                  SizedBox(width: btnSize * 0.6),
                  _btn(onRight, Icons.keyboard_arrow_right, btnSize),
                ],
              ),

              _btn(onDown, Icons.keyboard_arrow_down, btnSize),
            ],
          ),
        );
      },
    );
  }
}
