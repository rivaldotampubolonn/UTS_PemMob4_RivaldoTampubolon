import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/game_result_model.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/stat_card.dart';
import '../utils/responsive_helper.dart';

class ResultScreen extends StatefulWidget {
  final GameResultModel? result;
  const ResultScreen({super.key, this.result});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _scoreAnimation = IntTween(begin: 0, end: widget.result?.score ?? 0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getPerformanceColor() {
    final result = widget.result;
    if (result == null) return Colors.grey;
    if (result.accuracy >= 90) return const Color(0xFFFFD700);
    if (result.accuracy >= 80) return Colors.green;
    if (result.accuracy >= 70) return Colors.blue;
    return Colors.orange;
  }

  String _getMessage() {
    final result = widget.result;
    if (result == null) return 'Keep fighting!';
    if (result.accuracy >= 90) return '🏆 Legendary Performance! You are a true Soldier of Faith!';
    if (result.accuracy >= 80) return '⭐ Excellent work! Your knowledge shines bright!';
    if (result.accuracy >= 70) return '💪 Great job! Keep up the good work!';
    return '📖 Good effort! Keep training!';
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final userProvider = Provider.of<UserProvider>(context);

    if (result == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('No result data'),
              const SizedBox(height: 24),
              CustomButton(text: 'Return Home', onPressed: () => context.go('/')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface, _getPerformanceColor().withOpacity(0.1)]),
          image: const DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover, opacity: 0.08),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
              child: SingleChildScrollView(
                padding: ResponsiveHelper.getResponsivePadding(context),
                child: Column(
                  children: [
                    Icon(result.accuracy >= 70 ? Icons.emoji_events : Icons.military_tech, size: 100, color: _getPerformanceColor()),
                    const SizedBox(height: 16),
                    Text(result.accuracy >= 70 ? 'VICTORY!' : 'MISSION COMPLETE', style: TextStyle(fontFamily: 'Cinzel', fontSize: 48, fontWeight: FontWeight.bold, color: _getPerformanceColor())),
                    const SizedBox(height: 32),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Text('FINAL SCORE', style: TextStyle(fontFamily: 'Cinzel', fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                            const SizedBox(height: 16),
                            AnimatedBuilder(
                              animation: _scoreAnimation,
                              builder: (context, child) => Text(_scoreAnimation.value.toString(), style: TextStyle(fontFamily: 'Cinzel', fontSize: 64, fontWeight: FontWeight.bold, color: _getPerformanceColor())),
                            ),
                            const SizedBox(height: 8),
                            Text(result.performanceRating, style: TextStyle(fontFamily: 'Cinzel', fontSize: 20, fontWeight: FontWeight.bold, color: _getPerformanceColor())),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            StatCard(label: 'Correct', value: '${result.correctAnswers}', icon: Icons.check_circle),
                            StatCard(label: 'Wrong', value: '${result.wrongAnswers}', icon: Icons.cancel),
                            StatCard(label: 'Accuracy', value: '${result.accuracy.toStringAsFixed(0)}%', icon: Icons.percent),
                            StatCard(label: 'Time', value: '${result.totalTimeSeconds}s', icon: Icons.timer),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      color: _getPerformanceColor().withOpacity(0.1),
                      child: Padding(padding: const EdgeInsets.all(16), child: Text(_getMessage(), style: const TextStyle(fontFamily: 'Montserrat', fontSize: 16), textAlign: TextAlign.center)),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Current Rank: ${userProvider.user.rank} | Total: ${userProvider.user.totalScore}', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ResponsiveBuilder(
                      builder: (context, type) => type == DeviceType.mobile
                          ? Column(children: [CustomButton(text: 'PLAY AGAIN', onPressed: () => context.go('/quiz/${result.difficulty}'), icon: Icons.replay), const SizedBox(height: 12), CustomButton(text: 'Leaderboard', onPressed: () => context.go('/leaderboard'), isPrimary: false), const SizedBox(height: 12), CustomButton(text: 'Home', onPressed: () => context.go('/'), isPrimary: false)])
                          : Column(children: [CustomButton(text: 'PLAY AGAIN', onPressed: () => context.go('/quiz/${result.difficulty}'), icon: Icons.replay), const SizedBox(height: 12), Row(children: [Expanded(child: CustomButton(text: 'Leaderboard', onPressed: () => context.go('/leaderboard'), isPrimary: false)), const SizedBox(width: 12), Expanded(child: CustomButton(text: 'Home', onPressed: () => context.go('/'), isPrimary: false))])]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}