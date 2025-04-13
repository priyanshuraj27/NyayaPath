import 'package:flutter/material.dart';
import 'package:frontend/track_cases/trackcase.dart';

class TrackCourtCasesScreen extends StatefulWidget {
  const TrackCourtCasesScreen({super.key});

  @override
  State<TrackCourtCasesScreen> createState() => _TrackCourtCasesScreenState();
}

class _TrackCourtCasesScreenState extends State<TrackCourtCasesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _caseNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _advocateController = TextEditingController();

  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _caseNumberController.dispose();
    _nameController.dispose();
    _advocateController.dispose();
    super.dispose();
  }

  void _performSearch() {
     Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => CaseStatusScreen()),
    );
    setState(() {
      _hasSearched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101336),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101336),
        title: const Text(
          'Track Court Cases',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'By Case Number'), Tab(text: 'By Name')],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildSearchByCaseNumber(), _buildSearchByName()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF101336),
        selectedItemColor: const Color(0xFF00B9F1),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
      ),
    );
  }

  Widget _buildSearchByCaseNumber() {
    return _buildForm(
      children: [
        _inputField(_caseNumberController, 'Enter Case Number'),
        const SizedBox(height: 12),
        _dropdown('Select Court'),
        const SizedBox(height: 12),
        _dropdown('Select Year'),
        const SizedBox(height: 20),
        _searchButton(),
        const SizedBox(height: 30),
          _sectionTitle('Recent Searches'),
          _recentSearchesList(),
          const SizedBox(height: 30),
          _sectionTitle('Need Help?'),
          _helpCard(),
          const SizedBox(height: 30),
          _sectionTitle('Subscribe to Case Updates'),
          _subscribeCard(),
      ],
    );
  }

  Widget _buildSearchByName() {
    return _buildForm(
      children: [
        _inputField(_nameController, 'Enter Party Name'),
        const SizedBox(height: 12),
        _inputField(_advocateController, 'Advocate Name (optional)'),
        const SizedBox(height: 12),
        _dropdown('Select Court'),
        const SizedBox(height: 20),
        _searchButton(),
          const SizedBox(height: 30),
          _sectionTitle('Need Help?'),
          _helpCard(),
          const SizedBox(height: 30),
          _sectionTitle('Subscribe to Case Updates'),
          _subscribeCard(),
        ],
    );
  }

  // Reuse the rest of your existing widgets below:
  Widget _buildForm({required List<Widget> children}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
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

  Widget _dropdown(String label) {
    List<String> items;

    if (label == 'Select Court') {
      items = [
        'Supreme Court of India',
        'Delhi High Court',
        'Bombay High Court',
        'Calcutta High Court',
        'Madras High Court',
        'Karnataka High Court',
        'Kerala High Court',
        'Allahabad High Court',
        'Patna High Court',
        'Punjab and Haryana High Court',
        'Hyderabad High Court',
      ];
    } else if (label == 'Select Year') {
      items = List.generate(26, (index) => (2000 + index).toString());
    } else {
      items = ['Option 1', 'Option 2'];
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color(0xFF2C3A8C),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
        ),
        style: const TextStyle(color: Colors.white),
        items:
            items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: (_) {},
      ),
    );
  }

  Widget _searchButton() {
  return ElevatedButton.icon(
    onPressed: _performSearch,
    icon: const Icon(Icons.search),
    label: const Text('Search Case'),
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

  Widget _recentSearchesList() {
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.history, color: Colors.white),
          title: Text('DL-1234-2023', style: TextStyle(color: Colors.white)),
          subtitle: Text(
            'Delhi High Court',
            style: TextStyle(color: Colors.white60),
          ),
        ),
        ListTile(
          leading: Icon(Icons.history, color: Colors.white),
          title: Text('MH-5678-2022', style: TextStyle(color: Colors.white)),
          subtitle: Text(
            'Mumbai Sessions Court',
            style: TextStyle(color: Colors.white60),
          ),
        ),
      ],
    );
  }

  Widget _helpCard() {
    return Card(
      color: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.help_outline, color: Color(0xFF00B9F1)),
        title: const Text(
          'Need Legal Help?',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          'Connect with verified legal aid services.',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Get Help'),
        ),
      ),
    );
  }

  Widget _languagePicker() {
    return DropdownButtonFormField<String>(
      dropdownColor: const Color(0xFF2C3A8C),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white10,
        labelText: 'Choose Language',
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
      items:
          [
            'English',
            'Hindi',
            'Tamil',
            'Marathi',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (_) {},
    );
  }

  Widget _subscribeCard() {
    return Card(
      color: Colors.white12,
      child: ListTile(
        leading: const Icon(
          Icons.notifications_active,
          color: Color(0xFF00B9F1),
        ),
        title: const Text(
          'Subscribe to Updates',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          'Receive hearing dates, orders, and status.',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Subscribe'),
        ),
      ),
    );
  }

  Widget _caseProgressStepper() {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      currentStep: 2,
      controlsBuilder: (context, _) => const SizedBox(),
      steps: const [
        Step(title: Text('Filing'), content: SizedBox.shrink(), isActive: true),
        Step(
          title: Text('Hearing'),
          content: SizedBox.shrink(),
          isActive: true,
        ),
        Step(
          title: Text('Arguments'),
          content: SizedBox.shrink(),
          isActive: true,
        ),
        Step(
          title: Text('Judgment Reserved'),
          content: SizedBox.shrink(),
          isActive: false,
        ),
        Step(
          title: Text('Disposed'),
          content: SizedBox.shrink(),
          isActive: false,
        ),
      ],
    );
  }
}
