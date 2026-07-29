import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSmartCutScreen extends StatelessWidget {
  const AboutSmartCutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        elevation: 0,
        title: Text(
          "About SmartCut",
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

            // TITLE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFFF48FB1)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "SmartCut",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // DESCRIPTION CARD
            _card(
              child: Text(
                "SmartCut is an AI-powered personal hairstylist app designed to help users find the best haircut based on their face shape, style preference, and personality.",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),

            const SizedBox(height: 20),

            // FEATURES TITLE
            Text(
              "Features",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 10),

            _feature("AI face shape detection"),
            _feature("Personalized haircut suggestions"),
            _feature("Virtual hairstyle preview"),
            _feature("Smart recommendation system"),
            _feature("User-friendly mobile experience"),

            const SizedBox(height: 20),

            // MISSION TITLE
            Text(
              "Mission",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 10),

            _card(
              child: Text(
                "Our mission is to revolutionize the way people choose hairstyles using artificial intelligence, making grooming smarter, faster, and more personalized.",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CARD WIDGET
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: child,
    );
  }

  // FEATURE ITEM
  Widget _feature(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF6A1B9A)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}