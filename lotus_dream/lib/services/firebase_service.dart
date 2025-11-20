import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/models/draw_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Draw>> listenDraws() {
    return _db.collection('draws').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Draw.fromJson(doc.data())).toList());
  }

  Future<void> addParticipant(String drawId, Map<String, dynamic> userData) {
    return _db.collection('draws').doc(drawId)
      .update({'participants': FieldValue.arrayUnion([userData])});
  }

  Future<void> selectWinners(String drawId, List<Map<String, dynamic>> winners) {
    return _db.collection('draws').doc(drawId).update({'winners': winners});
  }
}
