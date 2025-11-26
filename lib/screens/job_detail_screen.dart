import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';

class JobDetailScreen extends StatelessWidget {
  final JobModel job;

  const JobDetailScreen({super.key, required this.job});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'work': return Icons.work;
      case 'tour': return Icons.tour;
      case 'people': return Icons.people;
      case 'nature': return Icons.nature;
      case 'agriculture': return Icons.agriculture;
      case 'hotel': return Icons.hotel;
      default: return Icons.work;
    }
  }

  void _applyForJob(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to apply for jobs.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Apply for ${job.title}'),
        content: Text('Would you like to apply for the ${job.title} position at ${job.company}?'),
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
                await JobService().applyForJob(job.id, userId);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Application submitted for ${job.title}!'),
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                );
                navigator.pop(); // Go back to jobs list
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
              backgroundColor: const Color(0xFF4CAF50),
            ),
            child: const Text('Apply', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
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
                    const Color(0xFF4CAF50),
                    const Color(0xFF4CAF50).withOpacity(0.8),
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
                      _getIconData(job.icon),
                      size: 40,
                      color: const Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.company,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
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
                  // Salary
                  _buildDetailRow(
                    icon: Icons.attach_money,
                    title: 'Salary',
                    content: job.salary,
                    color: const Color(0xFF4CAF50),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Job Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    job.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
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
                  _buildRequirement('Relevant experience in the field'),
                  _buildRequirement('Strong communication skills'),
                  _buildRequirement('Ability to work in a team'),
                  _buildRequirement('Passion for conservation and sustainability'),

                  const SizedBox(height: 32),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _applyForJob(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
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

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequirement(String requirement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF4CAF50),
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
