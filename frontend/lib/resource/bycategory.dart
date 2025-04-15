import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryDetailPage(category: categories[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryDetailPage extends StatelessWidget {
  final String category;

  const CategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> categoryResources = {
      'Legal Templates': {
        'links': ['https://www.lawhelp.org', 'https://www.legaltemplates.com'],
        'files': ['NDA Template', 'Divorce Petition'],
      },
      'Knowledge Base': {
        'links': ['https://www.lawjournal.com', 'https://www.courts.gov'],
        'files': ['Case Law Database', 'Legal Newsletters'],
      },
      'Educational Media': {
        'links': ['https://www.youtube.com', 'https://www.udemy.com'],
        'files': ['Legal Webinar', 'Law Podcasts'],
      },
      'Multilingual Glossary': {
        'links': ['https://www.multilinguallegal.com', 'https://www.lawglossary.com'],
        'files': ['Legal Terms in French', 'Legal Terms in Spanish'],
      },
    };

    final data = categoryResources[category] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Resources'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionTitle(title: 'Useful Links'),
          ...(data['links'] as List?)?.map<Widget>((url) {
            return LinkCard(url: url.toString());
          }).toList() ?? [],

          const SizedBox(height: 16),
          SectionTitle(title: 'Downloadable Files'),
          ...(data['files'] as List?)?.map<Widget>((file) {
            return ResourceCard(
              title: file.toString(),
              subtitle: 'Tap to preview/download',
            );
          }).toList() ?? [],
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.cyanAccent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const ResourceCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2C3A8C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}

class LinkCard extends StatelessWidget {
  final String url;

  const LinkCard({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2C3A8C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          url,
          style: const TextStyle(color: Colors.cyanAccent, decoration: TextDecoration.underline),
        ),
        trailing: const Icon(Icons.open_in_new, color: Colors.white),
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open $url')));
          }
        },
      ),
    );
  }
}
