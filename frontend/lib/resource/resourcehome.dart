import 'package:flutter/material.dart';
import 'package:frontend/resource/bycategory.dart';
import 'package:frontend/resource/bylaw.dart';
import 'package:frontend/resource/bystate.dart'; // Import for ResourceLawPage

class ResourceHomePage extends StatelessWidget {
  const ResourceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nyayapathBlue = const Color(0xFF0A1D56);
    final nyayapathAccent = const Color(0xFFE09F3E);
    final nyayapathBg = const Color(0xFFF5F5F5);

    final resourceModes = [
      {
        'title': 'By Category',
        'icon': Icons.grid_view_rounded,
        'description': 'Templates, Knowledge, Videos & Glossary',
        'screen': const ResourceCategoryPage(), // Push this screen
      },
      {
        'title': 'By State',
        'icon': Icons.map_rounded,
        'description': 'Legal resources state-wise',
        'screen': const ResourceStatePage(), // Push this screen
      },
      {
        'title': 'By Law Type',
        'icon': Icons.balance_rounded,
        'description': 'Explore by domain (Criminal, Civil, Tax, etc.)',
        'screen': const ResourceLawPage(), // Push this screen
      },
    ];

    return Scaffold(
      backgroundColor: nyayapathBg,
      appBar: AppBar(
        title: const Text('Explore Legal Resources'),
        backgroundColor: nyayapathBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: resourceModes.length,
        itemBuilder: (context, index) {
          final mode = resourceModes[index];
          return GestureDetector(
            onTap: () {
              // Use Navigator.push() to navigate to the corresponding screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mode['screen'] as Widget),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(color: nyayapathAccent, width: 6),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(mode['icon'] as IconData, color: nyayapathBlue, size: 40),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mode['title'] as String,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: nyayapathBlue,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            mode['description'] as String,
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    )
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
