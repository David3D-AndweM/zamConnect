import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/destination_model.dart';

class DestinationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DestinationModel>> getDestinations() {
    return _firestore.collection('destinations').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DestinationModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> bookTrip(String destinationId, String userId) async {
    try {
      await _firestore.collection('destinations').doc(destinationId).collection('bookings').add({
        'userId': userId,
        'bookedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error booking trip: $e');
      rethrow;
    }
  }
}
