import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    Future.delayed(AppConstants.splashDuration, () {
      if (mounted) context.go('/');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/app_icon.png', width: 120, height: 120, errorBuilder: (_, __, ___) => Icon(Icons.auto_stories, size: 120, color: Theme.of(context).colorScheme.primary)),
              const SizedBox(height: 24),
              Text(AppConstants.appName.toUpperCase(), style: TextStyle(fontFamily: 'Cinzel', fontSize: 32, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, letterSpacing: 2)),
              const SizedBox(height: 8),
              Text(AppConstants.appTagline, style: TextStyle(fontFamily: 'Cinzel', fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
              const SizedBox(height: 48),
              CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}