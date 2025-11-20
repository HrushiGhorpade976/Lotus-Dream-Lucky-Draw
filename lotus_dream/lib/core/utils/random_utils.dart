import '../models/user_model.dart';
import '../constants.dart';
import 'dart:math';

class RandomUtils {
  static List<User> pickWinners(List<User> participants, {int count = AppConstants.maxWinners}) {
    final random = Random();
    final winners = <User>[];
    final tempList = List<User>.from(participants);

    for (int i = 0; i < count && tempList.isNotEmpty; i++) {
      int index = random.nextInt(tempList.length);
      winners.add(tempList[index]);
      tempList.removeAt(index);
    }
    return winners;
  }
}
