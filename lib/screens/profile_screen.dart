import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/rank_badge.dart';
import '../widgets/stat_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_bar.dart';
import '../widgets/theme_toggle_button.dart';
import '../utils/responsive_helper.dart';
import '../config/theme_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isEditingUsername = false;

  @override
  void initState() {
    super.initState();
    _usernameController.text = Provider.of<UserProvider>(context, listen: false).user.username;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _saveUsername() {
    final newUsername = _usernameController.text.trim();
    if (newUsername.isEmpty || newUsername.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username must be at least 3 characters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Provider.of<UserProvider>(context, listen: false).updateUsername(newUsername);
    setState(() => _isEditingUsername = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Username updated!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showResetDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? ThemeConfig.darkPrimary : ThemeConfig.lightPrimary;
    final secondaryColor = isDark ? ThemeConfig.darkSecondary : ThemeConfig.lightSecondary;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
          title: Row(
            children: [
              Icon(
                Icons.restart_alt,
                color: primaryColor,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Rekindle the Faith',
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Are you sure you want to restart your journey?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'This will reset:',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildResetItem('Total Score to 0', secondaryColor),
              _buildResetItem('Missions Completed to 0', secondaryColor),
              _buildResetItem('Best Score to 0', secondaryColor),
              _buildResetItem('Rank back to Cadet', secondaryColor),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Your username will be preserved',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontFamily: 'Cinzel'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await Provider.of<UserProvider>(context, listen: false).resetProgress();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Progress reset! Begin your journey anew, soldier!',
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResetItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.close,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final nextRankInfo = userProvider.getNextRankInfo();
    final hasProgress = userProvider.user.gamesPlayed > 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? ThemeConfig.darkPrimary : ThemeConfig.lightPrimary;
    final secondaryColor = isDark ? ThemeConfig.darkSecondary : ThemeConfig.lightSecondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLDIER PROFILE'),
        actions: const [ThemeToggleButton()],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.getMaxContentWidth(context),
            ),
            child: SingleChildScrollView(
              padding: ResponsiveHelper.getResponsivePadding(context),
              child: Column(
                children: [
                  RankBadge(rank: userProvider.user.rank),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontFamily: 'Cinzel',
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              IconButton(
                                icon: Icon(_isEditingUsername ? Icons.save : Icons.edit),
                                onPressed: _isEditingUsername
                                    ? _saveUsername
                                    : () => setState(() => _isEditingUsername = true),
                              ),
                            ],
                          ),
                          _isEditingUsername
                              ? TextField(
                            controller: _usernameController,
                            style: const TextStyle(
                              fontFamily: 'Cinzel',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              : Text(
                            userProvider.user.username,
                            style: const TextStyle(
                              fontFamily: 'Cinzel',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (nextRankInfo['nextRank'] != 'Max Rank')
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rank Progress',
                              style: TextStyle(
                                fontFamily: 'Cinzel',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomProgressBar(
                              progress: nextRankInfo['progress'],
                              label: 'Next: ${nextRankInfo['nextRank']} (${nextRankInfo['scoreNeeded']} pts)',
                            ),
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
                          StatCard(
                            label: 'Total Score',
                            value: userProvider.user.totalScore.toString(),
                            icon: Icons.star,
                          ),
                          StatCard(
                            label: 'Missions',
                            value: userProvider.user.gamesPlayed.toString(),
                            icon: Icons.games,
                          ),
                          StatCard(
                            label: 'Best Score',
                            value: userProvider.user.bestScore.toString(),
                            icon: Icons.emoji_events,
                          ),
                          StatCard(
                            label: 'Avg Score',
                            value: userProvider.user.gamesPlayed > 0
                                ? (userProvider.user.totalScore / userProvider.user.gamesPlayed)
                                .toStringAsFixed(0)
                                : '0',
                            icon: Icons.trending_up,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Reset Progress Button - Rekindle the Faith
                  if (hasProgress) ...[
                    const SizedBox(height: 32),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: secondaryColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Danger Zone',
                                    style: TextStyle(
                                      fontFamily: 'Cinzel',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    primaryColor,
                                    secondaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _showResetDialog,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.restart_alt,
                                          color: isDark ? ThemeConfig.darkBackground : Colors.white,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Rekindle the Faith',
                                          style: TextStyle(
                                            fontFamily: 'Cinzel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? ThemeConfig.darkBackground : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Reset all progress and start your journey anew',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color
                                    ?.withOpacity(0.7),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}