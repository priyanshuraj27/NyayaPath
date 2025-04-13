import 'package:flutter/material.dart';

class LegalAidScreen extends StatefulWidget {
  const LegalAidScreen({super.key});

  @override
  State<LegalAidScreen> createState() => _LegalAidScreenState();
}

class _LegalAidScreenState extends State<LegalAidScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _locationController = TextEditingController();
  final _issueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _locationController.dispose();
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101336),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101336),
        title: const Text(
          'Legal Aid',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontSize: 15, // Increased font size
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Get Help'),
            Tab(text: 'Resources'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildGetHelpForm(), _buildResources()],
      ),
    );
  }

  Widget _buildGetHelpForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputField(_locationController, 'Enter Your Location'),
          const SizedBox(height: 12),
          _inputField(_issueController, 'Describe Your Legal Issue'),
          const SizedBox(height: 20),
          _searchButton(),

          const SizedBox(height: 30),
          _sectionTitle('Find Pro Bono Lawyers'),
          _proBonoLawyerCard(),

          const SizedBox(height: 30),
          _sectionTitle('Helpline Numbers'),
          _helplineCard(),

          const SizedBox(height: 30),
          _sectionTitle('Apply for Legal Aid'),
          _applyAidCard(),
        ],
      ),
    );
  }

  Widget _buildResources() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Organizations Offering Legal Support'),
          _organizationCard('Human Rights Law Network'),
          _organizationCard('Legal Services India'),

          const SizedBox(height: 30),
          _sectionTitle('Know Your Rights'),
          _legalInfoCard(),
        ],
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _searchButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.search),
      label: const Text('Search'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00B9F1),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _proBonoLawyerCard() {
    return Card(
      color: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.person_search, color: Color(0xFF00B9F1)),
        title: const Text(
          'Find a Pro Bono Lawyer',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          'Connect with lawyers offering free services.',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Find'),
        ),
      ),
    );
  }

  Widget _helplineCard() {
    return Card(
      color: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.call, color: Color(0xFF00B9F1)),
        title: const Text(
          'Legal Aid Helpline',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          '1800-123-4567 (24x7 support)',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Call'),
        ),
      ),
    );
  }

  Widget _applyAidCard() {
    return Card(
      color: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.edit_document, color: Color(0xFF00B9F1)),
        title: const Text(
          'Apply for Legal Aid',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          'Submit your application to get support.',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Apply'),
        ),
      ),
    );
  }

  Widget _organizationCard(String name) {
    return Card(
      color: Colors.white12,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.groups, color: Color(0xFF00B9F1)),
        title: Text(name, style: const TextStyle(color: Colors.white)),
        subtitle: const Text(
          'Tap to view details and contact.',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {},
      ),
    );
  }

  Widget _legalInfoCard() {
    return Card(
      color: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Everyone has the right to free legal aid if they cannot afford a lawyer. Legal services authorities across India provide free assistance to eligible citizens under the Legal Services Authorities Act.',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
