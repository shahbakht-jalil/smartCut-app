import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FF), // light pinkish background
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A), // purple
        elevation: 0,
        title: Text(
          "Help & FAQ",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            Text(
              "Frequently Asked Questions",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 20),

            faqItem(
              question: "What is SmartCut?",
              answer:
              "SmartCut is an AI-based hairstylist app that recommends haircuts based on your face shape.",
            ),

            faqItem(
              question: "How does SmartCut work?",
              answer:
              "It uses AI face analysis to detect your face shape and suggests suitable hairstyles.",
            ),

            faqItem(
              question: "Do I need internet?",
              answer:
              "Yes, some features like AI recommendations may require internet connectivity.",
            ),

            faqItem(
              question: "Is my data safe?",
              answer:
              "Yes, your images and data are handled securely and are not shared with third parties.",
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFFF48FB1)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "Need more help? Contact support or check updates in the app 💜",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget faqItem({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        collapsedIconColor: const Color(0xFF6A1B9A),
        iconColor: const Color(0xFF6A1B9A),
        title: Text(
          question,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4A148C),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              answer,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}