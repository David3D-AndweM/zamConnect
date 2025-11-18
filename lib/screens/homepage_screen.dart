import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  void _navigateToFindJob() {
    // Navigate to Find Job screen
  }

  void _navigateToVolunteer() {
    // Navigate to Volunteer screen
  }

  void _navigateToExplore() {
    // Navigate to Explore screen
  }

  void _navigateToProfile() {
    // Navigate to Profile screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZambiConnect'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            
            // Welcome Section
            const Text(
              'Welcome, User!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            Text(
              AppConstants.welcomeMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            
            // Action Buttons Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildActionCard(
                  title: 'Find Job',
                  icon: Icons.work_outline,
                  onTap: _navigateToFindJob,
                  color: AppTheme.primaryColor,
                ),
                _buildActionCard(
                  title: 'Volunteer',
                  icon: Icons.people_outline,
                  onTap: _navigateToVolunteer,
                  color: AppTheme.secondaryColor,
                ),
                _buildActionCard(
                  title: 'Explore',
                  icon: Icons.explore_outlined,
                  onTap: _navigateToExplore,
                  color: const Color(0xFF2196F3),
                ),
                _buildActionCard(
                  title: 'My profile',
                  icon: Icons.person_outline,
                  onTap: _navigateToProfile,
                  color: const Color(0xFF9C27B0),
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // Mission Statement
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                AppConstants.missionStatement,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textColor,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}