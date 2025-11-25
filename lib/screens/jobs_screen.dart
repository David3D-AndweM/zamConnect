import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class Job {
  final String title;
  final String company;
  final String description;
  final String salary;
  final IconData icon;

  const Job({
    required this.title,
    required this.company,
    required this.description,
    required this.salary,
    required this.icon,
  });
}

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int _currentIndex = 1;

  final List<Job> _jobs = const [
    Job(
      title: 'Software Developer',
      company: 'Tech Company',
      description: 'Join our team to build innovative mobile and web applications. Experience with Flutter and React preferred.',
      salary: '\$1500/mo',
      icon: Icons.computer,
    ),
    Job(
      title: 'Marketing Manager',
      company: 'Local Business',
      description: 'Lead marketing campaigns and brand development. Strong communication and creativity required.',
      salary: '\$800/mo',
      icon: Icons.campaign,
    ),
    Job(
      title: 'Teacher',
      company: 'School District',
      description: 'Educate and inspire students in primary education. Teaching certification required.',
      salary: '\$500/mo',
      icon: Icons.school,
    ),
    Job(
      title: 'Nurse',
      company: 'Hospital',
      description: 'Provide patient care in a busy hospital environment. Nursing degree and registration required.',
      salary: '\$1200/mo',
      icon: Icons.local_hospital,
    ),
    Job(
      title: 'Accountant',
      company: 'Finance Firm',
      description: 'Manage financial records and prepare reports. ACCA or ZICA qualification preferred.',
      salary: '\$900/mo',
      icon: Icons.account_balance,
    ),
    Job(
      title: 'Driver',
      company: 'Logistics Company',
      description: 'Transport goods across Zambia. Valid driver\'s license and clean record required.',
      salary: '\$400/mo',
      icon: Icons.local_shipping,
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
      case 1: break;
      case 2: Navigator.pushReplacementNamed(context, '/volunteer'); break;
      case 3: Navigator.pushReplacementNamed(context, '/explore'); break;
      case 4: Navigator.pushReplacementNamed(context, '/profile'); break;
    }
  }

  void _applyForJob(Job job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apply for ${job.title}'),
        content: Text('Would you like to apply for the ${job.title} position at ${job.company}?'),
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
                  content: Text('Application submitted for ${job.title}!'),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
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
          'Find Jobs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _jobs.length,
        itemBuilder: (context, index) {
          final job = _jobs[index];
          return _buildJobCard(job);
        },
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
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
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    job.icon,
                    color: const Color(0xFF4CAF50),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.company,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  job.salary,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              job.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _applyForJob(job),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
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
