import 'participant.dart';

class Winner {
  Winner({
    required this.participant,
    required this.prize,
    required this.videoUrl,
    required this.announcedOn,
  });

  final Participant participant;
  final String prize;
  final String videoUrl;
  final DateTime announcedOn;
}
