import 'package:flutter/material.dart';
import 'forms/edit_profile_form.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  void _handleMenuTap(String menuItem) {
    if (menuItem == 'My Account') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EditProfileForm()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$menuItem - Coming soon!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFF44336),
            ),
            child: const Text('Log Out'),
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
            _ProfileMenuItem(
              icon: Icons.person_outline,
              title: 'My Account',
              onTap: () => _handleMenuTap('My Account'),
            ),
            _ProfileMenuItem(
              icon: Icons.work_outline,
              title: 'My Applications',
              onTap: () => _handleMenuTap('My Applications'),
            ),
            _ProfileMenuItem(
              icon: Icons.volunteer_activism_outlined,
              title: 'My Volunteering',
              onTap: () => _handleMenuTap('My Volunteering'),
            ),
            _ProfileMenuItem(
              icon: Icons.bookmark_outline,
              title: 'Saved Destinations',
              onTap: () => _handleMenuTap('Saved Destinations'),
            ),
            _ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => _handleMenuTap('Settings'),
            ),
            _ProfileMenuItem(
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

class _ProfileMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<_ProfileMenuItem> createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<_ProfileMenuItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 80),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ListTile(
            leading: Icon(
              widget.icon,
              color: Colors.grey.shade700,
            ),
            title: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF212121),
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
