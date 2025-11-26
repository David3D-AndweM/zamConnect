import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/destination_model.dart';
import '../services/destination_service.dart';

class DestinationDetailScreen extends StatelessWidget {
  final DestinationModel destination;

  const DestinationDetailScreen({super.key, required this.destination});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'water': return Icons.water;
      case 'pets': return Icons.pets;
      case 'sailing': return Icons.sailing;
      case 'forest': return Icons.forest;
      case 'kayaking': return Icons.kayaking;
      case 'paragliding': return Icons.paragliding;
      case 'beach_access': return Icons.beach_access;
      case 'hiking': return Icons.hiking;
      case 'nature': return Icons.nature;
      case 'park': return Icons.park;
      default: return Icons.place;
    }
  }

  Color _getColor(String colorString) {
    return Color(int.parse(colorString));
  }

  void _bookTrip(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to book trips.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Book Trip to ${destination.name}'),
        content: Text('Would you like to book a trip to ${destination.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final navigator = Navigator.of(context);

              try {
                await DestinationService().bookTrip(destination.id, userId);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Trip to ${destination.name} booked!'),
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                );
                navigator.pop(); // Go back to explore list
              } catch (e) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Error booking trip: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
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
    final gradientStart = _getColor(destination.gradientStart);
    final gradientEnd = _getColor(destination.gradientEnd);
    final icon = _getIconData(destination.icon);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Gradient
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                destination.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black45)],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [gradientStart, gradientEnd],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: 50,
                      child: Icon(
                        icon,
                        size: 250,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    Center(
                      child: Icon(
                        icon,
                        size: 100,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    destination.description,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // About Section
                  const Text(
                    'About This Destination',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Discover the beauty and wonder of ${destination.name}. This incredible destination offers unforgettable experiences, breathtaking views, and adventures that will create memories to last a lifetime.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Activities
                  const Text(
                    'Popular Activities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActivity(Icons.camera_alt, 'Wildlife Photography'),
                  _buildActivity(Icons.directions_walk, 'Guided Tours'),
                  _buildActivity(Icons.kayaking, 'Water Sports'),
                  _buildActivity(Icons.restaurant, 'Local Cuisine'),
                  _buildActivity(Icons.nightlife, 'Cultural Experiences'),

                  const SizedBox(height: 24),

                  // What's Included
                  const Text(
                    'What\'s Included',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildIncluded('Professional tour guide'),
                  _buildIncluded('Transportation'),
                  _buildIncluded('Entrance fees'),
                  _buildIncluded('Refreshments'),

                  const SizedBox(height: 32),

                  // Book Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _bookTrip(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gradientStart,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Book This Trip',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivity(IconData icon, String activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            activity,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncluded(String item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF4CAF50),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
