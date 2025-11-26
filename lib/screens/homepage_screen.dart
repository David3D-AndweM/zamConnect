import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_bottom_nav.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  String _userName = 'User';
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const ChangeTabEvent(0));
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final profile = await _firestoreService.getUserProfile(user.uid);
      if (mounted) {
        setState(() {
          _userName = profile?.name ?? user.displayName ?? 'User';
        });
      }
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    final homeBloc = context.read<HomeBloc>();
    final currentState = homeBloc.state;

    if (currentState is HomeLoaded && currentState.currentTab == index) {
      return;
    }

    homeBloc.add(ChangeTabEvent(index));

    switch (index) {
      case 0:
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

  void _navigateToEmergency(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency Contacts'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Police: 999', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Ambulance: 991', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Fire: 993', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('ZESCO: 1144', style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
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
                Text(
                  'Welcome, $_userName!',
                  style: const TextStyle(
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
                      backgroundColor: const Color(0xFF2196F3),
                    ),
                    _buildActionCard(
                      title: 'Volunteer',
                      icon: Icons.people_outline,
                      onTap: () => _navigateToVolunteer(context),
                      backgroundColor: const Color(0xFF4CAF50),
                    ),
                    _buildActionCard(
                      title: 'Emergency',
                      icon: Icons.local_hospital_outlined,
                      onTap: () => _navigateToEmergency(context),
                      backgroundColor: const Color(0xFFFF5722),
                    ),
                    _buildActionCard(
                      title: 'Explore',
                      icon: Icons.location_on_outlined,
                      onTap: () => _navigateToExplore(context),
                      backgroundColor: const Color(0xFFFFC107),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Together, we\'re building a greener and more connected Zambia — one job, one project and one journey at a time.',
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
    required Color backgroundColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
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
