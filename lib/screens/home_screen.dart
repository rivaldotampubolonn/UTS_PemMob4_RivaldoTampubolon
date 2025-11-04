import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/rank_badge.dart';
import '../widgets/progress_bar.dart';
import '../widgets/theme_toggle_button.dart';
import '../utils/responsive_helper.dart';
import '../utils/screen_utils.dart';
import '../config/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final nextRankInfo = userProvider.getNextRankInfo();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ResponsiveHelper.getMaxContentWidth(context),
              ),
              child: SingleChildScrollView(
                padding: ResponsiveHelper.getResponsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header with Theme Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            AppConstants.appName.toUpperCase(),
                            style: GoogleFonts.cinzel(
                              fontSize: ResponsiveHelper.getResponsiveFontSize(
                                context,
                                mobile: 24,
                                tablet: 28,
                                desktop: 32,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const ThemeToggleButton(),
                      ],
                    ),
                    SizedBox(height: ScreenUtils.scaledSize(context, 8)),
                    Text(
                      'Welcome, ${userProvider.user.username}',
                      style: TextStyle(
                        fontSize: ScreenUtils.scaledFontSize(context, 16),
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: ScreenUtils.scaledSize(context, 32)),

                    // Rank Badge
                    RankBadge(rank: userProvider.user.rank),
                    SizedBox(height: ScreenUtils.scaledSize(context, 24)),

                    // Progress to Next Rank
                    if (nextRankInfo['nextRank'] != 'Max Rank') ...[
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(
                            ScreenUtils.scaledSize(context, AppConstants.spacingM),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Next Rank: ${nextRankInfo['nextRank']}',
                                style: GoogleFonts.cinzel(
                                  fontSize: ScreenUtils.scaledFontSize(context, 16),
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: ScreenUtils.scaledSize(context, 8)),
                              CustomProgressBar(
                                progress: nextRankInfo['progress'],
                                label: '${nextRankInfo['scoreNeeded']} points needed',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtils.scaledSize(context, 24)),
                    ],

                    // Stats Card
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                          ScreenUtils.scaledSize(context, AppConstants.spacingL),
                        ),
                        child: ResponsiveBuilder(
                          builder: (context, deviceType) {
                            final columns = deviceType == DeviceType.mobile ? 3 : 4;
                            return Wrap(
                              spacing: ScreenUtils.scaledSize(context, 16),
                              runSpacing: ScreenUtils.scaledSize(context, 16),
                              alignment: WrapAlignment.spaceAround,
                              children: [
                                StatCard(
                                  label: 'Total Score',
                                  value: userProvider.user.totalScore.toString(),
                                  icon: Icons.star,
                                ),
                                StatCard(
                                  label: 'Games Played',
                                  value: userProvider.user.gamesPlayed.toString(),
                                  icon: Icons.games,
                                ),
                                StatCard(
                                  label: 'Best Score',
                                  value: userProvider.user.bestScore.toString(),
                                  icon: Icons.emoji_events,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtils.scaledSize(context, 32)),

                    // Play Buttons
                    CustomButton(
                      text: 'START QUEST',
                      onPressed: () => context.push('/quiz/normal'),
                      icon: Icons.play_arrow,
                    ),
                    SizedBox(height: ScreenUtils.scaledSize(context, 16)),
                    CustomButton(
                      text: 'HARD MODE',
                      onPressed: () => context.push('/quiz/hard'),
                      isPrimary: false,
                      icon: Icons.whatshot,
                    ),
                    SizedBox(height: ScreenUtils.scaledSize(context, 32)),

                    // Navigation Buttons
                    ResponsiveBuilder(
                      builder: (context, deviceType) {
                        if (deviceType == DeviceType.mobile) {
                          return Column(
                            children: [
                              CustomButton(
                                text: 'Leaderboard',
                                onPressed: () => context.push('/leaderboard'),
                                isPrimary: false,
                                icon: Icons.leaderboard,
                              ),
                              SizedBox(height: ScreenUtils.scaledSize(context, 12)),
                              CustomButton(
                                text: 'Profile',
                                onPressed: () => context.push('/profile'),
                                isPrimary: false,
                                icon: Icons.person,
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'Leaderboard',
                                  onPressed: () => context.push('/leaderboard'),
                                  isPrimary: false,
                                  icon: Icons.leaderboard,
                                ),
                              ),
                              SizedBox(width: ScreenUtils.scaledSize(context, 12)),
                              Expanded(
                                child: CustomButton(
                                  text: 'Profile',
                                  onPressed: () => context.push('/profile'),
                                  isPrimary: false,
                                  icon: Icons.person,
                                ),
                              ),
                            ],
                          );
                        }
                      },
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