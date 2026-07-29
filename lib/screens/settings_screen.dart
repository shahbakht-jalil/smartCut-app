import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartcut_proj/screens/about_smartcut_screen.dart';
import 'package:smartcut_proj/screens/change_password_screen.dart';
import 'package:smartcut_proj/screens/edit_profile_screen.dart';
import 'package:smartcut_proj/screens/help_faq_screen.dart';
import 'package:smartcut_proj/screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ACCOUNT SECTION
          _buildSectionTitle("Account"),
          _buildSettingsTile(
            icon: Icons.person_outline,
            title: "Edit Profile",
            onTap: () {
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()
                )
              );
            },
          ),

          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {
              Navigator.push(
              context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // SUPPORT SECTION
          _buildSectionTitle("Support"),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: "Help & FAQ",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpFaqScreen(),
                ),
              );
            },
          ),


          _buildSettingsTile(
            icon: Icons.info_outline,
            title: "About smartCut",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutSmartCutScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          // LOGOUT BUTTON
          ElevatedButton.icon(
            onPressed: () {
              _handleLogout(context);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: Text(
              "Logout",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SECTION TITLE
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  // SETTINGS TILE
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: GoogleFonts.poppins()),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // LOGOUT FUNCTION
  void _handleLogout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
            (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logged out successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
  }
}