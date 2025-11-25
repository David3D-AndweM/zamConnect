import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_model.dart';
import '../models/volunteer_model.dart';
import '../models/destination_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  FirebaseFirestore? _db;
  bool _isFirebaseInitialized = false;

  FirestoreService() {
    _initFirebase();
  }

  void _initFirebase() {
    try {
      _db = FirebaseFirestore.instance;
      _isFirebaseInitialized = true;
    } catch (e) {
      _isFirebaseInitialized = false;
    }
  }

  Future<void> createUserProfile(UserModel user) async {
    if (!_isFirebaseInitialized) return;
    await _db!.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUserProfile(String uid) async {
    if (!_isFirebaseInitialized) return null;
    final doc = await _db!.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    if (!_isFirebaseInitialized) return;
    await _db!.collection('users').doc(uid).update(data);
  }

  Stream<List<JobModel>> getJobs() {
    if (!_isFirebaseInitialized) return Stream.value([]);
    return _db!.collection('jobs').orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => JobModel.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  Future<void> applyForJob({
    required String jobId,
    required String userId,
    required String name,
    required String email,
    required String phone,
    required String experienceLevel,
    required String coverLetter,
  }) async {
    if (!_isFirebaseInitialized) return;
    await _db!.collection('job_applications').add({
      'jobId': jobId,
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'experienceLevel': experienceLevel,
      'coverLetter': coverLetter,
      'status': 'pending',
      'appliedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<VolunteerModel>> getVolunteerOrgs() {
    if (!_isFirebaseInitialized) return Stream.value([]);
    return _db!.collection('volunteer_orgs').snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => VolunteerModel.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  Future<void> applyForVolunteer({
    required String orgId,
    required String userId,
    required String name,
    required String email,
    required String phone,
    required String availability,
    required String duration,
    required bool hasExperience,
    required String motivation,
  }) async {
    if (!_isFirebaseInitialized) return;
    await _db!.collection('volunteer_applications').add({
      'orgId': orgId,
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'availability': availability,
      'duration': duration,
      'hasExperience': hasExperience,
      'motivation': motivation,
      'status': 'pending',
      'appliedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<DestinationModel>> getDestinations() {
    if (!_isFirebaseInitialized) return Stream.value([]);
    return _db!.collection('destinations').snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => DestinationModel.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  Future<void> bookTrip({
    required String destinationId,
    required String userId,
    required String name,
    required String email,
    required String phone,
    required DateTime travelDate,
    required int numberOfGuests,
    required String packageType,
    required bool includeTransport,
    required bool includeAccommodation,
    String? specialRequests,
  }) async {
    if (!_isFirebaseInitialized) return;
    await _db!.collection('trip_bookings').add({
      'destinationId': destinationId,
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'travelDate': Timestamp.fromDate(travelDate),
      'numberOfGuests': numberOfGuests,
      'packageType': packageType,
      'includeTransport': includeTransport,
      'includeAccommodation': includeAccommodation,
      'specialRequests': specialRequests,
      'status': 'pending',
      'bookedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> saveDestination(String userId, String destinationId) async {
    if (!_isFirebaseInitialized) return;
    await _db!.collection('users').doc(userId).update({
      'savedDestinations': FieldValue.arrayUnion([destinationId]),
    });
  }

  Stream<List<Map<String, dynamic>>> getUserApplications(String userId) {
    if (!_isFirebaseInitialized) return Stream.value([]);
    return _db!
        .collection('job_applications')
        .where('userId', isEqualTo: userId)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
  }

  Stream<List<Map<String, dynamic>>> getUserVolunteering(String userId) {
    if (!_isFirebaseInitialized) return Stream.value([]);
    return _db!
        .collection('volunteer_applications')
        .where('userId', isEqualTo: userId)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
  }

  Stream<List<Map<String, dynamic>>> getUserBookings(String userId) {
    if (!_isFirebaseInitialized) return Stream.value([]);
    return _db!
        .collection('trip_bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('bookedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
  }

  Future<void> cancelApplication(String collectionName, String docId) async {
    if (!_isFirebaseInitialized) return;
    await _db!.collection(collectionName).doc(docId).update({
      'status': 'cancelled',
      'cancelledAt': FieldValue.serverTimestamp(),
    });
  }
}
