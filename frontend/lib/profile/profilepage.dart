import 'package:flutter/material.dart';
import 'package:frontend/auth/login.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0055A4);
    const Color accentColor = Color(0xFF00ACC1);
    const Color backgroundColor = Color(0xFFF5F9FF);
    const Color textColor = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            tooltip: 'Change Language',
            onPressed: () {
              // Toggle language or open language selection modal
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildProfileHeader(user, accentColor, primaryColor, textColor),
            const SizedBox(height: 30),
            _buildSectionTitle('Account', textColor),
            _buildProfileTile(
              icon: Icons.person_outline,
              label: 'Edit Profile',
              color: primaryColor,
              onTap: () {
                // Navigate to Edit Profile
              },
            ),
            _buildProfileTile(
              icon: Icons.notifications_none,
              label: 'Notifications',
              color: primaryColor,
              onTap: () {
                // Navigate to Notifications
              },
            ),
            _buildProfileTile(
              icon: Icons.settings_outlined,
              label: 'Settings',
              color: primaryColor,
              onTap: () {
                // Navigate to Settings
              },
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Legal Aid', textColor),
            _buildProfileTile(
              icon: Icons.gavel_outlined,
              label: 'Find Legal Aid',
              color: accentColor,
              onTap: () {
                // Navigate to Legal Aid Info page
              },
            ),
            const Divider(height: 40),
            _buildProfileTile(
              icon: Icons.logout,
              label: 'Logout',
              color: Colors.redAccent,
              onTap: () async {
                final confirmed = await showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          ElevatedButton(
                            child: const Text("Logout"),
                            onPressed: () => Navigator.pop(context, true),
                          ),
                        ],
                      ),
                );

                if (confirmed == true) {
                  try {
                    await AuthService()
                        .logout(); // Use your Dio-based logout method

                    // Clear local session data if needed (e.g., tokens in shared_preferences)

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logout failed: $e")),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    User user,
    Color accentColor,
    Color primaryColor,
    Color textColor,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: accentColor.withOpacity(0.15),
          backgroundImage:
              user.avatarUrl.startsWith('http')
                  ? NetworkImage(user.avatarUrl)
                  : AssetImage(user.avatarUrl) as ImageProvider,
        ),
        const SizedBox(height: 20),
        Text(
          user.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user.email,
          style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.6)),
        ),
        const SizedBox(height: 12),
        Chip(
          label: Text(user.role),
          backgroundColor: accentColor.withOpacity(0.1),
          labelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        splashColor: color.withOpacity(0.1),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
