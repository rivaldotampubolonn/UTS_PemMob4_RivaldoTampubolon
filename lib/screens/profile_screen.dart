import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/rank_badge.dart';
import '../widgets/stat_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_bar.dart';
import '../widgets/theme_toggle_button.dart';
import '../utils/responsive_helper.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username must be at least 3 characters'), backgroundColor: Colors.red));
      return;
    }
    Provider.of<UserProvider>(context, listen: false).updateUsername(newUsername);
    setState(() => _isEditingUsername = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username updated!'), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final nextRankInfo = userProvider.getNextRankInfo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLDIER PROFILE'),
        actions: const [ThemeToggleButton()],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface])),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
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
                              Text('Username', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary)),
                              IconButton(icon: Icon(_isEditingUsername ? Icons.save : Icons.edit), onPressed: _isEditingUsername ? _saveUsername : () => setState(() => _isEditingUsername = true)),
                            ],
                          ),
                          _isEditingUsername
                              ? TextField(controller: _usernameController, style: const TextStyle(fontFamily: 'Cinzel', fontSize: 20, fontWeight: FontWeight.bold))
                              : Text(userProvider.user.username, style: const TextStyle(fontFamily: 'Cinzel', fontSize: 24, fontWeight: FontWeight.bold)),
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
                            Text('Rank Progress', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                            const SizedBox(height: 12),
                            CustomProgressBar(progress: nextRankInfo['progress'], label: 'Next: ${nextRankInfo['nextRank']} (${nextRankInfo['scoreNeeded']} pts)'),
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
                          StatCard(label: 'Avg Score', value: userProvider.user.gamesPlayed > 0 ? (userProvider.user.totalScore / userProvider.user.gamesPlayed).toStringAsFixed(0) : '0', icon: Icons.trending_up),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}