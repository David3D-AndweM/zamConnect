import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_model.dart';
import '../models/volunteer_model.dart';
import '../models/destination_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserProfile(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  Stream<List<JobModel>> getJobs() {
    return _db.collection('jobs').orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => JobModel.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  Future<void> applyForJob(String jobId, String userId) async {
    await _db.collection('applications').add({
      'jobId': jobId,
      'userId': userId,
      'status': 'pending',
      'appliedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<VolunteerModel>> getVolunteerOrgs() {
    return _db.collection('volunteer_orgs').snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => VolunteerModel.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  Future<void> applyForVolunteer(String orgId, String userId) async {
    await _db.collection('volunteer_applications').add({
      'orgId': orgId,
      'userId': userId,
      'status': 'pending',
      'appliedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<DestinationModel>> getDestinations() {
    return _db.collection('destinations').snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => DestinationModel.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  Future<void> bookTrip(String destinationId, String userId) async {
    await _db.collection('bookings').add({
      'destinationId': destinationId,
      'userId': userId,
      'status': 'pending',
      'bookedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> saveDestination(String userId, String destinationId) async {
    await _db.collection('users').doc(userId).update({
      'savedDestinations': FieldValue.arrayUnion([destinationId]),
    });
  }

  Stream<List<Map<String, dynamic>>> getUserApplications(String userId) {
    return _db
        .collection('applications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
  }

  Stream<List<Map<String, dynamic>>> getUserVolunteering(String userId) {
    return _db
        .collection('volunteer_applications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
  }
}
