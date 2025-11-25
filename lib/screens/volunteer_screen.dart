import 'package:flutter/material.dart';
import 'forms/volunteer_application_form.dart';

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

class VolunteerContent extends StatefulWidget {
  const VolunteerContent({super.key});

  @override
  State<VolunteerContent> createState() => _VolunteerContentState();
}

class _VolunteerContentState extends State<VolunteerContent> {
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

  void _applyToVolunteer(VolunteerOrg org) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VolunteerApplicationForm(
          organizationName: org.name,
          icon: org.icon,
          iconColor: org.iconColor,
        ),
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
          return _VolunteerCard(
            org: org,
            onApply: () => _applyToVolunteer(org),
          );
        },
      ),
    );
  }
}

class _VolunteerCard extends StatefulWidget {
  final VolunteerOrg org;
  final VoidCallback onApply;

  const _VolunteerCard({
    required this.org,
    required this.onApply,
  });

  @override
  State<_VolunteerCard> createState() => _VolunteerCardState();
}

class _VolunteerCardState extends State<_VolunteerCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
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
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Card(
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
                        widget.org.icon,
                        color: widget.org.iconColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.org.name,
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
                  widget.org.description,
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
                  child: FilledButton(
                    onPressed: widget.onApply,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
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
        ),
      ),
    );
  }
}
