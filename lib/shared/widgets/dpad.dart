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
    return _PressableButton(size: size, icon: icon, onPressed: onTap);
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

class _PressableButton extends StatefulWidget {
  final double size;
  final IconData icon;
  final VoidCallback onPressed;

  const _PressableButton({
    required this.size,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  bool isPressed = false;

  Future<void> _startHolding() async {
    while (isPressed) {
      widget.onPressed();
      await Future.delayed(const Duration(milliseconds: 120));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
        widget.onPressed(); // immediate response
        _startHolding(); // 🔥 continuous movement
      },
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),

      child: AnimatedScale(
        scale: isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),

        child: Container(
          width: widget.size,
          height: widget.size,
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
          child: Icon(
            widget.icon,
            color: Colors.white,
            size: widget.size * 0.5,
          ),
        ),
      ),
    );
  }
}
