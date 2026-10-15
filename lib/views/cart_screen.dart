
import 'package:flutter/material.dart';

class LowFiCard extends StatelessWidget {
  final Widget child;

  const LowFiCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}

class WireframeImage extends StatelessWidget {
  const WireframeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54),
      ),
      child: const Icon(
        Icons.image_outlined,
        color: Colors.black54,
        size: 30,
      ),
    );
  }
}

class WireframeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const WireframeButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Text(label),
    );
  }
}
