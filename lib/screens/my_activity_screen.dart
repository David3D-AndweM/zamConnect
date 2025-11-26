import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/activity_service.dart';
import '../widgets/custom_bottom_nav.dart';

class MyActivityScreen extends StatefulWidget {
  const MyActivityScreen({super.key});

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ActivityService _activityService = ActivityService();
  int _currentIndex = 4;

  List<Map<String, dynamic>> _jobApplications = [];
  List<Map<String, dynamic>> _volunteerApplications = [];
  List<Map<String, dynamic>> _tripBookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserActivities();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUserActivities() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    setState(() => _isLoading = true);

    final jobs = await _activityService.getUserJobApplications(userId);
    final volunteers = await _activityService.getUserVolunteerApplications(userId);
    final trips = await _activityService.getUserTripBookings(userId);

    if (mounted) {
      setState(() {
        _jobApplications = jobs;
        _volunteerApplications = volunteers;
        _tripBookings = trips;
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    _navigateToTab(index);
  }

  void _navigateToTab(int index) {
    switch (index) {
      case 0: Navigator.pushReplacementNamed(context, '/homepage'); break;
      case 1: Navigator.pushReplacementNamed(context, '/jobs'); break;
      case 2: Navigator.pushReplacementNamed(context, '/volunteer'); break;
      case 3: Navigator.pushReplacementNamed(context, '/explore'); break;
      case 4: Navigator.pushReplacementNamed(context, '/profile'); break;
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'work': return Icons.work;
      case 'tour': return Icons.tour;
      case 'people': return Icons.people;
      case 'nature': return Icons.nature;
      case 'agriculture': return Icons.agriculture;
      case 'hotel': return Icons.hotel;
      case 'water_drop': return Icons.water_drop;
      case 'pets': return Icons.pets;
      case 'location_city': return Icons.location_city;
      case 'eco': return Icons.eco;
      case 'health_and_safety': return Icons.health_and_safety;
      case 'home': return Icons.home;
      case 'water': return Icons.water;
      case 'sailing': return Icons.sailing;
      case 'forest': return Icons.forest;
      case 'kayaking': return Icons.kayaking;
      case 'paragliding': return Icons.paragliding;
      default: return Icons.bookmark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Activity', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF2E7D32),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF2E7D32),
          tabs: const [
            Tab(text: 'Jobs'),
            Tab(text: 'Volunteer'),
            Tab(text: 'Trips'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildJobApplicationsList(),
                _buildVolunteerApplicationsList(),
                _buildTripBookingsList(),
              ],
            ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildJobApplicationsList() {
    if (_jobApplications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_off, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No job applications yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Start applying to see them here!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadUserActivities,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _jobApplications.length,
        itemBuilder: (context, index) {
          final application = _jobApplications[index];
          return _buildJobApplicationCard(application);
        },
      ),
    );
  }

  Widget _buildJobApplicationCard(Map<String, dynamic> application) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getIconData(application['icon'] ?? 'work'),
                color: const Color(0xFF4CAF50),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    application['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    application['company'] ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    application['salary'] ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerApplicationsList() {
    if (_volunteerApplications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.volunteer_activism, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No volunteer applications yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Start volunteering to see them here!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadUserActivities,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _volunteerApplications.length,
        itemBuilder: (context, index) {
          final application = _volunteerApplications[index];
          return _buildVolunteerApplicationCard(application);
        },
      ),
    );
  }

  Widget _buildVolunteerApplicationCard(Map<String, dynamic> application) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getIconData(application['icon'] ?? 'volunteer_activism'),
                color: const Color(0xFF2196F3),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    application['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    application['description'] ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.check_circle, color: Color(0xFF2196F3)),
          ],
        ),
      ),
    );
  }

  Widget _buildTripBookingsList() {
    if (_tripBookings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flight_takeoff, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No trip bookings yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Start exploring to see bookings here!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadUserActivities,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tripBookings.length,
        itemBuilder: (context, index) {
          final booking = _tripBookings[index];
          return _buildTripBookingCard(booking);
        },
      ),
    );
  }

  Widget _buildTripBookingCard(Map<String, dynamic> booking) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9800).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getIconData(booking['icon'] ?? 'place'),
                color: const Color(0xFFFF9800),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking['description'] ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const Icon(Icons.check_circle, color: Color(0xFFFF9800)),
          ],
        ),
      ),
    );
  }
}
