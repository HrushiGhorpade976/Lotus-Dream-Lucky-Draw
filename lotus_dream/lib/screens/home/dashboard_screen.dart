import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';
import '../participants/participants_screen.dart';
import '../winners/winner_list_screen.dart';
import 'payment_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final appState = context.watch<AppState>();
    final totalTickets = appState.participants.fold<int>(
      0,
      (sum, participant) => sum + participant.entriesPurchased,
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _HeroBanner(t: t),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: t.translate('tickets_sold'),
                value:
                    '$totalTickets / ${appState.drawConfig.maxEntriesPerDraw}',
                icon: Icons.confirmation_num_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: t.translate('finalists_today'),
                value: '${appState.finalists.length}',
                icon: Icons.groups_3_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _StatCard(
          label: t.translate('revenue_collected'),
          value: '₹${appState.collectedRevenue.toStringAsFixed(2)}',
          icon: Icons.payments,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ActionChip(
              icon: Icons.currency_rupee,
              label: t.translate('cta_pay_now'),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const PaymentScreen())),
            ),
            _ActionChip(
              icon: Icons.people_outline,
              label: t.translate('cta_view_participants'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ParticipantsScreen()),
              ),
            ),
            _ActionChip(
              icon: Icons.workspace_premium,
              label: t.translate('cta_view_winners'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const WinnerListScreen()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Finalists (${appState.drawConfig.finalistsPerDraw})',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        ...appState.finalists.map(
          (participant) => ListTile(
            title: Text(participant.username),
            subtitle: Text(participant.city),
            trailing: Text('ID ${participant.id}'),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: context.read<AppState>().selectRandomFinalists,
          icon: const Icon(Icons.refresh),
          label: Text(t.translate('select_finalists')),
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.t});

  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.translate('home_banner_title'),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.translate('home_banner_subtitle'),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            onPressed: () {},
            child: Text(t.translate('enter_draw')),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
