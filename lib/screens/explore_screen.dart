import 'package:flutter/material.dart';
import 'forms/trip_booking_form.dart';

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

class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent> {
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

  void _bookTrip(Destination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripBookingForm(
          destinationName: destination.name,
          description: destination.description,
          themeColor: destination.gradientStart,
        ),
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
          return _DestinationCard(
            destination: destination,
            onTap: () => _bookTrip(destination),
          );
        },
      ),
    );
  }
}

class _DestinationCard extends StatefulWidget {
  final Destination destination;
  final VoidCallback onTap;

  const _DestinationCard({
    required this.destination,
    required this.onTap,
  });

  @override
  State<_DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<_DestinationCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.destination.gradientStart, widget.destination.gradientEnd],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.destination.gradientStart.withAlpha(100),
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
                  widget.destination.icon,
                  size: 120,
                  color: Colors.white.withAlpha(50),
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
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.destination.icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.destination.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.destination.description,
                      style: TextStyle(
                        color: Colors.white.withAlpha(230),
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
                          color: widget.destination.gradientStart,
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
      ),
    );
  }
}
