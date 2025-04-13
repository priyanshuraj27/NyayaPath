import 'package:flutter/material.dart';
import 'package:frontend/legalaid/chatscreen.dart';

class LawyerListScreen extends StatefulWidget {
  final String location;
  final String issue;

  const LawyerListScreen({
    super.key,
    required this.location,
    required this.issue,
  });

  @override
  State<LawyerListScreen> createState() => _LawyerListScreenState();
}

class _LawyerListScreenState extends State<LawyerListScreen> {
  final List<Map<String, dynamic>> lawyers = [
    {
      'name': 'Adv. Priya Sharma',
      'specialty': 'Family Law',
      'organization': 'Legal Aid India',
      'experience': 5,
      'expanded': false,
    },
    {
      'name': 'Adv. Rahul Verma',
      'specialty': 'Criminal Law',
      'organization': 'Justice Connect',
      'experience': 8,
      'expanded': false,
    },
    {
      'name': 'Adv. Sneha Joshi',
      'specialty': 'Labor Law',
      'organization': 'HRLN',
      'experience': 4,
      'expanded': false,
    },
  ];

  void toggleExpansion(int index) {
    setState(() {
      lawyers[index]['expanded'] = !lawyers[index]['expanded'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101336),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101336),
        title: const Text(
          'Connect With Lawyers',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lawyers.length,
        itemBuilder: (context, index) {
          final lawyer = lawyers[index];
          return Card(
            color: Colors.white12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () => toggleExpansion(index),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/images/lawyer_placeholder.jpg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lawyer['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lawyer['organization'],
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Experience: ${lawyer['experience']} years',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Specialty: ${lawyer['specialty']}',
                                style: const TextStyle(color: Colors.white60),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (lawyer['expanded']) ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LawyerClientChatScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Chat',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF00B9F1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Implement legal counsel action
                            },
                            icon: const Icon(Icons.gavel),
                            label: const Text('Seek Legal Counsel'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00B9F1),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
