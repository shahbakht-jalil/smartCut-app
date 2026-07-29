import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcut_proj/screens/edit_profile_screen.dart';
import 'package:smartcut_proj/screens/login_screen.dart';
import 'package:smartcut_proj/screens/settings_screen.dart';
import 'package:smartcut_proj/screens/signup_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "No email";

    return Scaffold(
      backgroundColor: const Color(0xffF7F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F4FF),
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // profile image dalo
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.deepPurple,
                    backgroundImage:
                    _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 42,
                    )
                        : null,
                  ),

                  // camera icon overlay
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Text(
              user?.displayName ?? "SmartCut User",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              email,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 5),

            // remove image
            if (_image != null)
              TextButton(
                onPressed: () {
                  setState(() {
                    _image = null;
                  });
                },
                child: const Text(
                  "Remove Profile Photo",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            // edit prof button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const EditProfileScreen())
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),

            const SizedBox(height: 25),

            _tile(
              context,
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),

            _tile(
              context,
              icon: Icons.person_2_outlined,
              title: "Signup With Another Account",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUp(),
                  ),
                );
              },
            ),

            _tile(
              context,
              icon: Icons.logout,
              title: "Logout",
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Login(),
                  ),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
















// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smartcut_proj/screens/login_screen.dart';
// import 'package:smartcut_proj/screens/settings_screen.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final email = user?.email ?? "No email";
//
//     return Scaffold(
//       backgroundColor: const Color(0xffF7F4FF),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffF7F4FF),
//         elevation: 0,
//         title: const Text(
//           "Profile",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//
//             const CircleAvatar(
//               radius: 42,
//               backgroundColor: Colors.deepPurple,
//               child: Icon(
//                 Icons.person,
//                 color: Colors.white,
//                 size: 42,
//               ),
//             ),
//
//             const SizedBox(height: 14),
//
//             const Text(
//               "SmartCut User",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//
//             const SizedBox(height: 4),
//
//             Text(
//               email,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             _tile(
//               context,
//               icon: Icons.settings_outlined,
//               title: "Settings",
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const SettingsScreen(),
//                   ),
//                 );
//               },
//             ),
//
//             _tile(
//               context,
//               icon: Icons.logout,
//               title: "Logout",
//               onTap: () async {
//                 await FirebaseAuth.instance.signOut();
//
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const Login(),
//                   ),
//                       (route) => false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _tile(
//       BuildContext context, {
//         required IconData icon,
//         required String title,
//         required VoidCallback onTap,
//       }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.deepPurple),
//         title: Text(title),
//         trailing: const Icon(Icons.chevron_right),
//         onTap: onTap,
//       ),
//     );
//   }
// }