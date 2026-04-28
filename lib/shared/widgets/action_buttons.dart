import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onMode;
  final VoidCallback onReset;
  final VoidCallback onSound;
  final VoidCallback onPause;

  const ActionButtons({
    super.key,
    required this.onMode,
    required this.onReset,
    required this.onSound,
    required this.onPause,
  });

  Widget _smallButton(String label, VoidCallback onTap) {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFFF7A00),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(onTap: onMode, child: _smallButton("MODE", onMode)),
        GestureDetector(onTap: onReset, child: _smallButton("RESET", onReset)),
        GestureDetector(onTap: onSound, child: _smallButton("SOUND", onSound)),
        GestureDetector(onTap: onPause, child: _smallButton("PAUSE", onPause)),
      ],
    );
  }
}
