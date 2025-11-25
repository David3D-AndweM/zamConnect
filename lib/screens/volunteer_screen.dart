import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class VolunteerOrg {
  final String name;
  final String description;
  final IconData icon;
  final Color iconColor;

  const VolunteerOrg({
    required this.name,
    required this.description,
    required this.icon,
    required this.iconColor,
  });
}

class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({super.key});

  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  int _currentIndex = 2;

  final List<VolunteerOrg> _organizations = const [
    VolunteerOrg(
      name: 'Africa Access Water',
      description: 'Help provide clean water access to rural communities across Zambia. Join our water conservation and well-building projects.',
      icon: Icons.water_drop,
      iconColor: Color(0xFF2196F3),
    ),
    VolunteerOrg(
      name: 'WWF Zambia',
      description: 'Protect wildlife and natural habitats. Participate in anti-poaching patrols, wildlife monitoring, and community education programs.',
      icon: Icons.pets,
      iconColor: Color(0xFF4CAF50),
    ),
    VolunteerOrg(
      name: 'Lusaka City Council',
      description: 'Urban development and community improvement projects. Help with tree planting, waste management, and public space beautification.',
      icon: Icons.location_city,
      iconColor: Color(0xFF9C27B0),
    ),
    VolunteerOrg(
      name: 'ZICONA Zambia',
      description: 'Environmental conservation and sustainable agriculture. Work on reforestation projects and teach sustainable farming practices.',
      icon: Icons.eco,
      iconColor: Color(0xFF2E7D32),
    ),
    VolunteerOrg(
      name: 'Red Cross Zambia',
      description: 'Humanitarian aid and disaster relief. Assist with health campaigns, first aid training, and emergency response activities.',
      icon: Icons.health_and_safety,
      iconColor: Color(0xFFF44336),
    ),
    VolunteerOrg(
      name: 'Habitat for Humanity',
      description: 'Build homes for families in need. Join construction teams and help create safe, affordable housing in Zambian communities.',
      icon: Icons.home,
      iconColor: Color(0xFFFF9800),
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
      case 2: break;
      case 3: Navigator.pushReplacementNamed(context, '/explore'); break;
      case 4: Navigator.pushReplacementNamed(context, '/profile'); break;
    }
  }

  void _applyToVolunteer(VolunteerOrg org) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Join ${org.name}'),
        content: Text('Would you like to apply to volunteer with ${org.name}?'),
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
                  content: Text('Application submitted to ${org.name}!'),
                  backgroundColor: const Color(0xFF2196F3),
                ),
              );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conservation Volunteering',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _organizations.length,
        itemBuilder: (context, index) {
          final org = _organizations[index];
          return _buildVolunteerCard(org);
        },
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildVolunteerCard(VolunteerOrg org) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    org.icon,
                    color: org.iconColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    org.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              org.description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF424242),
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _applyToVolunteer(org),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
