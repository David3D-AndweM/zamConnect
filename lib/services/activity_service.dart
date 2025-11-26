import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user's job applications
  Future<List<Map<String, dynamic>>> getUserJobApplications(String userId) async {
    try {
      List<Map<String, dynamic>> applications = [];

      // Get all jobs
      final jobsSnapshot = await _firestore.collection('jobs').get();

      for (var jobDoc in jobsSnapshot.docs) {
        // Check if user has applied to this job
        final applicationSnapshot = await _firestore
            .collection('jobs')
            .doc(jobDoc.id)
            .collection('applications')
            .where('userId', isEqualTo: userId)
            .get();

        if (applicationSnapshot.docs.isNotEmpty) {
          final jobData = jobDoc.data();
          applications.add({
            'jobId': jobDoc.id,
            'title': jobData['title'],
            'company': jobData['company'],
            'salary': jobData['salary'],
            'icon': jobData['icon'],
            'appliedAt': applicationSnapshot.docs.first.data()['appliedAt'],
          });
        }
      }

      return applications;
    } catch (e) {
      print('Error getting job applications: $e');
      return [];
    }
  }

  // Get user's volunteer applications
  Future<List<Map<String, dynamic>>> getUserVolunteerApplications(String userId) async {
    try {
      List<Map<String, dynamic>> applications = [];

      final volunteersSnapshot = await _firestore.collection('volunteers').get();

      for (var volunteerDoc in volunteersSnapshot.docs) {
        final applicationSnapshot = await _firestore
            .collection('volunteers')
            .doc(volunteerDoc.id)
            .collection('applications')
            .where('userId', isEqualTo: userId)
            .get();

        if (applicationSnapshot.docs.isNotEmpty) {
          final volunteerData = volunteerDoc.data();
          applications.add({
            'volunteerId': volunteerDoc.id,
            'name': volunteerData['name'],
            'description': volunteerData['description'],
            'icon': volunteerData['icon'],
            'appliedAt': applicationSnapshot.docs.first.data()['appliedAt'],
          });
        }
      }

      return applications;
    } catch (e) {
      print('Error getting volunteer applications: $e');
      return [];
    }
  }

  // Get user's trip bookings
  Future<List<Map<String, dynamic>>> getUserTripBookings(String userId) async {
    try {
      List<Map<String, dynamic>> bookings = [];

      final destinationsSnapshot = await _firestore.collection('destinations').get();

      for (var destinationDoc in destinationsSnapshot.docs) {
        final bookingSnapshot = await _firestore
            .collection('destinations')
            .doc(destinationDoc.id)
            .collection('bookings')
            .where('userId', isEqualTo: userId)
            .get();

        if (bookingSnapshot.docs.isNotEmpty) {
          final destinationData = destinationDoc.data();
          bookings.add({
            'destinationId': destinationDoc.id,
            'name': destinationData['name'],
            'description': destinationData['description'],
            'icon': destinationData['icon'],
            'bookedAt': bookingSnapshot.docs.first.data()['bookedAt'],
          });
        }
      }

      return bookings;
    } catch (e) {
      print('Error getting trip bookings: $e');
      return [];
    }
  }
}
