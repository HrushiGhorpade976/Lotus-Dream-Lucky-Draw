import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_dream/core/utils/random_utils.dart';
import 'package:lotus_dream/core/models/user_model.dart';

void main() {
  group('RandomUtils', () {
    test('pickWinners returns correct number of winners', () {
      final participants = List.generate(20, (i) => User(id: '$i', name: 'User $i', email: 'user$i@example.com'));
      final winners = RandomUtils.pickWinners(participants, count: 5);

      expect(winners.length, 5);
      for (var winner in winners) {
        expect(participants.contains(winner), true);
      }
    });

    test('pickWinners does not exceed participant count', () {
      final participants = [User(id: '1', name: 'John', email: 'john@example.com')];
      final winners = RandomUtils.pickWinners(participants, count: 5);

      expect(winners.length, 1);
    });
  });
}
