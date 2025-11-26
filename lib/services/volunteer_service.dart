import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/volunteer_model.dart';

class VolunteerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<VolunteerModel>> getVolunteerOpportunities() {
    return _firestore.collection('volunteers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return VolunteerModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> applyForVolunteer(String volunteerId, String userId) async {
    try {
      await _firestore.collection('volunteers').doc(volunteerId).collection('applications').add({
        'userId': userId,
        'appliedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error applying for volunteer opportunity: $e');
      rethrow;
    }
  }
}
