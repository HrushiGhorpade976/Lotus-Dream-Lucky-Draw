import 'package:flutter/material.dart';
import '../core/models/user_model.dart';

class WinnerScreen extends StatelessWidget {
  final List<User> winners;
  const WinnerScreen({super.key, required this.winners});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Winners')),
      body: winners.isEmpty
          ? const Center(child: Text('No winners selected yet'))
          : ListView.builder(
              itemCount: winners.length,
              itemBuilder: (context, index) {
                final winner = winners[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(winner.name),
                  subtitle: Text(winner.email),
                );
              },
            ),
    );
  }
}
