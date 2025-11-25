import 'package:flutter/material.dart';
import 'forms/job_application_form.dart';

class Job {
  final String id;
  final String title;
  final String company;
  final String description;
  final String salary;
  final IconData icon;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.salary,
    required this.icon,
  });
}

class JobsContent extends StatefulWidget {
  const JobsContent({super.key});

  @override
  State<JobsContent> createState() => _JobsContentState();
}

class _JobsContentState extends State<JobsContent> {
  final List<Job> _jobs = const [
    Job(
      id: '1',
      title: 'Software Developer',
      company: 'Tech Company',
      description: 'Join our team to build innovative mobile and web applications. Experience with Flutter and React preferred.',
      salary: '\$1500/mo',
      icon: Icons.computer_rounded,
    ),
    Job(
      id: '2',
      title: 'Marketing Manager',
      company: 'Local Business',
      description: 'Lead marketing campaigns and brand development. Strong communication and creativity required.',
      salary: '\$800/mo',
      icon: Icons.campaign_rounded,
    ),
    Job(
      id: '3',
      title: 'Teacher',
      company: 'School District',
      description: 'Educate and inspire students in primary education. Teaching certification required.',
      salary: '\$500/mo',
      icon: Icons.school_rounded,
    ),
    Job(
      id: '4',
      title: 'Nurse',
      company: 'Hospital',
      description: 'Provide patient care in a busy hospital environment. Nursing degree and registration required.',
      salary: '\$1200/mo',
      icon: Icons.local_hospital_rounded,
    ),
    Job(
      id: '5',
      title: 'Accountant',
      company: 'Finance Firm',
      description: 'Manage financial records and prepare reports. ACCA or ZICA qualification preferred.',
      salary: '\$900/mo',
      icon: Icons.account_balance_rounded,
    ),
    Job(
      id: '6',
      title: 'Driver',
      company: 'Logistics Company',
      description: 'Transport goods across Zambia. Valid driver\'s license and clean record required.',
      salary: '\$400/mo',
      icon: Icons.local_shipping_rounded,
    ),
  ];

  void _applyForJob(Job job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobApplicationForm(
          jobTitle: job.title,
          company: job.company,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Jobs', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _jobs.length,
        itemBuilder: (context, index) {
          return _JobCard(
            job: _jobs[index],
            onApply: () => _applyForJob(_jobs[index]),
          );
        },
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onApply;

  const _JobCard({required this.job, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                    color: const Color(0xFF4CAF50).withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(job.icon, color: const Color(0xFF4CAF50), size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.company,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job.salary,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              job.description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: onApply,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
