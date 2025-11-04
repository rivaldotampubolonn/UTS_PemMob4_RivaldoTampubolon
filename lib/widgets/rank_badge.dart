import 'package:flutter/material.dart';

class RankBadge extends StatelessWidget {
  final String rank;
  const RankBadge({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.6)],
            ),
            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 3),
          ),
          child: Icon(Icons.shield, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(rank, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Cinzel', color: Theme.of(context).colorScheme.primary)),
      ],
    );
  }
}