import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: AppBar(
        title: const Text('Resources by Law Type'),
        backgroundColor: const Color(0xFF2C3A8C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF101336),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: laws.length,
        separatorBuilder: (_, __) => const Divider(color: Colors.white24),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.gavel, color: Colors.cyanAccent),
            title: Text(
              laws[index],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LawDetailPage(lawType: laws[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LawDetailPage extends StatelessWidget {
  final String lawType;

  const LawDetailPage({super.key, required this.lawType});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> lawResources = {
      'Corporate Law': {
        'links': [
          'https://mca.gov.in',
          'https://www.sebi.gov.in',
          'https://www.nclt.gov.in'
        ],
        'centers': [
          {'name': 'Corporate Legal Help Center', 'location': 'Delhi', 'phone': '1800-111-000'}
        ],
        'templates': [
          'Company Registration Template',
          'NDA Template',
          'Shareholder Agreement Template'
        ]
      },
      'Civil Law': {
        'links': [
          'https://indiancourts.nic.in',
          'https://legalaidservices.in'
        ],
        'centers': [
          {'name': 'Civil Law Help Center', 'location': 'Kolkata', 'phone': '1800-555-444'}
        ],
        'templates': ['Civil Suit Template', 'Petition Draft Template']
      },
      'Criminal Law': {
        'links': [
          'https://ncrb.gov.in',
          'https://indianpolice.gov.in'
        ],
        'centers': [
          {'name': 'Criminal Legal Aid Center', 'location': 'Mumbai', 'phone': '1800-333-222'}
        ],
        'templates': ['Criminal Complaint Template', 'Bail Petition Template']
      },
      'Family Law': {
        'links': [
          'https://ncpcr.gov.in',
          'https://ncw.nic.in'
        ],
        'centers': [
          {'name': 'Family Welfare Legal Aid', 'location': 'Mumbai', 'phone': '1800-222-000'}
        ],
        'templates': ['Divorce Petition', 'Adoption Form']
      },
      'Tax Law': {
        'links': [
          'https://www.incometaxindia.gov.in',
          'https://www.gst.gov.in'
        ],
        'centers': [
          {'name': 'Tax Help Center', 'location': 'Chennai', 'phone': '1800-200-333'}
        ],
        'templates': ['Tax Return Template', 'GST Registration Form']
      },
      // Add more law resource entries here...
    };

    final data = lawResources[lawType] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('$lawType Resources'),
        backgroundColor: const Color(0xFF2C3A8C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF101336),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionTitle(title: 'Legal Aid Centers'),
          ...(data['centers'] as List?)?.map<Widget>((center) {
            final c = center as Map;
            return ResourceCard(
              title: c['name'] ?? 'Center',
              subtitle: '${c['location'] ?? 'N/A'}\n📞 ${c['phone'] ?? 'N/A'}',
            );
          }).toList() ?? [],

          const SizedBox(height: 16),
          SectionTitle(title: 'Useful Links'),
          ...(data['links'] as List?)?.map<Widget>((url) {
            return LinkCard(url: url.toString());
          }).toList() ?? [],

          const SizedBox(height: 16),
          SectionTitle(title: 'Downloadable Templates'),
          ...(data['templates'] as List?)?.map<Widget>((template) {
            return ResourceCard(
              title: template.toString(),
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
