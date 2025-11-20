import 'package:flutter/material.dart';
import '../widgets/layouts/responsive_scaffold.dart';
import '../widgets/cards/draw_card.dart';
import '../widgets/loading/loading_widget.dart';
import '../core/models/draw_model.dart';
import '../core/utils/localization.dart';
import '../services/firebase_service.dart';
import 'draw_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late Stream<List<Draw>> _drawStream;

  @override
  void initState() {
    super.initState();
    _drawStream = _firebaseService.listenDraws();
  }

  @override
  Widget build(BuildContext context) {
    final loc = Localization('en'); // TODO: Replace with dynamic locale

    return ResponsiveScaffold(
      title: loc.t('home_title'),
      body: StreamBuilder<List<Draw>>(
        stream: _drawStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final draws = snapshot.data ?? [];
          if (draws.isEmpty) {
            return Center(child: Text(loc.t('no_draws')));
          }
          return ListView.builder(
            itemCount: draws.length,
            itemBuilder: (context, index) {
              final draw = draws[index];
              return DrawCard(
                draw: draw,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DrawScreen(draw: draw)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
