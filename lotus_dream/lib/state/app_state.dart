// lib/state/app_state.dart
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../mock/mock_data.dart';
import '../models/draw_config.dart';
import '../models/participant.dart';
import '../models/payment_option.dart';
import '../models/user.dart';
import '../models/winner.dart';
import '../services/api_service.dart';

/// Merged AppState:
/// - If ApiService (api) is provided -> tries to load and persist via backend.
/// - Otherwise uses MockData for a fully local mode (useful for dev/manual QA).
/// - Centralizes: auth, locale, participants, finalists, wheelSegments, winners,
///   paymentOptions, broadcasts, revenue, and spin stream for FortuneWheel.
class AppState extends ChangeNotifier {
  final ApiService? api;

  AppState({this.api}) {
    // initialize from mock by default; then try to load from backend if available.
    _participants = List<Participant>.of(MockData.participants);
    _winners = List<Winner>.of(MockData.winners);
    _drawConfig = MockData.drawConfig;
    _paymentOptions = List<PaymentOption>.of(MockData.paymentOptions);
    _finalists = List<Participant>.of(
      MockData.participants.take(MockData.drawConfig.finalistsPerDraw),
    );
    _wheelSegments = List<String>.of(MockData.wheelSegments);
    _collectedRevenue =
        MockData.participants.length * MockData.drawConfig.entryFee.toDouble();

    // if api provided attempt to load server-side data async (non-blocking)
    if (api != null) {
      _loadFromServer();
    }
  }

  // ----- internal state -----
  bool _isAuthenticated = false;
  Locale _locale = MockData.supportedLocales.first;
  late final DrawConfig _drawConfig;
  final List<PaymentOption> _paymentOptions;
  List<PaymentOption> get _internalPaymentOptions => _paymentOptions;
  List<Participant> _participants = [];
  List<Winner> _winners = [];
  List<Participant> _finalists = [];
  final List<String> _broadcastHistory = [];
  double _collectedRevenue = 0.0;
  final Random _random = Random();
  List<String> _wheelSegments = [];

  // stream controller used by FortuneWheel / UI to animate spins
  final StreamController<int> _spinController =
      StreamController<int>.broadcast();

  // ----- public getters -----
  bool get isAuthenticated => _isAuthenticated;
  Locale get locale => _locale;
  DrawConfig get drawConfig => _drawConfig;
  List<Participant> get participants => List.unmodifiable(_participants);
  List<Winner> get winners => List.unmodifiable(_winners);
  List<Participant> get finalists => List.unmodifiable(_finalists);
  List<String> get broadcasts =>
      List.unmodifiable(_broadcastHistory.reversed.toList());
  double get collectedRevenue => _collectedRevenue;
  List<PaymentOption> get paymentOptions =>
      List.unmodifiable(_paymentOptions);
  List<String> get wheelSegments => List.unmodifiable(_wheelSegments);
  Stream<int> get spinStream => _spinController.stream;

  // ----- locale / auth -----
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  /// Simple mock login (if no api). If api provided, tries server-side verifyOtp.
  Future<bool> login({required String phone, String? otp}) async {
    if (api != null) {
      try {
        final user = await api!.verifyOtp(phone, otp ?? '');
        if (user != null) {
          _isAuthenticated = true;
          _currentUser = user;
          notifyListeners();
          return true;
        }
        return false;
      } catch (e) {
        // fallback to mock behaviour on error
      }
    }
    // Mock login: accept any non-empty phone
    if (phone.trim().isEmpty) return false;
    _isAuthenticated = true;
    _currentUser = User(id: 'mock-${phone}', phone: phone);
    notifyListeners();
    return true;
  }

  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }

  // ----- user -----
  User? _currentUser;
  User? get currentUser => _currentUser;

  // ----- signup (mock or server) -----
  Future<bool> signup({
    required String username,
    required String mobile,
    required String city,
    int entries = 1,
  }) async {
    if (api != null) {
      try {
        final p = await api!.createParticipant(
          username: username,
          mobile: mobile,
          city: city,
          entries: entries,
        );
        if (p != null) {
          _participants.add(p);
          _collectedRevenue += entries * _drawConfig.entryFee;
          _isAuthenticated = true;
          _currentUser = User(id: p.id, phone: p.mobileNumber, name: p.username);
          notifyListeners();
          return true;
        }
      } catch (e) {
        // fallback to mock
      }
    }

    // Mock path
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
    _currentUser = User(id: participant.id, phone: mobile, name: username);
    notifyListeners();
    return true;
  }

  // ----- payments -----
  /// Record revenue locally and optionally send to server.
  Future<void> recordPayment(double amount,
      {String? provider, String? providerOrderId}) async {
    _collectedRevenue += amount;
    notifyListeners();
    if (api != null) {
      try {
        await api!.recordTransaction(
          amount: amount,
          provider: provider ?? 'mock',
          providerOrderId: providerOrderId,
        );
      } catch (_) {
        // swallow; already recorded locally
      }
    }
  }

  // ----- broadcasts -----
  void sendBroadcast(String message, {bool persistServer = false}) {
    final msg = message.trim();
    if (msg.isEmpty) return;
    _broadcastHistory.add(msg);
    notifyListeners();
    if (persistServer && api != null) {
      api!.postBroadcast(msg).catchError((_) {
        // ignore server error
      });
    }
  }

  // ----- finalists selection -----
  void selectRandomFinalists({int? count}) {
    final take = count ?? _drawConfig.finalistsPerDraw;
    final copy = List<Participant>.of(_participants);
    copy.shuffle(_random);
    _finalists = copy.take(min(take, copy.length)).toList();
    notifyListeners();

    if (api != null) {
      api!.saveFinalists(_finalists).catchError((_) {});
    }
  }

  // ----- spin logic -----
  /// Spin for a participant (by id). Returns prize label.
  /// Emits selected index on spinStream for UI animation.
  Future<String> spinFor(String participantId) async {
    if (_wheelSegments.isEmpty) return 'Next Time';

    final selectedIndex = _random.nextInt(_wheelSegments.length);
    final prize = _wheelSegments[selectedIndex];

    // emit to UI to spin to that index
    _spinController.add(selectedIndex);

    // apply result locally and optionally persist
    final participantIndex =
        _participants.indexWhere((p) => p.id == participantId);
    if (participantIndex != -1 && prize != 'Next Time') {
      final updatedParticipant = _participants[participantIndex].copyWith(
        status: ParticipantStatus.winner,
        prize: prize,
      );
      _participants[participantIndex] = updatedParticipant;

      final winner = Winner(
        participant: updatedParticipant,
        prize: prize,
        videoUrl:
            'https://cdn.example.com/videos/${participantId.toLowerCase()}.mp4',
        announcedOn: DateTime.now(),
      );
      _winners = [winner, ..._winners];
      notifyListeners();

      if (api != null) {
        api!
            .recordWinner(winner)
            .catchError((_) {}); // attempt to persist winner
      }
    } else {
      // if Next Time or participant not found just notify
      notifyListeners();
    }

    return prize;
  }

  // ----- utility: load data from server if available -----
  Future<void> _loadFromServer() async {
    try {
      final serverDraw = await api!.fetchDrawConfig();
      _drawConfig = serverDraw ?? _drawConfig; // keep mock if null

      final serverSegments = await api!.fetchWheelSegments();
      if (serverSegments.isNotEmpty) {
        _wheelSegments = serverSegments;
      }

      final serverPayments = await api!.fetchPaymentOptions();
      if (serverPayments.isNotEmpty) {
        _paymentOptions
          ..clear()
          ..addAll(serverPayments);
      }

      final serverParticipants = await api!.fetchParticipants();
      if (serverParticipants.isNotEmpty) {
        _participants = serverParticipants;
      }

      final serverWinners = await api!.fetchWinners();
      if (serverWinners.isNotEmpty) {
        _winners = serverWinners;
      }

      final revenue = await api!.fetchCollectedRevenue();
      if (revenue != null) {
        _collectedRevenue = revenue;
      }

      notifyListeners();
    } catch (e) {
      // network error or server not ready -> keep mock data
    }
  }

  // ----- lifecycle -----
  @override
  void dispose() {
    _spinController.close();
    super.dispose();
  }
}
