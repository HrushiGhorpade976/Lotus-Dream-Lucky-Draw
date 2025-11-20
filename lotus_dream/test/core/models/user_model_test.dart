import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_dream/core/models/user_model.dart';

void main() {
  group('User Model', () {
    test('fromJson creates correct User object', () {
      final json = {'id': '123', 'name': 'John', 'email': 'john@example.com'};
      final user = User.fromJson(json);

      expect(user.id, '123');
      expect(user.name, 'John');
      expect(user.email, 'john@example.com');
    });

    test('toJson returns correct map', () {
      final user = User(id: '456', name: 'Alice', email: 'alice@example.com');
      final json = user.toJson();

      expect(json['id'], '456');
      expect(json['name'], 'Alice');
      expect(json['email'], 'alice@example.com');
    });
  });
}
