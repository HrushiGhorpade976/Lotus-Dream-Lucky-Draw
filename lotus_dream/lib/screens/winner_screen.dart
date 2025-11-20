import 'package:flutter/material.dart';
import '../widgets/layouts/responsive_scaffold.dart';
import '../widgets/cards/winner_card.dart';
import '../widgets/loading/loading_widget.dart';
import '../core/models/draw_model.dart';
import '../core/utils/localization.dart';
import '../services/firebase_service.dart';

class WinnerScreen extends StatelessWidget {
  final String drawId;
  const WinnerScreen({super.key, required this.drawId});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();
    final loc = Localization('en'); // TODO: Replace with dynamic locale

    return ResponsiveScaffold(
      title: loc.t('winners'),
      body: StreamBuilder<Draw>(
        stream: firebaseService.listenDrawById(drawId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LoadingWidget();
          final draw = snapshot.data!;
          if (draw.winners.isEmpty) {
            return Center(child: Text(loc.t('no_winners')));
          }
          return ListView.builder(
            itemCount: draw.winners.length,
            itemBuilder: (context, index) {
              return WinnerCard(winner: draw.winners[index]);
            },
          );
        },
      ),
    );
  }
}
