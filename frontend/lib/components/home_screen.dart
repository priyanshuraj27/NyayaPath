import 'package:flutter/material.dart';
import 'package:frontend/AIresponse/screens/app.dart';
import 'package:frontend/legalaid/legalaidhome.dart';
import 'package:frontend/profile/demoprofile.dart';
import 'package:frontend/resource/resourcehome.dart';
import 'package:frontend/simplifyLegal/mlchat.dart';
import 'package:frontend/track_cases/trackhome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResourceHomePage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF101336),
        centerTitle: true,
        title: const Text(
          'Nyayapath',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DemoProfileLauncher()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFF101336),
      body:
          _selectedIndex == 0
              ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full-width Search Bar with centered text
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Search for legal information',
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Grid Menu with Individual Images
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                        children: [
                          _buildGridItem(
                            context,
                            imagePath: 'assets/images/chat_assistanticon.jpeg',
                            label: 'Chat with Legal AI Assistant',
                            destination: App(),
                          ),
                          _buildGridItem(
                            context,
                            imagePath:
                                'assets/images/simplyfylegaldocumenticon.jpeg',
                            label: 'Simplify Legal Document',
                            destination: ChatScreen(),
                            padding: const EdgeInsets.all(20.0),
                          ),
                          _buildGridItem(
                            context,
                            imagePath: 'assets/images/trackcaseicon.jpg',
                            label: 'Track Court Case',
                            destination: TrackCourtCasesScreen(),
                            padding: const EdgeInsets.all(
                              12.0,
                            ), // 1 point smaller
                          ),
                          _buildGridItem(
                            context,
                            imagePath: 'assets/images/findLegalAidIcon.jpg',
                            label: 'Find Legal Aid',
                            destination: LegalAidScreen(),
                            padding: const EdgeInsets.all(
                              20.0,
                            ), // 2 points smaller
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Recent Activity
                      const Text(
                        'Recent Activity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildRecentItem(
                        Icons.gavel,
                        'Court hearing scheduled',
                        'Case ID: 12345',
                      ),
                      const SizedBox(height: 10),
                      _buildRecentItem(
                        Icons.description,
                        'Legal document updated',
                        'Document Name: Contract agreement',
                      ),
                    ],
                  ),
                ),
              )
              : const Center(
                child: Text(
                  'Other tab selected',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF101336),
        selectedItemColor: const Color(0xFF00B9F1),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
      ),
    );
  }

  // Grid Item with image and optional padding
  Widget _buildGridItem(
    BuildContext context, {
    required String imagePath,
    required String label,
    required Widget destination,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Padding(
                  padding: padding,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            // Label Section
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF2C3A8C),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Recent Item UI
  Widget _buildRecentItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00B9F1)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Color(0xFFC3C6D1)),
      ),
    );
  }
}
