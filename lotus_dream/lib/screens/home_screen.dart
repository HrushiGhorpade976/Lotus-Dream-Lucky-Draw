import 'package:flutter/material.dart';
import '../core/utils/localization.dart';
import '../core/models/draw_model.dart';
import '../services/firebase_service.dart';
import 'draw_screen.dart';
import '../widgets/loading_widget.dart';

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
    final loc = Localization('en'); // Replace with dynamic locale later
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('home_title'))),
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
            return const Center(child: Text('No draws available'));
          }
          return ListView.builder(
            itemCount: draws.length,
            itemBuilder: (context, index) {
              final draw = draws[index];
              return ListTile(
                title: Text(draw.name),
                subtitle: Text('${loc.t('participants')}: ${draw.participants.length}'),
                trailing: const Icon(Icons.arrow_forward),
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
