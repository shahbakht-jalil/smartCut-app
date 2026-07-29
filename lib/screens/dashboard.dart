import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:smartcut_proj/logic/recommendation_service.dart';
import 'package:smartcut_proj/screens/result_scree.dart';
import 'package:smartcut_proj/screens/settings_screen.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Interpreter interpreter;

  File? image;
  String selectedGender = "male";
  bool isAnalyzing = false;

  final labels = ['oval', 'round', 'square', 'heart', 'long'];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset(
      'assets/model/smartcut_model.tflite',
    );
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      image = File(picked.path);
    });
  }

  List preprocess(File file) {
    final bytes = file.readAsBytesSync();
    final decoded = img.decodeImage(bytes)!;
    final resized = img.copyResize(decoded, width: 224, height: 224);

    return [
      List.generate(224, (y) {
        return List.generate(224, (x) {
          final p = resized.getPixel(x, y);
          return [p.r / 255.0, p.g / 255.0, p.b / 255.0];
        });
      })
    ];
  }

  Future<void> analyzeImage() async {
    if (image == null) return;

    setState(() => isAnalyzing = true);

    final croppedFace = await detectAndCropFace(image!);
    if (croppedFace == null) {
      setState(() => isAnalyzing = false);
      return;
    }

    final input = preprocess(croppedFace);
    final output = [List.filled(labels.length, 0.0)];

    interpreter.run(input, output);

    int maxIndex = 0;
    double maxConfidence = output[0][0];

    for (int i = 1; i < labels.length; i++) {
      if (output[0][i] > maxConfidence) {
        maxConfidence = output[0][i];
        maxIndex = i;
      }
    }

    setState(() => isAnalyzing = false);

    if (maxConfidence < 0.60) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid image. Please upload a clear human face."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final detectedShape = labels[maxIndex];
    final haircuts = getRecommendation(detectedShape, selectedGender);
    final tag = haircuts.isNotEmpty ? haircuts.first.barberTag : "fade";
    final barbers = getBarberRecommendation(selectedGender, tag);

    // Navigate to Result Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          faceShape: detectedShape,
          gender: selectedGender,
          userImage: image!,
          haircuts: haircuts,
          barbers: barbers,
        ),
      ),
    );
  }

  Future<File?> detectAndCropFace(File file) async {
    final inputImage = InputImage.fromFile(file);

    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
      ),
    );

    final faces = await faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      await faceDetector.close();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No face detected. Please upload a clear face image."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return null;
    }

    final bytes = await file.readAsBytes();
    final original = img.decodeImage(bytes);

    if (original == null) {
      await faceDetector.close();
      return null;
    }

    final face = faces.first;
    final box = face.boundingBox;

    final cropped = img.copyCrop(
      original,
      x: box.left.toInt().clamp(0, original.width - 1),
      y: box.top.toInt().clamp(0, original.height - 1),
      width: box.width.toInt().clamp(1, original.width),
      height: box.height.toInt().clamp(1, original.height),
    );

    final croppedFile = File('${file.parent.path}/cropped_face.jpg');
    await croppedFile.writeAsBytes(img.encodeJpg(cropped));

    await faceDetector.close();
    return croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SmartCut',
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        'AI Hair Style Recommender',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SettingsScreen()),
                        );
                      },
                      icon: const Icon(Icons.settings_outlined,
                          size: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Gender Selection ──────────────────────────────────────
              Text('Select Gender',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),

              const SizedBox(height: 8),

              Row(
                children: [
                  Radio(
                    value: "male",
                    groupValue: selectedGender,
                    activeColor: Colors.deepPurple,
                    onChanged: (value) =>
                        setState(() => selectedGender = value.toString()),
                  ),
                  const Text("Male"),
                  const SizedBox(width: 16),
                  Radio(
                    value: "female",
                    groupValue: selectedGender,
                    activeColor: Colors.deepPurple,
                    onChanged: (value) =>
                        setState(() => selectedGender = value.toString()),
                  ),
                  const Text("Female"),
                ],
              ),

              const SizedBox(height: 18),

              // ── Upload Banner ─────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xffB892FF), Color(0xff8E63F5)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Discover the best haircut for your face shape',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload your photo and let AI recommend styles that suit you.',
                      style: GoogleFonts.poppins(
                          color: Colors.white70, fontSize: 12, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.upload_outlined,
                                size: 16, color: Colors.deepPurple),
                            const SizedBox(width: 6),
                            Text(
                              'Upload Image',
                              style: GoogleFonts.poppins(
                                color: Colors.deepPurple,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Image Preview ─────────────────────────────────────────
              Container(
                constraints: const BoxConstraints(minHeight: 200, maxHeight: 400),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.black12),
                ),
                child: image == null
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.image_outlined,
                          size: 48, color: Colors.black26),
                      const SizedBox(height: 8),
                      Text(
                        "No image selected",
                        style: GoogleFonts.poppins(color: Colors.black38),
                      ),
                    ],
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.file(image!, fit: BoxFit.contain),
                ),
              ),

              const SizedBox(height: 20),

              // ── Analyze Button ────────────────────────────────────────
              if (image != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAnalyzing ? null : analyzeImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: isAnalyzing
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                        : Text(
                      "Analyze My Face",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              // ── Reset ─────────────────────────────────────────────────
              if (image != null)
                Center(
                  child: TextButton(
                    onPressed: () => setState(() => image = null),
                    child: Text(
                      "Reset",
                      style: GoogleFonts.poppins(color: Colors.black45),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


















// // dasboard.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;
// import 'package:smartcut_proj/logic/recommendation_service.dart';
// import 'package:smartcut_proj/screens/settings_screen.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//
//   bool isSettingsHovered = false;
//
//   late Interpreter interpreter;
//
//   File? image;
//   String faceShape = "";
//   String selectedGender = "male";
//
//   List<Haircut> suggestions = [];
//   List<Barber> barberSuggestions = []; // 👈 ADD THIS
//
//   final labels = ['oval', 'round', 'square', 'heart', 'long'];
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     loadModel();
//
//   }
//
//   Future<void> loadModel() async {
//     interpreter = await Interpreter.fromAsset(
//       'assets/model/smartcut_model.tflite',
//     );
//   }
//
//   Future<void> pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked == null) return;
//
//     setState(() {
//       image = File(picked.path);
//       faceShape = "";
//       suggestions = [];
//     });
//
//     runModel();
//   }
//
//   List preprocess(File file) {
//     final bytes = file.readAsBytesSync();
//     final decoded = img.decodeImage(bytes)!;
//     final resized = img.copyResize(decoded, width: 224, height: 224);
//
//     // normalization
//     return [
//       List.generate(224, (y) {
//         return List.generate(224, (x) {
//           final p = resized.getPixel(x, y);
//           return [p.r / 255.0, p.g / 255.0, p.b / 255.0];
//         });
//       })
//     ];
//   }
//
//   Future<void> runModel() async {
//       if (image == null) return;
//
//       // prediction
//       final croppedFace = await detectAndCropFace(image!);
//       if (croppedFace == null) return;
//
//       final input = preprocess(croppedFace);
//       final output = [List.filled(labels.length, 0.0)];
//
//       // model is predicting
//       interpreter.run(input, output);
//
//       int maxIndex = 0;
//       double maxConfidence = output[0][0];
//
//       for (int i = 1; i < labels.length; i++) {
//         if (output[0][i] > maxConfidence) {
//           maxConfidence = output[0][i];
//           maxIndex = i;
//         }
//       }
//
//       // threshold
//       if (maxConfidence < 0.60) {
//         setState(() {
//           faceShape = "";
//           suggestions = [];
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Invalid image. Please upload a clear human face."),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//         return;
//       }
//
//       bool isRandomImage(List<double> probs) {
//         double sum = 0;
//         for (var p in probs) {
//           sum += (p * (1 - p)).abs();
//         }
//
//         return sum > 0.9;
//       }
//
//       final detectedShape = labels[maxIndex];
//
//
//       setState(() {
//         faceShape = detectedShape;
//         suggestions = getRecommendation(detectedShape, selectedGender);
//         barberSuggestions = getBarberRecommendation(selectedGender);
//       }
//     );
//   }
//
//   Future<void> openMap(double lat, double lng) async {
//     final Uri url = Uri.parse(
//       "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
//     );
//
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       throw "Could not open map";
//     }
//   }
//
//   // cropping
//   Future<File?> detectAndCropFace(File file) async {
//     final inputImage = InputImage.fromFile(file);
//
//     final faceDetector = FaceDetector(
//       options: FaceDetectorOptions(
//         performanceMode: FaceDetectorMode.fast,
//       ),
//     );
//
//     final faces = await faceDetector.processImage(inputImage);
//
//     if (faces.isEmpty) {
//       await faceDetector.close();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("No face detected. Please upload a clear face image."),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//
//       return null;
//     }
//
//     final bytes = await file.readAsBytes();
//     final original = img.decodeImage(bytes);
//
//     if (original == null) {
//       await faceDetector.close();
//       return null;
//     }
//
//     final face = faces.first;
//     final box = face.boundingBox;
//
//     final cropped = img.copyCrop(
//       original,
//       x: box.left.toInt().clamp(0, original.width - 1),
//       y: box.top.toInt().clamp(0, original.height - 1),
//       width: box.width.toInt().clamp(1, original.width),
//       height: box.height.toInt().clamp(1, original.height),
//     );
//
//     final croppedFile = File('${file.parent.path}/cropped_face.jpg');
//     await croppedFile.writeAsBytes(img.encodeJpg(cropped));
//
//     await faceDetector.close();
//
//     return croppedFile;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'SmartCut',
//                           style: GoogleFonts.poppins(
//                             fontSize: 26,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.deepPurple,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'AI Hair Style Recommender',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: Colors.white70,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.black12),
//                       ),
//                       child: IconButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const SettingsScreen(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(
//                           Icons.settings_outlined,
//                           size: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 18),
//               // gender radio
//               Text(
//                 'Select Gender',
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                 ),
//               ),
//               if (faceShape.isNotEmpty)
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       image = null;
//                       faceShape = "";
//                       suggestions = [];
//                     });
//                   },
//                   child: const Text("Reset"),
//                 ),
//               Row(
//                 children: [
//
//                   Radio(
//                     value: "male",
//                     groupValue: selectedGender,
//                     onChanged: faceShape.isNotEmpty
//                         ? null
//                         : (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//
//                       });
//                     },
//                   ),
//                   const Text("Male"),
//
//                   Radio(
//                     value: "female",
//                     groupValue: selectedGender,
//                     onChanged: faceShape.isNotEmpty
//                         ? null
//                         : (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                       });
//                     },
//                   ),
//                   const Text("Female"),
//                 ],
//               ),
//
//               const SizedBox(height: 14),
//
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(24),
//                   gradient: const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color(0xffB892FF),
//                       Color(0xff8E63F5),
//                     ],
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Icon(
//                           Icons.auto_awesome,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             'Discover the best haircut for your face shape',
//                             style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               height: 1.4,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     Text(
//                       'Upload your photo and let AI recommend styles that suit you.',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white70,
//                         fontSize: 12,
//                         height: 1.5,
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     InkWell(
//                       onTap: pickImage,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(
//                               Icons.upload_outlined,
//                               size: 16,
//                               color: Colors.deepPurple,
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               'Upload Image',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.deepPurple,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // image preview
//               Container(
//                 constraints: const BoxConstraints(
//                   minHeight: 200,
//                   maxHeight: 400, // Image ki lambai ke mutabiq dabba khud bada ho jayega
//                 ),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(22),
//                   border: Border.all(color: Colors.black12, width: 1), // Halki si boundary
//                 ),
//                 child: image == null
//                     ? const Center(child: Text("No image selected"))
//                     : ClipRRect(
//                   borderRadius: BorderRadius.circular(22),
//                   child: Image.file(
//                     image!,
//                     fit: BoxFit.contain, // Isse image "tuti" hui ya pichki hui nahi dikhegi
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // face detection wala
//               if (faceShape.isNotEmpty) ...[
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     // color: Colors.white,
//                     color: Theme.of(context).cardColor,
//                     borderRadius: BorderRadius.circular(20),
//
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Text(
//                         'Detected Face Shape: ${faceShape.toUpperCase()}',
//                         style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                         ),
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       // recommended haircut tiles
//                       Text(
//                         'Recommended Haircuts',
//                         style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 18,
//                         ),
//                       ),
//
//                       const SizedBox(height: 15),
//
//                       // SizedBox(
//                       //   height: 240,
//                       //   child: ListView.builder(
//                       //     scrollDirection: Axis.horizontal, // Side par scroll karne ke liye
//                       //     itemCount: suggestions.length,
//                       //     itemBuilder: (context, index) {
//                       //       final e = suggestions[index];
//                       //
//                       //       return InkWell(
//                       //         onTap: () => _showImageReview(context, e), // Card click hone par popup khulega
//                       //         borderRadius: BorderRadius.circular(20),
//                       //         child: Container(
//                       //           width: 160,
//                       //           margin: const EdgeInsets.only(right: 16),
//                       //           decoration: BoxDecoration(
//                       //             color: Theme.of(context).cardColor,
//                       //             borderRadius: BorderRadius.circular(20),
//                       //             boxShadow: [
//                       //               BoxShadow(
//                       //                 color: Colors.black.withOpacity(0.05),
//                       //                 blurRadius: 10,
//                       //                 offset: const Offset(0, 5),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //           child: Column(
//                       //             crossAxisAlignment: CrossAxisAlignment.start,
//                       //
//                       //             // Haircut Image
//                       //             children: [
//                       //               // Haircut Image
//                       //               ClipRRect(
//                       //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                       //                 child: Image.asset(
//                       //                   e.image,
//                       //                   width: 160,
//                       //                   height: 150,
//                       //                   fit: BoxFit.cover,
//                       //                 ),
//                       //               ),
//                       //
//                       //               // Haircut Details
//                       //               Padding(
//                       //                 padding: const EdgeInsets.all(12),
//                       //                 child: Column(
//                       //                   crossAxisAlignment: CrossAxisAlignment.start,
//                       //                   children: [
//                       //                     Text(
//                       //                       e.name,
//                       //                       maxLines: 1,
//                       //                       overflow: TextOverflow.ellipsis,
//                       //                       style: GoogleFonts.poppins(
//                       //                         fontWeight: FontWeight.w600,
//                       //                         fontSize: 14,
//                       //                       ),
//                       //                     ),
//                       //                     const SizedBox(height: 4),
//                       //                     Text(
//                       //                       "Tap to Review",
//                       //                       style: GoogleFonts.poppins(
//                       //                         color: Colors.deepPurple,
//                       //                         fontSize: 11,
//                       //                         fontWeight: FontWeight.bold,
//                       //                       ),
//                       //                     ),
//                       //                   ],
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         ),
//                       //       );
//                       //     },
//                       //   ),
//                       // ),
//
//                       SizedBox(
//                         height: 240,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: suggestions.length,
//                           itemBuilder: (context, index) {
//                             final e = suggestions[index];
//
//                             return InkWell(
//                               onTap: () => _showImageReview(context, e),
//                               borderRadius: BorderRadius.circular(20),
//                               child: Container(
//                                 width: 160,
//                                 margin: const EdgeInsets.only(right: 16),
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).cardColor,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ],
//                                 ),
//
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//
//                                     // HAIRCUT IMAGE
//                                     ClipRRect(
//                                       borderRadius: const BorderRadius.vertical(
//                                         top: Radius.circular(20),
//                                       ),
//                                       child: Image.asset(
//                                         e.image,
//                                         width: 160,
//                                         height: 150,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//
//                                     // 💇‍♂️ HAIRCUT DETAILS
//                                     Padding(
//                                       padding: const EdgeInsets.all(12),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             e.name,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: GoogleFonts.poppins(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 14,
//                                             ),
//                                           ),
//
//                                           const SizedBox(height: 4),
//
//                                           Text(
//                                             "Tap to Review",
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.deepPurple,
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//
//                       if (barberSuggestions.isNotEmpty) ...[
//                         const SizedBox(height: 20),
//
//                         Text(
//                           "Recommended Barbers",
//                           style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         SizedBox(
//                           height: 140,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: barberSuggestions.length,
//                             itemBuilder: (context, index) {
//                               final b = barberSuggestions[index];
//
//                               return InkWell(
//                                 onTap: () {
//                                   openMap(b.lat, b.lng); // ✅ Google Maps open
//                                 },
//                                 child: Container(
//                                   width: 190,
//                                   margin: const EdgeInsets.only(right: 12),
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: Colors.deepPurple.shade50,
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//
//                                       Text(
//                                         b.name,
//                                         style: GoogleFonts.poppins(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//
//                                       const SizedBox(height: 5),
//
//                                       Text(
//                                         b.expertise,
//                                         style: const TextStyle(fontSize: 12),
//                                       ),
//
//                                       const Spacer(),
//
//                                       Row(
//                                         children: [
//                                           const Icon(Icons.location_on,
//                                               size: 14,
//                                               color: Colors.deepPurple),
//
//                                           const SizedBox(width: 4),
//
//                                           Expanded(
//                                             child: Text(
//                                               b.location,
//                                               style: const TextStyle(fontSize: 11),
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ]
//                     ],
//                   ),
//                 )
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _showImageReview(BuildContext context, Haircut haircut) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//               child: Image.asset(haircut.image, fit: BoxFit.cover),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Text(
//                     haircut.name,
//                     style: GoogleFonts.poppins(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "This style suits your face shape perfectly.",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       ),
//                       child: const Text("Close", style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }