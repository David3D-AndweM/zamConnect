import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/volunteer_model.dart';
import '../services/volunteer_service.dart';

class VolunteerDetailScreen extends StatelessWidget {
  final VolunteerModel volunteer;

  const VolunteerDetailScreen({super.key, required this.volunteer});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'water_drop': return Icons.water_drop;
      case 'pets': return Icons.pets;
      case 'location_city': return Icons.location_city;
      case 'eco': return Icons.eco;
      case 'health_and_safety': return Icons.health_and_safety;
      case 'home': return Icons.home;
      case 'nature_people': return Icons.nature_people;
      case 'school': return Icons.school;
      default: return Icons.volunteer_activism;
    }
  }

  Color _getColor(String colorString) {
    return Color(int.parse(colorString));
  }

  void _applyToVolunteer(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to apply for volunteer opportunities.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Join ${volunteer.name}'),
        content: Text('Would you like to apply to volunteer with ${volunteer.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final navigator = Navigator.of(context);

              try {
                await VolunteerService().applyForVolunteer(volunteer.id, userId);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Application submitted to ${volunteer.name}!'),
                    backgroundColor: const Color(0xFF2196F3),
                  ),
                );
                navigator.pop(); // Go back to volunteer list
              } catch (e) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Error submitting application: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
            ),
            child: const Text('Apply', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _getColor(volunteer.iconColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    iconColor,
                    iconColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      _getIconData(volunteer.icon),
                      size: 40,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    volunteer.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  const Text(
                    'About This Opportunity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    volunteer.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // What You'll Do
                  const Text(
                    'What You\'ll Do',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActivity('Participate in community projects'),
                  _buildActivity('Work with local teams'),
                  _buildActivity('Make a positive impact'),
                  _buildActivity('Gain valuable experience'),

                  const SizedBox(height: 24),

                  // Requirements
                  const Text(
                    'Requirements',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRequirement('Passion for community service'),
                  _buildRequirement('Commitment to the cause'),
                  _buildRequirement('Willingness to learn'),
                  _buildRequirement('Team player attitude'),

                  const SizedBox(height: 32),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _applyToVolunteer(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: iconColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivity(String activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF2196F3),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              activity,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String requirement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.star,
            color: Colors.amber[700],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              requirement,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
