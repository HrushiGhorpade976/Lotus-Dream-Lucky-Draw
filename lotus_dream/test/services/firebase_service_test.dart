import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_dream/services/firebase_service.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Example using MockFirestore
class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('FirebaseService', () {
    test('listenDraws returns a stream', () {
      final service = FirebaseService();
      final stream = service.listenDraws();

      expect(stream, isA<Stream>());
    });
  });
}
