import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_model.dart';
import '../models/volunteer_model.dart';
import '../models/destination_model.dart';

class SeedingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> seedJobs() async {
    final jobsCollection = _firestore.collection('jobs');

    // Check if jobs already exist to avoid duplicates
    final snapshot = await jobsCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      print('Jobs already seeded.');
      return;
    }

    final List<JobModel> dummyJobs = [
      // Tourism & Hospitality Jobs
      JobModel(
        id: '',
        title: 'Eco-Tour Guide',
        company: 'Zambia Safari Co.',
        description: 'Lead eco-friendly tours in South Luangwa National Park. Knowledge of local flora and fauna required.',
        salary: 'ZMW 5,000 - 8,000 / month',
        icon: 'tour',
        createdAt: DateTime.now(),
      ),
      JobModel(
        id: '',
        title: 'Lodge Manager',
        company: 'Riverview Lodge',
        description: 'Manage daily operations of a luxury eco-lodge. Experience in hospitality management required.',
        salary: 'ZMW 12,000 / month',
        icon: 'hotel',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      JobModel(
        id: '',
        title: 'Safari Camp Chef',
        company: 'Wilderness Safaris',
        description: 'Prepare gourmet meals for safari guests. Experience in international cuisine preferred.',
        salary: 'ZMW 8,000 / month',
        icon: 'hotel',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      JobModel(
        id: '',
        title: 'Adventure Activities Coordinator',
        company: 'Victoria Falls Adventures',
        description: 'Coordinate bungee jumping, white water rafting, and zip-lining activities.',
        salary: 'ZMW 7,500 / month',
        icon: 'tour',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      JobModel(
        id: '',
        title: 'Hotel Receptionist',
        company: 'Lusaka Grand Hotel',
        description: 'Welcome guests and manage reservations. Excellent communication skills required.',
        salary: 'ZMW 4,500 / month',
        icon: 'hotel',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
      ),

      // Conservation & Wildlife Jobs
      JobModel(
        id: '',
        title: 'Wildlife Conservation Volunteer',
        company: 'Lion Rescue Foundation',
        description: 'Assist in tracking and monitoring lion populations. Accommodation and meals provided.',
        salary: 'Volunteer (Stipend provided)',
        icon: 'nature',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      JobModel(
        id: '',
        title: 'Wildlife Veterinarian',
        company: 'Kafue Conservation Trust',
        description: 'Provide medical care for wild animals. Veterinary degree required.',
        salary: 'ZMW 18,000 / month',
        icon: 'nature',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
      ),
      JobModel(
        id: '',
        title: 'Anti-Poaching Ranger',
        company: 'National Parks Authority',
        description: 'Patrol protected areas to prevent poaching. Physical fitness essential.',
        salary: 'ZMW 6,000 / month',
        icon: 'nature',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      JobModel(
        id: '',
        title: 'Marine Biologist',
        company: 'Lake Tanganyika Research',
        description: 'Study aquatic ecosystems and fish populations in Lake Tanganyika.',
        salary: 'ZMW 15,000 / month',
        icon: 'nature',
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
      JobModel(
        id: '',
        title: 'Elephant Conservation Specialist',
        company: 'Lower Zambezi Elephant Fund',
        description: 'Monitor elephant herds and implement conservation strategies.',
        salary: 'ZMW 14,000 / month',
        icon: 'nature',
        createdAt: DateTime.now().subtract(const Duration(days: 9)),
      ),

      // Agriculture & Sustainability Jobs
      JobModel(
        id: '',
        title: 'Sustainable Farming Expert',
        company: 'AgriTech Zambia',
        description: 'Teach local farmers sustainable farming techniques to improve crop yields.',
        salary: 'ZMW 10,000 / month',
        icon: 'agriculture',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      JobModel(
        id: '',
        title: 'Agricultural Extension Officer',
        company: 'Ministry of Agriculture',
        description: 'Provide technical support to rural farmers on crop management.',
        salary: 'ZMW 7,000 / month',
        icon: 'agriculture',
        createdAt: DateTime.now().subtract(const Duration(days: 11)),
      ),
      JobModel(
        id: '',
        title: 'Organic Farm Manager',
        company: 'Green Valley Farms',
        description: 'Oversee organic vegetable production and distribution to local markets.',
        salary: 'ZMW 9,500 / month',
        icon: 'agriculture',
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
      ),
      JobModel(
        id: '',
        title: 'Beekeeping Specialist',
        company: 'Zambian Honey Collective',
        description: 'Train communities in sustainable beekeeping practices.',
        salary: 'ZMW 6,500 / month',
        icon: 'agriculture',
        createdAt: DateTime.now().subtract(const Duration(days: 13)),
      ),
      JobModel(
        id: '',
        title: 'Permaculture Designer',
        company: 'Eco-Living Zambia',
        description: 'Design sustainable permaculture systems for schools and communities.',
        salary: 'ZMW 11,000 / month',
        icon: 'agriculture',
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
      ),

      // Community Development & NGO Jobs
      JobModel(
        id: '',
        title: 'Community Outreach Coordinator',
        company: 'Green Zambia NGO',
        description: 'Coordinate community projects focused on sustainable agriculture and education.',
        salary: 'ZMW 6,500 / month',
        icon: 'people',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      JobModel(
        id: '',
        title: 'Education Program Officer',
        company: 'Children First Zambia',
        description: 'Develop and implement educational programs for rural schools.',
        salary: 'ZMW 8,500 / month',
        icon: 'people',
        createdAt: DateTime.now().subtract(const Duration(days: 16)),
      ),
      JobModel(
        id: '',
        title: 'Water & Sanitation Specialist',
        company: 'Clean Water Initiative',
        description: 'Install and maintain water wells in remote villages.',
        salary: 'ZMW 9,000 / month',
        icon: 'people',
        createdAt: DateTime.now().subtract(const Duration(days: 17)),
      ),
      JobModel(
        id: '',
        title: 'Health Educator',
        company: 'Zambia Health Foundation',
        description: 'Conduct health awareness campaigns on malaria prevention and nutrition.',
        salary: 'ZMW 7,500 / month',
        icon: 'people',
        createdAt: DateTime.now().subtract(const Duration(days: 18)),
      ),
      JobModel(
        id: '',
        title: 'Microfinance Coordinator',
        company: 'Women Empowerment Zambia',
        description: 'Manage microfinance programs for women entrepreneurs.',
        salary: 'ZMW 8,000 / month',
        icon: 'people',
        createdAt: DateTime.now().subtract(const Duration(days: 19)),
      ),

      // General/Other Jobs
      JobModel(
        id: '',
        title: 'Environmental Project Manager',
        company: 'WWF Zambia',
        description: 'Lead environmental conservation projects across multiple regions.',
        salary: 'ZMW 16,000 / month',
        icon: 'work',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      JobModel(
        id: '',
        title: 'Renewable Energy Technician',
        company: 'Solar Solutions Zambia',
        description: 'Install and maintain solar panel systems in rural communities.',
        salary: 'ZMW 10,500 / month',
        icon: 'work',
        createdAt: DateTime.now().subtract(const Duration(days: 21)),
      ),
      JobModel(
        id: '',
        title: 'Eco-Lodge Maintenance Staff',
        company: 'Luangwa Safari Lodge',
        description: 'Maintain lodge facilities and grounds. Handyman skills required.',
        salary: 'ZMW 4,000 / month',
        icon: 'work',
        createdAt: DateTime.now().subtract(const Duration(days: 22)),
      ),
      JobModel(
        id: '',
        title: 'Tourism Marketing Manager',
        company: 'Zambia Tourism Board',
        description: 'Promote Zambia as a premier eco-tourism destination.',
        salary: 'ZMW 13,000 / month',
        icon: 'work',
        createdAt: DateTime.now().subtract(const Duration(days: 23)),
      ),
      JobModel(
        id: '',
        title: 'Cultural Heritage Guide',
        company: 'Livingstone Museum',
        description: 'Guide visitors through cultural and historical exhibits.',
        salary: 'ZMW 5,500 / month',
        icon: 'work',
        createdAt: DateTime.now().subtract(const Duration(days: 24)),
      ),
    ];

    for (var job in dummyJobs) {
      try {
        await jobsCollection.add(job.toMap());
        print('Seeded job: ${job.title}');
      } catch (e) {
        print('Error seeding job ${job.title}: $e');
      }
    }
  }

  Future<void> seedVolunteers() async {
    final volunteersCollection = _firestore.collection('volunteers');

    final snapshot = await volunteersCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      print('Volunteers already seeded.');
      return;
    }

    final List<Map<String, dynamic>> volunteers = [
      {
        'name': 'Africa Access Water',
        'description': 'Help provide clean water access to rural communities across Zambia. Join our water conservation and well-building projects.',
        'icon': 'water_drop',
        'iconColor': '0xFF2196F3',
      },
      {
        'name': 'WWF Zambia',
        'description': 'Protect wildlife and natural habitats. Participate in anti-poaching patrols, wildlife monitoring, and community education programs.',
        'icon': 'pets',
        'iconColor': '0xFF4CAF50',
      },
      {
        'name': 'Lusaka City Council',
        'description': 'Urban development and community improvement projects. Help with tree planting, waste management, and public space beautification.',
        'icon': 'location_city',
        'iconColor': '0xFF9C27B0',
      },
      {
        'name': 'ZICONA Zambia',
        'description': 'Environmental conservation and sustainable agriculture. Work on reforestation projects and teach sustainable farming practices.',
        'icon': 'eco',
        'iconColor': '0xFF2E7D32',
      },
      {
        'name': 'Red Cross Zambia',
        'description': 'Humanitarian aid and disaster relief. Assist with health campaigns, first aid training, and emergency response activities.',
        'icon': 'health_and_safety',
        'iconColor': '0xFFF44336',
      },
      {
        'name': 'Habitat for Humanity',
        'description': 'Build homes for families in need. Join construction teams and help create safe, affordable housing in Zambian communities.',
        'icon': 'home',
        'iconColor': '0xFFFF9800',
      },
      {
        'name': 'Zambian Wildlife Authority',
        'description': 'Support wildlife protection initiatives. Assist rangers with patrols and community engagement programs.',
        'icon': 'nature_people',
        'iconColor': '0xFF558B2F',
      },
      {
        'name': 'Girls Education Fund',
        'description': 'Empower young girls through education. Teach literacy, math, and life skills in rural schools.',
        'icon': 'school',
        'iconColor': '0xFFE91E63',
      },
    ];

    for (var volunteer in volunteers) {
      try {
        await volunteersCollection.add(volunteer);
        print('Seeded volunteer: ${volunteer['name']}');
      } catch (e) {
        print('Error seeding volunteer ${volunteer['name']}: $e');
      }
    }
  }

  Future<void> seedDestinations() async {
    final destinationsCollection = _firestore.collection('destinations');

    final snapshot = await destinationsCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      print('Destinations already seeded.');
      return;
    }

    final List<Map<String, dynamic>> destinations = [
      {
        'name': 'Victoria Falls',
        'description': 'The Smoke that Thunders',
        'icon': 'water',
        'gradientStart': '0xFF1565C0',
        'gradientEnd': '0xFF42A5F5',
      },
      {
        'name': 'South Luangwa',
        'description': 'Premier Safari Destination',
        'icon': 'pets',
        'gradientStart': '0xFF2E7D32',
        'gradientEnd': '0xFF66BB6A',
      },
      {
        'name': 'Lake Kariba',
        'description': 'Africa\'s Largest Man-Made Lake',
        'icon': 'sailing',
        'gradientStart': '0xFF0097A7',
        'gradientEnd': '0xFF4DD0E1',
      },
      {
        'name': 'Kafue National Park',
        'description': 'Wild & Untamed Wilderness',
        'icon': 'forest',
        'gradientStart': '0xFF558B2F',
        'gradientEnd': '0xFF8BC34A',
      },
      {
        'name': 'Lower Zambezi',
        'description': 'River Safari Adventures',
        'icon': 'kayaking',
        'gradientStart': '0xFF00695C',
        'gradientEnd': '0xFF26A69A',
      },
      {
        'name': 'Livingstone',
        'description': 'Adventure Capital of Africa',
        'icon': 'paragliding',
        'gradientStart': '0xFFE65100',
        'gradientEnd': '0xFFFF9800',
      },
      {
        'name': 'Lake Tanganyika',
        'description': 'Crystal Clear Waters',
        'icon': 'beach_access',
        'gradientStart': '0xFF01579B',
        'gradientEnd': '0xFF0288D1',
      },
      {
        'name': 'North Luangwa',
        'description': 'Remote Walking Safaris',
        'icon': 'hiking',
        'gradientStart': '0xFF33691E',
        'gradientEnd': '0xFF689F38',
      },
      {
        'name': 'Kasanka National Park',
        'description': 'Bat Migration Spectacle',
        'icon': 'nature',
        'gradientStart': '0xFF4A148C',
        'gradientEnd': '0xFF7B1FA2',
      },
      {
        'name': 'Bangweulu Wetlands',
        'description': 'Shoebill Sanctuary',
        'icon': 'park',
        'gradientStart': '0xFF006064',
        'gradientEnd': '0xFF00838F',
      },
    ];

    for (var destination in destinations) {
      try {
        await destinationsCollection.add(destination);
        print('Seeded destination: ${destination['name']}');
      } catch (e) {
        print('Error seeding destination ${destination['name']}: $e');
      }
    }
  }

  Future<void> seedAll() async {
    await seedJobs();
    await seedVolunteers();
    await seedDestinations();
  }
}
