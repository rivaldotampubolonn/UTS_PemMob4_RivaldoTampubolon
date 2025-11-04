import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final String optionLetter;
  final VoidCallback onTap;
  final bool isSelected;
  final bool? isCorrect;
  final bool showResult;

  const AnswerOption({
    super.key,
    required this.text,
    required this.optionLetter,
    required this.onTap,
    this.isSelected = false,
    this.isCorrect,
    this.showResult = false,
  });

  @override
  Widget build(BuildContext context) {
    Color getBorderColor() {
      if (showResult && isCorrect != null) {
        if (isCorrect!) return Colors.green;
        if (isSelected) return Colors.red;
      }
      return isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.3);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: showResult ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: showResult && isCorrect != null
                  ? (isCorrect! ? Colors.green.withOpacity(0.1) : (isSelected ? Colors.red.withOpacity(0.1) : null))
                  : (isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: getBorderColor(), width: 2),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: getBorderColor()),
                  child: Center(child: Text(optionLetter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'))),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(text, style: const TextStyle(fontFamily: 'Montserrat'))),
                if (showResult && isCorrect != null)
                  Icon(isCorrect! ? Icons.check_circle : Icons.cancel, color: isCorrect! ? Colors.green : Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
