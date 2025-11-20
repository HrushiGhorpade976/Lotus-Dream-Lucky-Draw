import 'user_model.dart';

class Draw {
  final String id;
  final String name;
  final double entryFee;
  final List<User> participants;
  final List<User> winners;

  Draw({
    required this.id,
    required this.name,
    required this.entryFee,
    this.participants = const [],
    this.winners = const [],
  });

  factory Draw.fromJson(Map<String, dynamic> json) => Draw(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    entryFee: (json['entryFee'] ?? 0).toDouble(),
    participants: (json['participants'] as List<dynamic>? ?? [])
        .map((e) => User.fromJson(e))
        .toList(),
    winners: (json['winners'] as List<dynamic>? ?? [])
        .map((e) => User.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'entryFee': entryFee,
    'participants': participants.map((e) => e.toJson()).toList(),
    'winners': winners.map((e) => e.toJson()).toList(),
  };
}

