import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';

class ParticipantsScreen extends StatefulWidget {
  const ParticipantsScreen({super.key});

  @override
  State<ParticipantsScreen> createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final t = AppLocalizations.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          t.translate('participants'),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        ...appState.participants.map(
          (participant) => Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  participant.username.isNotEmpty ? participant.username[0] : '?',
                ),
              ),
              title: Text(participant.username),
              subtitle: Text(
                '${participant.city} • ${participant.mobileNumber}',
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.confirmation_num),
                  Text('${participant.entriesPurchased}'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          t.translate('broadcast_title'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _messageController,
          maxLines: 3,
          decoration: InputDecoration(hintText: t.translate('broadcast_hint')),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            context.read<AppState>().sendBroadcast(_messageController.text);
            _messageController.clear();
          },
          icon: const Icon(Icons.send),
          label: Text(t.translate('send_message')),
        ),
        const SizedBox(height: 16),
        ...appState.broadcasts.map(
          (message) => ListTile(
            leading: const Icon(Icons.campaign_outlined),
            title: Text(message),
          ),
        ),
      ],
    );
  }
}
