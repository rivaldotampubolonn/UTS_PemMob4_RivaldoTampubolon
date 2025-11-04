import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String category;

  const QuestionCard({super.key, required this.question, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(category, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary)),
            ),
            const SizedBox(height: 16),
            Text(question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Montserrat', height: 1.5)),
          ],
        ),
      ),
    );
  }
}