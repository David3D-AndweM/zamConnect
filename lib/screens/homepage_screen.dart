import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_bottom_nav.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart'; // Add this import

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize home bloc with default tab
    context.read<HomeBloc>().add(const ChangeTabEvent(0));
  }

  void _onItemTapped(BuildContext context, int index) {
    final homeBloc = context.read<HomeBloc>();
    final currentState = homeBloc.state;
    
    // Check if current tab is the same, if yes then return
    if (currentState is HomeLoaded && currentState.currentTab == index) {
      return;
    }
    
    homeBloc.add(ChangeTabEvent(index));
    
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

  void _navigateToFindJob(BuildContext context) {
    _onItemTapped(context, 1);
  }

  void _navigateToVolunteer(BuildContext context) {
    _onItemTapped(context, 2);
  }

  void _navigateToExplore(BuildContext context) {
    _onItemTapped(context, 3);
  }

  void _navigateToProfile(BuildContext context) {
    _onItemTapped(context, 4);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentTab = state is HomeLoaded ? state.currentTab : 0;
        
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
                      onTap: () => _navigateToFindJob(context),
                      color: const Color(0xFF2E7D32),
                    ),
                    _buildActionCard(
                      title: 'Volunteer',
                      icon: Icons.people_outline,
                      onTap: () => _navigateToVolunteer(context),
                      color: const Color(0xFF4CAF50),
                    ),
                    _buildActionCard(
                      title: 'Explore',
                      icon: Icons.explore_outlined,
                      onTap: () => _navigateToExplore(context),
                      color: const Color(0xFF2196F3),
                    ),
                    _buildActionCard(
                      title: 'My profile',
                      icon: Icons.person_outline,
                      onTap: () => _navigateToProfile(context),
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
                    color: const Color(0xFF2E7D32).withOpacity(0.1),
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
            currentIndex: currentTab,
            onTap: (index) => _onItemTapped(context, index),
          ),
        );
      },
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