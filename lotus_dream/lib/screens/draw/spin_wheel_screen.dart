import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({super.key});

  @override
  State<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  final StreamController<int> _controller = StreamController<int>();
  final Random _random = Random();
  String? _result;
  String? _selectedParticipantId;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _spin(AppState appState) {
    final participantId = _selectedParticipantId ?? appState.finalists.first.id;
    _selectedParticipantId = participantId;
    final index = _random.nextInt(appState.wheelSegments.length);
    _controller.add(index);
    final prize = appState.spinFor(participantId);
    final participant = appState.participants.firstWhere(
      (p) => p.id == participantId,
    );
    setState(() => _result = '${participant.username} → $prize');
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          InputDecorator(
            decoration: InputDecoration(labelText: t.translate('participants')),
            child: DropdownButton<String>(
              value: _selectedParticipantId ?? appState.finalists.first.id,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: appState.finalists
                  .map(
                    (participant) => DropdownMenuItem(
                      value: participant.id,
                      child: Text('${participant.username} (${participant.city})'),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _selectedParticipantId = value),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FortuneWheel(
                  indicators: const [
                    FortuneIndicator(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.expand_more, color: Colors.deepOrange),
                    ),
                  ],
                  selected: _controller.stream,
                  items: [
                    for (final segment in appState.wheelSegments)
                      FortuneItem(
                        child: Text(segment, textAlign: TextAlign.center),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_result != null)
            Text(
              '${t.translate('spin_result_prefix')}: $_result',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _spin(appState),
            icon: const Icon(Icons.casino),
            label: Text(t.translate('spin_wheel')),
          ),
        ],
      ),
    );
  }
}
