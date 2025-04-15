import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceStatePage extends StatelessWidget {
  const ResourceStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final states = [
      {'name': 'Maharashtra', 'image': 'assets/states/maharashtra.jpeg'},
      {'name': 'Kerala', 'image': 'assets/states/kerala.png'},
      {'name': 'Bihar', 'image': 'assets/states/bihar.jpeg'},
      {'name': 'Uttar Pradesh', 'image': 'assets/states/uttar_pradesh.jpeg'},
      {'name': 'Rajasthan', 'image': 'assets/states/rajasthan.png'},
      {'name': 'Gujarat', 'image': 'assets/states/gujrat.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources by State'),
        backgroundColor: const Color(0xFF2C3A8C),
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: states.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 2.5,
        ),
        itemBuilder: (context, index) {
          final state = states[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => StateResourceDetailPage(stateName: state['name']!),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        state['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      state['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StateResourceDetailPage extends StatelessWidget {
  final String stateName;

  const StateResourceDetailPage({super.key, required this.stateName});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> demoResources = {
      'Maharashtra': [
        {
          'title': 'Free Legal Aid - Mumbai',
          'phone': '1800-111-222',
          'website': 'https://maha-legal.gov.in',
          'location': 'Mumbai District Court',
        },
        {
          'title': 'Maharashtra Legal Clinics',
          'phone': '1800-222-333',
          'website': 'https://maha-legalclinic.in',
          'location': 'Nagpur Court',
        },
      ],
      'Kerala': [
        {
          'title': 'Kerala Legal Support Cell',
          'phone': '1800-222-333',
          'website': 'https://keralalegal.org',
          'location': 'Kochi Law Complex',
        },
        {
          'title': 'Kerala Women Helpline',
          'phone': '1091',
          'website': 'https://keralawomenhelpline.in',
          'location': 'Trivandrum',
        },
      ],
    };

    final Map<String, List<String>> downloadableTemplates = {
      'Maharashtra': [
        'Power of Attorney Template',
        'Rent Agreement Template',
        'FIR Complaint Template',
      ],
      'Kerala': [
        'Divorce Petition Template',
        'RTI Application Template',
        'Affidavit Template',
      ],
    };

    final resources = demoResources[stateName] ?? [];
    final templates = downloadableTemplates[stateName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$stateName Resources'),
        backgroundColor: const Color(0xFF2C3A8C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF101336),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...resources
              .map((resource) => ResourceCard(resource: resource))
              .toList(),
          const SizedBox(height: 16),
          if (templates.isNotEmpty)
            const SectionTitle(title: 'Downloadable Templates'),
          ...templates
              .map((template) => DownloadableCard(template: template))
              .toList(),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Legal Awareness Resources'),
          _createResourceCard(
            'Women Rights in India (PDF)',
            'assets/legalawareness/women_rights.pdf',
            null,
          ),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Nearby Legal Aid Camps'),
          _createEventCard(
            'Legal Literacy Camp – Pune',
            '20th April',
            'Pune District Court',
          ),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Track Your Case Status / FIR'),
          _createResourceCard(
            'Track FIR',
            'https://www.police.gov.in/fir-tracking',
            null,
          ),
          _createResourceCard(
            'Track Court Case',
            'https://www.ecourt.gov.in',
            null,
          ),
        ],
      ),
    );
  }

  Widget _createResourceCard(String title, String link, String? location) {
    return GestureDetector(
      onTap: () => _launchUrl(link),
      child: Card(
        color: const Color(0xFF2C3A8C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (location != null) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(location, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _createEventCard(String title, String date, String location) {
    return Card(
      color: const Color(0xFF2C3A8C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.date_range, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(date, style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(location, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final Map<String, String> resource;

  const ResourceCard({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2C3A8C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resource['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  resource['phone']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.language, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _launchUrl(resource['website']!),
                  child: Text(
                    resource['website']!,
                    style: const TextStyle(
                      color: Colors.cyanAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  resource['location']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}

class DownloadableCard extends StatelessWidget {
  final String template;

  const DownloadableCard({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2C3A8C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          template,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
