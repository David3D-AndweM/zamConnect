import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 4;

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
      case 4: break;
    }
  }

  void _handleMenuTap(String menuItem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$menuItem - Coming soon!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF44336),
            ),
            child: const Text('Log Out', style: TextStyle(color: Colors.white)),
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
          'ZambiConnect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildProfileSection(),
            const SizedBox(height: 32),
            _buildMenuItem(
              icon: Icons.person_outline,
              title: 'My Account',
              onTap: () => _handleMenuTap('My Account'),
            ),
            _buildMenuItem(
              icon: Icons.work_outline,
              title: 'My Applications',
              onTap: () => _handleMenuTap('My Applications'),
            ),
            _buildMenuItem(
              icon: Icons.volunteer_activism_outlined,
              title: 'My Volunteering',
              onTap: () => _handleMenuTap('My Volunteering'),
            ),
            _buildMenuItem(
              icon: Icons.bookmark_outline,
              title: 'Saved Destinations',
              onTap: () => _handleMenuTap('Saved Destinations'),
            ),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => _handleMenuTap('Settings'),
            ),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => _handleMenuTap('Help & Support'),
            ),
            const SizedBox(height: 16),
            _buildLogoutButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: 60,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Guest User',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Sign in to access all features',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey.shade700,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF212121),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.logout,
          color: Color(0xFFF44336),
        ),
        title: const Text(
          'Log out',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF44336),
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: _handleLogout,
      ),
    );
  }
}
