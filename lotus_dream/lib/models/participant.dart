enum ParticipantStatus { active, finalist, winner, pending }

class Participant {
  Participant({
    required this.id,
    required this.username,
    required this.mobileNumber,
    required this.entriesPurchased,
    required this.city,
    this.status = ParticipantStatus.active,
    this.prize,
    this.videoUrl,
  });

  final String id;
  final String username;
  final String mobileNumber;
  final int entriesPurchased;
  final String city;
  final ParticipantStatus status;
  final String? prize;
  final String? videoUrl;

  Participant copyWith({
    String? id,
    String? username,
    String? mobileNumber,
    int? entriesPurchased,
    String? city,
    ParticipantStatus? status,
    String? prize,
    String? videoUrl,
  }) {
    return Participant(
      id: id ?? this.id,
      username: username ?? this.username,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      entriesPurchased: entriesPurchased ?? this.entriesPurchased,
      city: city ?? this.city,
      status: status ?? this.status,
      prize: prize ?? this.prize,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
