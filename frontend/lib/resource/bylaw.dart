import 'package:flutter/material.dart';

class ResourceLawPage extends StatelessWidget {
  const ResourceLawPage({super.key});

  @override
  Widget build(BuildContext context) {
    final laws = [
      'Corporate Law',
      'Civil Law',
      'Criminal Law',
      'Constitutional Law',
      'Administrative Law',
      'Tax Law',
      'Family Law',
      'Labor Law',
      'IPR Law',
      'Environmental Law',
      'Banking Law',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Resources by Law Type')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: laws.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.gavel),
            title: Text(laws[index]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${laws[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}
