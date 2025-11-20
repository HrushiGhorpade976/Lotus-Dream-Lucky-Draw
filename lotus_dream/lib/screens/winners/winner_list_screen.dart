import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';
import 'winner_detail_screen.dart';

class WinnerListScreen extends StatelessWidget {
  const WinnerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final t = AppLocalizations.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          t.translate('winner_stories'),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        ...appState.winners.map(
          (winner) => Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                child: const Icon(Icons.workspace_premium),
              ),
              title: Text(winner.participant.username),
              subtitle: Text('${winner.prize}\n${winner.videoUrl}'),
              isThreeLine: true,
              trailing: Text(
                '${winner.announcedOn.day}/${winner.announcedOn.month}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => WinnerDetailScreen(winner: winner),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
