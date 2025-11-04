import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/screen_utils.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final iconSize = ScreenUtils.scaledSize(context, 24);

    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        size: iconSize,
      ),
      onPressed: () => themeProvider.toggleTheme(),
      tooltip: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
