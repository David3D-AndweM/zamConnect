import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_model.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<JobModel>> getJobs() {
    return _firestore.collection('jobs').orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return JobModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> applyForJob(String jobId, String userId) async {
    try {
      await _firestore.collection('jobs').doc(jobId).collection('applications').add({
        'userId': userId,
        'appliedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error applying for job: $e');
      rethrow;
    }
  }
}
