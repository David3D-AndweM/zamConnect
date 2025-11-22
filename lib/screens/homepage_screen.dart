import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _currentIndex = 0; // Home is active

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    
    setState(() {
      _currentIndex = index;
    });
    
    // Navigate to different screens based on index
    switch (index) {
      case 0:
        // Already on homepage
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/jobs');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/volunteer');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/explore');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  void _navigateToFindJob() {
    _onItemTapped(1); // Navigate to Jobs tab
  }

  void _navigateToVolunteer() {
    _onItemTapped(2); // Navigate to Volunteer tab
  }

  void _navigateToExplore() {
    _onItemTapped(3); // Navigate to Explore tab
  }

  void _navigateToProfile() {
    _onItemTapped(4); // Navigate to Profile tab
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
            
            const Text(
              'Ready to explore new jobs, volunteer projects and eco-tours across Zambia?',
              style: TextStyle(
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
                  color: Color(0xFF2E7D32),
                ),
                _buildActionCard(
                  title: 'Volunteer',
                  icon: Icons.people_outline,
                  onTap: _navigateToVolunteer,
                  color: Color(0xFF4CAF50),
                ),
                _buildActionCard(
                  title: 'Explore',
                  icon: Icons.explore_outlined,
                  onTap: _navigateToExplore,
                  color: Color(0xFF2196F3),
                ),
                _buildActionCard(
                  title: 'My profile',
                  icon: Icons.person_outline,
                  onTap: _navigateToProfile,
                  color: Color(0xFF9C27B0),
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // Mission Statement
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Together, we\'re building a greener and more connected Zambia — one job, one project and one journey at a time. 😊',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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