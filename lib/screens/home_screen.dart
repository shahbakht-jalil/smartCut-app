// import 'package:flutter/material.dart';
// import 'onboarding.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xff0f0c29), Color(0xff302b63), Color(0xff24243e)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // App Icon
//             const Icon(
//               Icons.content_cut,
//               size: 100,
//               color: Colors.white,
//             ),
//
//             const SizedBox(height: 20),
//
//             const Text(
//               "SmartCut",
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             const Text(
//               "AI Personal Hairstylist",
//               style: TextStyle(color: Colors.white70),
//             ),
//
//             const SizedBox(height: 50),
//
//             // Start Button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const OnboardingScreen(),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   "Get Started",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:smartcut_proj/screens/login_screen.dart';
// // import 'package:smartcut_proj/screens/signup_screen.dart';
// //
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key, });
// //
// //
// //   // build method UI return krega
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //
// //           // image container
// //           Container(
// //             height: 400,
// //             width: double.infinity,
// //             margin: const EdgeInsets.symmetric(horizontal: 20),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(12),
// //               image: const DecorationImage(
// //                 //image loading from assets
// //                 image: AssetImage("assets/images/img1.png"),
// //                 fit: BoxFit.cover, // pura container fill kare image se
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 40),
// //
// //           // Sign Up button
// //           SizedBox(
// //             width: double.infinity,
// //             height: 50,
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   // to open signup page
// //                   Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) => const SignUp()
// //                       )
// //                   );
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.deepPurple,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 child: const Text(
// //                   'Sign Up',
// //                   style:
// //                   TextStyle(
// //                     fontSize: 16,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 15),
// //
// //           // Sign In button
// //           SizedBox(
// //             width: double.infinity,
// //             height: 50,
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               child: OutlinedButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder:
// //                               (context) => const Login()
// //                       )
// //                   );
// //                 },
// //                 style: OutlinedButton.styleFrom(
// //                   side: const BorderSide(color: Colors.deepPurple),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 child: const Text(
// //                   'Sign In',
// //                   style:
// //                   TextStyle(
// //                     fontSize: 16,
// //                     color: Colors.deepPurple,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }