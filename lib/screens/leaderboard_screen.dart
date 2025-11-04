import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/theme_toggle_button.dart';
import '../utils/responsive_helper.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final dummyPlayers = [
      {'name': 'Eren Yeager', 'score': 55000, 'rank': 'Titan Slayer'},
      {'name': 'Levi Ackerman', 'score': 48000, 'rank': 'Commander'},
      {'name': 'Mikasa Ackerman', 'score': 42000, 'rank': 'Commander'},
      {'name': 'Armin Arlert', 'score': 38000, 'rank': 'Section Commander'},
      {'name': 'Erwin Smith', 'score': 35000, 'rank': 'Section Commander'},
    ];

    if (userProvider.user.totalScore > 0) {
      dummyPlayers.add({'name': userProvider.user.username, 'score': userProvider.user.totalScore, 'rank': userProvider.user.rank});
    }
    dummyPlayers.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text('HALL OF HEROES'),
        actions: const [ThemeToggleButton()],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface])),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxContentWidth(context)),
            child: ListView(
              padding: ResponsiveHelper.getResponsivePadding(context),
              children: [
                Icon(Icons.emoji_events, size: 80, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                Text('TOP SOLDIERS', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Cinzel', fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 24),
                ...List.generate(dummyPlayers.length, (index) {
                  final player = dummyPlayers[index];
                  final isCurrentUser = player['name'] == userProvider.user.username;
                  return Card(
                    elevation: isCurrentUser ? 8 : 4,
                    color: isCurrentUser ? Theme.of(context).colorScheme.primary.withOpacity(0.15) : null,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: index < 3 ? [Colors.amber, Colors.grey, Colors.brown][index] : Theme.of(context).colorScheme.surface),
                        child: Center(child: Text('${index + 1}', style: const TextStyle(fontFamily: 'Cinzel', fontSize: 20, fontWeight: FontWeight.bold))),
                      ),
                      title: Text(player['name'] as String, style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: isCurrentUser ? Theme.of(context).colorScheme.primary : null)),
                      subtitle: Text(player['rank'] as String, style: const TextStyle(fontFamily: 'Montserrat', fontSize: 12)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Theme.of(context).colorScheme.primary, size: 20),
                          const SizedBox(width: 4),
                          Text('${player['score']}', style: TextStyle(fontFamily: 'Cinzel', fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}