import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_dream/core/models/draw_model.dart';

void main() {
  group('Draw Model', () {
    test('fromJson and toJson work correctly', () {
      final json = {
        'id': 'draw1',
        'name': 'Test Draw',
        'entryFee': 100.0,
        'participants': [
          {'id': 'u1', 'name': 'John', 'email': 'john@example.com'}
        ],
        'winners': []
      };

      final draw = Draw.fromJson(json);
      expect(draw.id, 'draw1');
      expect(draw.participants.length, 1);
      expect(draw.winners.length, 0);

      final toJson = draw.toJson();
      expect(toJson['id'], 'draw1');
    });
  });
}
