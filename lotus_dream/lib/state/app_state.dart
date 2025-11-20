import 'dart:math';

import 'package:flutter/material.dart';

import '../mock/mock_data.dart';
import '../models/draw_config.dart';
import '../models/participant.dart';
import '../models/payment_option.dart';
import '../models/winner.dart';

class AppState extends ChangeNotifier {
  AppState()
    : _participants = List.of(MockData.participants),
      _winners = List.of(MockData.winners),
      _finalists = List.of(
        MockData.participants.take(MockData.drawConfig.finalistsPerDraw),
      ),
      _drawConfig = MockData.drawConfig,
      _paymentOptions = List.of(MockData.paymentOptions),
      _collectedRevenue =
          MockData.participants.length *
          MockData.drawConfig.entryFee.toDouble();

  bool _isAuthenticated = false;
  Locale _locale = MockData.supportedLocales.first;
  final DrawConfig _drawConfig;
  final List<PaymentOption> _paymentOptions;
  List<Participant> _participants;
  List<Winner> _winners;
  List<Participant> _finalists;
  final List<String> _broadcastHistory = [];
  double _collectedRevenue;
  final Random _random = Random();

  bool get isAuthenticated => _isAuthenticated;
  Locale get locale => _locale;
  DrawConfig get drawConfig => _drawConfig;
  List<Participant> get participants => List.unmodifiable(_participants);
  List<Winner> get winners => List.unmodifiable(_winners);
  List<Participant> get finalists => List.unmodifiable(_finalists);
  List<String> get broadcasts => List.unmodifiable(_broadcastHistory.reversed);
  double get collectedRevenue => _collectedRevenue;
  List<PaymentOption> get paymentOptions => List.unmodifiable(_paymentOptions);

  List<String> get wheelSegments => MockData.wheelSegments;

  void login(String username, String password) {
    if (username.isEmpty || password.isEmpty) return;
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  void signup({
    required String username,
    required String mobile,
    required String city,
    int entries = 1,
  }) {
    final participant = Participant(
      id: 'PX${_participants.length + 1}',
      username: username,
      mobileNumber: mobile,
      entriesPurchased: entries,
      city: city,
    );
    _participants = [..._participants, participant];
    _collectedRevenue += entries * _drawConfig.entryFee;
    _isAuthenticated = true;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void recordPayment(double amount) {
    _collectedRevenue += amount;
    notifyListeners();
  }

  void sendBroadcast(String message) {
    if (message.trim().isEmpty) return;
    _broadcastHistory.add(message.trim());
    notifyListeners();
  }

  void selectRandomFinalists() {
    final copy = List.of(_participants);
    copy.shuffle(_random);
    _finalists = copy.take(_drawConfig.finalistsPerDraw).toList();
    notifyListeners();
  }

  String spinFor(String participantId) {
    final prize = wheelSegments[_random.nextInt(wheelSegments.length)];
    final participantIndex = _participants.indexWhere(
      (p) => p.id == participantId,
    );
    if (participantIndex != -1 && prize != 'Next Time') {
      final updatedParticipant = _participants[participantIndex].copyWith(
        status: ParticipantStatus.winner,
        prize: prize,
      );
      _participants[participantIndex] = updatedParticipant;
      _winners = [
        Winner(
          participant: updatedParticipant,
          prize: prize,
          videoUrl:
              'https://cdn.example.com/videos/${participantId.toLowerCase()}.mp4',
          announcedOn: DateTime.now(),
        ),
        ..._winners,
      ];
    }
    notifyListeners();
    return prize;
  }
}
