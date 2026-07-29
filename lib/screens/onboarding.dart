import 'package:flutter/material.dart';
import 'package:smartcut_proj/screens/main_shell.dart';
import 'dashboard.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int index = 0;

  final pages = [
    {"title": "AI Hair Analysis", "desc": "Detect your face shape instantly"},
    {"title": "Smart Suggestions", "desc": "Get best hairstyles for you"},
    {"title": "Try & Transform", "desc": "Preview your new look easily"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0f0c29), Color(0xff302b63), Color(0xff24243e)],
            begin: Alignment.topLeft,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => index = i),
                itemCount: pages.length,
                itemBuilder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cut, size: 100, color: Colors.white),
                      const SizedBox(height: 30),
                      Text(
                        pages[i]["title"]!,
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pages[i]["desc"]!,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (i) => Container(
                  margin: const EdgeInsets.all(4),
                  width: index == i ? 12 : 8,
                  height: index == i ? 12 : 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MainShell()),
                  );
                },
                child: const Text("Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}