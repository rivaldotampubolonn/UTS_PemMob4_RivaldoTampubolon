import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/rank_badge.dart';
import '../widgets/progress_bar.dart';
import '../widgets/theme_toggle_button.dart';
import '../utils/responsive_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final nextRankInfo = userProvider.getNextRankInfo();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface]),
          image: const DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover, opacity: 0.12),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
              child: SingleChildScrollView(
                padding: ResponsiveHelper.getResponsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('SURVEY CORPS HQ', style: TextStyle(fontFamily: 'Cinzel', fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary))),
                        const ThemeToggleButton(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Soldier: ${userProvider.user.username}', style: const TextStyle(fontFamily: 'Montserrat')),
                    const SizedBox(height: 24),
                    Center(child: RankBadge(rank: userProvider.user.rank)),
                    const SizedBox(height: 24),
                    if (nextRankInfo['nextRank'] != 'Max Rank')
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Next Promotion: ${nextRankInfo['nextRank']}', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                              const SizedBox(height: 12),
                              CustomProgressBar(progress: nextRankInfo['progress'], label: '${nextRankInfo['scoreNeeded']} points needed'),
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
                            StatCard(label: 'Total Score', value: userProvider.user.totalScore.toString(), icon: Icons.star),
                            StatCard(label: 'Missions', value: userProvider.user.gamesPlayed.toString(), icon: Icons.games),
                            StatCard(label: 'Best Score', value: userProvider.user.bestScore.toString(), icon: Icons.emoji_events),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomButton(text: 'BEGIN EXPEDITION', onPressed: () => context.push('/quiz/normal'), icon: Icons.flag),
                    const SizedBox(height: 16),
                    CustomButton(text: 'RECLAMATION MISSION (Hard)', onPressed: () => context.push('/quiz/hard'), isPrimary: false, icon: Icons.whatshot),
                    const SizedBox(height: 32),
                    ResponsiveBuilder(
                      builder: (context, type) => type == DeviceType.mobile
                          ? Column(children: [CustomButton(text: 'Hall of Heroes', onPressed: () => context.push('/leaderboard'), isPrimary: false), const SizedBox(height: 12), CustomButton(text: 'Soldier Profile', onPressed: () => context.push('/profile'), isPrimary: false)])
                          : Row(children: [Expanded(child: CustomButton(text: 'Hall of Heroes', onPressed: () => context.push('/leaderboard'), isPrimary: false)), const SizedBox(width: 12), Expanded(child: CustomButton(text: 'Soldier Profile', onPressed: () => context.push('/profile'), isPrimary: false))]),
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