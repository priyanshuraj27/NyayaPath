import 'package:flutter/material.dart';

class ResourceCategoryPage extends StatelessWidget {
  const ResourceCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Legal Templates',
      'Knowledge Base',
      'Educational Media',
      'Multilingual Glossary',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Resources by Category')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.folder),
              title: Text(categories[index]),
              subtitle: const Text('Sample demo content'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on ${categories[index]}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
