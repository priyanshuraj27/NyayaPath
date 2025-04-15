import 'package:flutter/material.dart';
import 'package:frontend/resource/bycategory.dart';
import 'package:frontend/resource/bylaw.dart';
import 'package:frontend/resource/bystate.dart';

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
        'screen': const ResourceCategoryPage(),
      },
      {
        'title': 'By State',
        'icon': Icons.map_rounded,
        'description': 'Legal resources state-wise',
        'screen': const ResourceStatePage(),
      },
      {
        'title': 'By Law Type',
        'icon': Icons.balance_rounded,
        'description': 'Explore by domain (Criminal, Civil, Tax, etc.)',
        'screen': const ResourceLawPage(),
      },
    ];

    return Scaffold(
      backgroundColor: nyayapathBg,
      appBar: AppBar(
        title: const Text('Explore Legal Resources'),
        backgroundColor: nyayapathBlue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: resourceModes.length,
        itemBuilder: (context, index) {
          final mode = resourceModes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => mode['screen'] as Widget,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 3,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: nyayapathAccent.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: nyayapathAccent.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          mode['icon'] as IconData,
                          color: nyayapathBlue,
                          size: 28,
                        ),
                      ),
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
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
