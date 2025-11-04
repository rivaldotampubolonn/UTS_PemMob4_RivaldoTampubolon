import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const StatCard({super.key, required this.label, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
        ],
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Cinzel')),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
      ],
    );
  }
}
