import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class Destination {
  final String name;
  final String description;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;

  const Destination({
    required this.name,
    required this.description,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
  });
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 3;

  final List<Destination> _destinations = const [
    Destination(
      name: 'Victoria Falls',
      description: 'The Smoke that Thunders',
      icon: Icons.water,
      gradientStart: Color(0xFF1565C0),
      gradientEnd: Color(0xFF42A5F5),
    ),
    Destination(
      name: 'South Luangwa',
      description: 'Premier Safari Destination',
      icon: Icons.pets,
      gradientStart: Color(0xFF2E7D32),
      gradientEnd: Color(0xFF66BB6A),
    ),
    Destination(
      name: 'Lake Kariba',
      description: 'Africa\'s Largest Man-Made Lake',
      icon: Icons.sailing,
      gradientStart: Color(0xFF0097A7),
      gradientEnd: Color(0xFF4DD0E1),
    ),
    Destination(
      name: 'Kafue National Park',
      description: 'Wild & Untamed Wilderness',
      icon: Icons.forest,
      gradientStart: Color(0xFF558B2F),
      gradientEnd: Color(0xFF8BC34A),
    ),
    Destination(
      name: 'Lower Zambezi',
      description: 'River Safari Adventures',
      icon: Icons.kayaking,
      gradientStart: Color(0xFF00695C),
      gradientEnd: Color(0xFF26A69A),
    ),
    Destination(
      name: 'Livingstone',
      description: 'Adventure Capital of Africa',
      icon: Icons.paragliding,
      gradientStart: Color(0xFFE65100),
      gradientEnd: Color(0xFFFF9800),
    ),
  ];

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
      case 3: break;
      case 4: Navigator.pushReplacementNamed(context, '/profile'); break;
    }
  }

  void _bookTrip(Destination destination) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book Trip to ${destination.name}'),
        content: Text('Would you like to book a trip to ${destination.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Trip to ${destination.name} booked!'),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
            ),
            child: const Text('Book Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Zambia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _destinations.length,
        itemBuilder: (context, index) {
          final destination = _destinations[index];
          return _buildDestinationCard(destination);
        },
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDestinationCard(Destination destination) {
    return GestureDetector(
      onTap: () => _bookTrip(destination),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [destination.gradientStart, destination.gradientEnd],
          ),
          boxShadow: [
            BoxShadow(
              color: destination.gradientStart.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                destination.icon,
                size: 120,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      destination.icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    destination.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destination.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Book Trip',
                      style: TextStyle(
                        color: destination.gradientStart,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
}
