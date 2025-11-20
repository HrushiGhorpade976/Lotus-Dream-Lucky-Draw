import 'package:flutter/material.dart';
import '../widgets/layouts/responsive_scaffold.dart';
import '../widgets/cards/winner_card.dart';
import '../widgets/loading/loading_widget.dart';
import '../core/models/draw_model.dart';
import '../core/utils/localization.dart';
import '../services/firebase_service.dart';

class DrawScreen extends StatefulWidget {
  final Draw draw;
  const DrawScreen({super.key, required this.draw});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isDrawing = false;

  Future<void> _pickWinners() async {
    setState(() => _isDrawing = true);
    try {
      await _firebaseService.selectWinners(widget.draw.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking winners: $e')),
      );
    } finally {
      setState(() => _isDrawing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = Localization('en'); // TODO: Replace with dynamic locale

    return ResponsiveScaffold(
      title: widget.draw.name,
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _isDrawing ? null : _pickWinners,
            child: _isDrawing
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(loc.t('pick_winners')),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<Draw>(
              stream: _firebaseService.listenDrawById(widget.draw.id),
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
          ),
        ],
      ),
    );
  }
}
