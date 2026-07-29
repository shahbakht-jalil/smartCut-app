class Haircut {
  final String name;
  final String image;
  final String gender;
  final String barberTag;

  const Haircut({
    required this.name,
    required this.image,
    required this.gender,
    required this.barberTag,
  });
}

Map<String, List<Haircut>> haircutRules = {
  "oval": [
    Haircut(
      name: "Long Layers",
      image: "assets/images/hairs/male/long layers.jpg",
      gender: "male",
      barberTag: "layers",
    ),
    Haircut(
      name: "Side Swept",
      image: "assets/images/hairs/male/Side Swept.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
      name: "Faux Hawk",
      image: "assets/images/hairs/male/Faux Hawk.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
      name: "Brushed-Up",
      image: "assets/images/hairs/male/brushed-up.jpg",
      gender: "male",
      barberTag: "fade",
    ),

    Haircut(
      name: "Super Pixie",
      image: "assets/images/hairs/female/Super Pixie cut.jpg",
      gender: "female",
      barberTag: "bob",
    ),
    Haircut(
      name: "Blunt Bob",
      image: "assets/images/hairs/female/Blunt Power Bob.jfif",
      gender: "female",
      barberTag: "bob",
    ),
    Haircut(
      name: "Modern Shag",
      image: "assets/images/hairs/female/Modern Shag.jpg",
      gender: "female",
      barberTag: "layers",
    ),
  ],

  "round": [
    Haircut(
      name: "Undercut",
      image: "assets/images/hairs/male/undercut.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
      name: "Quiff",
      image: "assets/images/hairs/male/quiff.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
      name: "Ivy League",
      image: "assets/images/hairs/male/Ivy League.webp",
      gender: "male",
      barberTag: "fade",
    ),

    Haircut(
      name: "Layers Cut",
      image: "assets/images/hairs/female/layers.jpg",
      gender: "female",
      barberTag: "layers",
    ),
    Haircut(
      name: "Wolf Cut",
      image: "assets/images/hairs/female/Wolf Cut.jpg",
      gender: "female",
      barberTag: "layers",
    ),
    Haircut(
        name: "Textured Lob with Bangs",
        image: "assets/images/hairs/Textured Lob with Bangs.jpg",
        gender: "female",
      barberTag: "layers",
    ),
  ],

  "square": [
    Haircut(
      name: "Crew Cut",
      image: "assets/images/hairs/male/crew cut.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
      name: "Buzz Cut",
      image: "assets/images/hairs/male/buzz cut.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
        name: "Side-Swept Fringe",
        image: "assets/images/hairs/male/side swept fringe.webp",
        gender: "male",
        barberTag: "fade",
    ),


    Haircut(
      name: "Curtain Bangs",
      image: "assets/images/hairs/female/Curtain Bangs.jfif",
      gender: "female",
      barberTag: "layers",
      ),
    Haircut(
      name: "Bouncy Layers",
      image: "assets/images/hairs/female/bouncy layers.jpg",
      gender: "female",
      barberTag: "layers",
    ),
    Haircut(
        name: "Long Ghost Layers",
        image: "assets/images/hairs/female/Long Ghost Layers.jpg",
        gender: "female",
        barberTag: "layers",
    ),

  ],

  "heart": [
    Haircut(
      name: "Chin Bob",
      image: "assets/images/hairs/female/Chin-Length Bob.jpg",
      gender: "female",
      barberTag: "bob",
    ),
    Haircut(
      name: "Feather Layers",
      image: "assets/images/hairs/female/Feathered Layers.jpg",
      gender: "female",
      barberTag: "layers",
    ),
    Haircut(
        name: "Medium‑length Waves or Layers",
        image: "assets/images/hairs/male/Medium‑length Waves or Layers.webp",
        gender: "male",
        barberTag: "layers",
    ),
    Haircut(
        name: "Pospiky Haircut",
        image: "assets/images/hairs/male/Pospiky Haircut.jpg",
        gender: "male",
        barberTag: "layers",
    ),
  ],

  "long": [
    Haircut(
      name: "Textured Crop",
      image: "assets/images/hairs/male/Textured Crop.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
      name: "French Crop",
      image: "assets/images/hairs/male/french cut.jpg",
      gender: "male",
      barberTag: "fade",
    ),
    Haircut(
        name: "Caesar Cut",
        image: "assets/images/hairs/male/ceaser.webp",
        gender: "male",
        barberTag: "fade",
    ),


    Haircut(
      name: "Butterfly Cut",
      image: "assets/images/hairs/female/Butterfly Cut.jpg",
      gender: "female",
      barberTag: "layers",
    ),
    Haircut(
        name: "Blunt Bangs",
        image: "assets/images/hairs/female/Blunt Bangs.jpg",
        gender: "female",
        barberTag: "layers",
    ),
    Haircut(
        name: "Layered Lob",
        image: "assets/images/hairs/female/Layered Lob.jpg",
        gender: "female",
        barberTag: "layers",
    ),
  ],
};

List<Haircut> getRecommendation(String faceShape, String gender) {
  final list = haircutRules[faceShape.toLowerCase()] ?? [];
  return list.where((h) => h.gender == gender).toList();
}

class Barber {
  final String name;
  final String expertise;
  final String location;
  final double lat;
  final double lng;
  final String gender;
  final String barberTag;

  const Barber({
    required this.name,
    required this.expertise,
    required this.location,
    required this.lat,
    required this.lng,
    required this.gender,
    required this.barberTag,
  });
}

Map<String, List<Barber>> barberRules = {
  "male": [
    Barber(
      name: "Lavish Men's Salon Johar",
      expertise: "Modern Cuts & Fades",
      location: "Johar Town Karachi",
      lat: 24.9180,
      lng: 67.0970,
      gender: "male",
      barberTag: "fade",
    ),
    Barber(
      name: "Shoaib Salon",
      expertise: "Classic Cuts",
      location: "Gulistan-e-Johar",
      lat: 24.9205,
      lng: 67.1220,
      gender: "male",
      barberTag: "layers",
    ),
    Barber(
      name: "The Hair Lab",
      expertise: "Trendy Fades",
      location: "Clifton Karachi",
      lat: 24.8138,
      lng: 67.0307,
      gender: "male",
      barberTag: "fade",
    ),
    Barber(
      name: "XPERT Men's Salon",
      expertise: "Beard & Fade",
      location: "PECHS Karachi",
      lat: 24.8735,
      lng: 67.0640,
      gender: "male",
      barberTag: "fade",
    ),
    Barber(
      name: "The Barber Salon by Younus",
      expertise: "Modern Styling",
      location: "Bahadurabad Karachi",
      lat: 24.8720,
      lng: 67.0750,
      gender: "male",
      barberTag: "layers",
    ),
  ],

  "female": [
    Barber(
      name: "Lavish Women Salon Johar",
      expertise: "Hair Styling",
      location: "Johar Town Karachi",
      lat: 24.9180,
      lng: 67.0970,
      gender: "female",
      barberTag: "layers",
    ),
    Barber(
      name: "Mayah Mughal Salon",
      expertise: "Bridal Makeup",
      location: "Gulshan Karachi",
      lat: 24.9200,
      lng: 67.0900,
      gender: "female",
      barberTag: "bob",
    ),
    Barber(
      name: "Sana Sarah Salon",
      expertise: "Hair Styling",
      location: "Johar Block 13",
      lat: 24.9145,
      lng: 67.1080,
      gender: "female",
      barberTag: "layers",
    ),
    Barber(
      name: "Flourish Salon",
      expertise: "Premium Care",
      location: "Clifton Karachi",
      lat: 24.8138,
      lng: 67.0307,
      gender: "female",
      barberTag: "bob",
    ),
    Barber(
      name: "New Rose Beauty Salon",
      expertise: "Beauty & Styling",
      location: "PECHS Karachi",
      lat: 24.8730,
      lng: 67.0645,
      gender: "female",
      barberTag: "layers",
    ),
  ],
};

List<Barber> getBarberRecommendation(String gender, String barberTag) {
  final all = barberRules[gender] ?? [];
  return all.where((b) => b.barberTag == barberTag).toList();
}


















//first important one without barber
// class Haircut {
//   final String name;
//   final String image;
//   final String gender;
//
//
//   const Haircut({
//     required this.name,
//     required this.image,
//     required this.gender,
//   });
// }
//
// Map<String, List<Haircut>> haircutRules = {
//   "oval": [
//     Haircut(name: "Long Layers", image: "assets/images/hairs/male/long layers.jpg", gender: "male"),
//     Haircut(name: "Classic Textured Side Swept", image: "assets/images/hairs/male/Side Swept.jpg", gender: "male"),
//     Haircut(name: "Faux Hawk", image: "assets/images/hairs/male/Faux Hawk.jpg", gender: "male"),
//
//
//     Haircut(name: "Super Pixie", image: "assets/images/hairs/female/Super Pixie cut.jpg", gender: "female"),
//     Haircut(name: "Blunt Power Bob", image: "assets/images/hairs/female/Blunt Power Bob.jfif", gender: "female"),
//     Haircut(name: "Modern Shag", image: "assets/images/hairs/female/Modern Shag.jpg", gender: "female"),
//   ],
//
//
//   "round": [
//     Haircut(name: "Undercut", image: "assets/images/hairs/male/undercut.jpg", gender: "male"),
//     Haircut(name: "High Fade with Quiff", image: "assets/images/hairs/male/quiff.jpg", gender: "male"),
//     Haircut(name: "Ivy League", image: "assets/images/hairs/male/Ivy League.webp", gender: "male"),
//
//     Haircut(name: "Layers", image: "assets/images/hairs/female/layers.jpg", gender: "female"),
//     Haircut(name: "Textured Lob with Bangs", image: "assets/images/hairs/female/Textured Lob with Bangs.jpg", gender: "female"),
//     Haircut(name: "Wolf Cut", image: "assets/images/hairs/female/Wolf Cut.jpg", gender: "female"),
//   ],
//
//   "square": [
//     Haircut(name: "Crew Cut", image: "assets/images/hairs/male/crew cut.jpg", gender: "male"),
//     Haircut(name: "Buzz cut", image: "assets/images/hairs/male/buzz cut.jpg", gender: "male"),
//     Haircut(name: "Side-Swept Fringe", image: "assets/images/hairs/male/side swept fringe.webp", gender: "male"),
//
//     Haircut(name: "Bouncy layers", image: "assets/images/hairs/female/bouncy layers.jpg", gender: "female"),
//     Haircut(name: "Long Ghost Layers", image: "assets/images/hairs/female/Long Ghost Layers.jpg", gender: "female"),
//     Haircut(name: "Curtain Bangs", image: "assets/images/hairs/female/Curtain Bangs.jfif", gender: "female"),
//   ],
//
//   "heart": [
//     Haircut(name: "Chin-Length Bob", image: "assets/images/hairs/female/Chin-Length Bob.jpg", gender: "female"), // FIXED
//     Haircut(name: "Layered Inward Lob", image: "assets/images/hairs/female/layered Inward Lob.jpg", gender: "female"),
//     Haircut(name: "Feathered Layers", image: "assets/images/hairs/female/Feathered Layers.jpg", gender: "female"),
//     Haircut(name: "Long Beachy Waves", image: "assets/images/hairs/female/Long Beachy Waves.jpg", gender: "female"),
//     Haircut(name: "Pixie with Side Fringe", image: "assets/images/hairs/female/Pixie with Side Fringe.jpg", gender: "female"),
//     Haircut(name: "Feathery fringe", image: "assets/images/hairs/female/Feathery fringe.jpg", gender: "female"),
//
//     Haircut(name: "Center Part", image: "assets/images/hairs/male/Center Part.jpg", gender: "male"),
//     Haircut(name: "Curly Top With Low Fade", image: "assets/images/hairs/male/Curly Top With Low Fade.jpg", gender: "male"),
//     Haircut(name: "Medium‑length Waves or Layers", image: "assets/images/hairs/male/Medium‑length Waves or Layers.webp", gender: "male"),
//     Haircut(name: "Pospiky Haircut", image: "assets/images/hairs/male/Pospiky Haircut.jpg", gender: "male"),
//
//   ],
//
//   "long": [
//     Haircut(name: "Textured Crop", image: "assets/images/hairs/male/Textured Crop.jpg", gender: "male"),
//     Haircut(name: "French Crop", image: "assets/images/hairs/male/french cut.jpg", gender: "male"),
//     Haircut(name: "Caesar Cut", image: "assets/images/hairs/male/ceaser.webp", gender: "male"),
//
//     Haircut(name: "Blunt Bangs", image: "assets/images/hairs/female/Blunt Bangs.jpg", gender: "female"),
//     Haircut(name: "Butterfly Cut", image: "assets/images/hairs/female/Butterfly Cut.jpg", gender: "female"),
//     Haircut(name: "Layered Lob", image: "assets/images/hairs/female/Layered Lob.jpg", gender: "female"),
//   ],
// };
//
// List<Haircut> getRecommendation(String faceShape, String gender) {
//   final list = haircutRules[faceShape.toLowerCase()] ?? [];
//
//   return list
//       .where((h) => h.gender.toLowerCase() == gender.toLowerCase())
//       .toList();
// }


//
// class Haircut {
//   final String name;
//   final String image;
//   final String gender;
//   final List<String> barbers;
//
//   const Haircut({
//     required this.name,
//     required this.image,
//     required this.gender,
//     required this.barbers,
//   });
// }
//
// Map<String, List<Haircut>> haircutRules = {
//   "oval": [
//     Haircut(
//       name: "Long Layers",
//       image: "assets/images/hairs/male/long layers.jpg",
//       gender: "male",
//       barbers: ["Ali Barber", "Karachi Cuts"],
//     ),
//     Haircut(
//       name: "Classic Textured Side Swept",
//       image: "assets/images/hairs/male/Side Swept.jpg",
//       gender: "male",
//       barbers: ["Fade Zone", "Trim House"],
//     ),
//     Haircut(
//       name: "Faux Hawk",
//       image: "assets/images/hairs/male/Faux Hawk.jpg",
//       gender: "male",
//       barbers: ["Urban Cuts"],
//     ),
//
//     Haircut(
//       name: "Super Pixie",
//       image: "assets/images/hairs/female/Super Pixie cut.jpg",
//       gender: "female",
//       barbers: ["Glam Studio"],
//     ),
//     Haircut(
//       name: "Blunt Power Bob",
//       image: "assets/images/hairs/female/Blunt Power Bob.jfif",
//       gender: "female",
//       barbers: ["Beauty Lounge"],
//     ),
//     Haircut(
//       name: "Modern Shag",
//       image: "assets/images/hairs/female/Modern Shag.jpg",
//       gender: "female",
//       barbers: ["Style Hub"],
//     ),
//   ],
//
//   "round": [
//     Haircut(
//       name: "Undercut",
//       image: "assets/images/hairs/male/undercut.jpg",
//       gender: "male",
//       barbers: ["Cut & Style", "Fast Fade"],
//     ),
//     Haircut(
//       name: "High Fade with Quiff",
//       image: "assets/images/hairs/male/quiff.jpg",
//       gender: "male",
//       barbers: ["Karachi Clippers"],
//     ),
//     Haircut(
//       name: "Ivy League",
//       image: "assets/images/hairs/male/Ivy League.webp",
//       gender: "male",
//       barbers: ["Elite Barber"],
//     ),
//
//     Haircut(
//       name: "Layers",
//       image: "assets/images/hairs/female/layers.jpg",
//       gender: "female",
//       barbers: ["Hair Hub"],
//     ),
//     Haircut(
//       name: "Textured Lob with Bangs",
//       image: "assets/images/hairs/female/Textured Lob with Bangs.jpg",
//       gender: "female",
//       barbers: ["Pink Salon"],
//     ),
//     Haircut(
//       name: "Wolf Cut",
//       image: "assets/images/hairs/female/Wolf Cut.jpg",
//       gender: "female",
//       barbers: ["Glow Salon"],
//     ),
//   ],
//
//   "square": [
//     Haircut(
//       name: "Crew Cut",
//       image: "assets/images/hairs/male/crew cut.jpg",
//       gender: "male",
//       barbers: ["Urban Cuts"],
//     ),
//     Haircut(
//       name: "Buzz cut",
//       image: "assets/images/hairs/male/buzz cut.jpg",
//       gender: "male",
//       barbers: ["Fast Fade"],
//     ),
//     Haircut(
//       name: "Side-Swept Fringe",
//       image: "assets/images/hairs/male/side swept fringe.webp",
//       gender: "male",
//       barbers: ["Trim House"],
//     ),
//
//     Haircut(
//       name: "Bouncy layers",
//       image: "assets/images/hairs/female/bouncy layers.jpg",
//       gender: "female",
//       barbers: ["Beauty Spot"],
//     ),
//     Haircut(
//       name: "Long Ghost Layers",
//       image: "assets/images/hairs/female/Long Ghost Layers.jpg",
//       gender: "female",
//       barbers: ["Salon Pro"],
//     ),
//     Haircut(
//       name: "Curtain Bangs",
//       image: "assets/images/hairs/female/Curtain Bangs.jfif",
//       gender: "female",
//       barbers: ["Style Studio"],
//     ),
//   ],
//
//   "heart": [
//     Haircut(
//       name: "Chin-Length Bob",
//       image: "assets/images/hairs/female/Chin-Length Bob.jpg",
//       gender: "female",
//       barbers: ["Glow Salon"],
//     ),
//     Haircut(
//       name: "Layered Inward Lob",
//       image: "assets/images/hairs/female/layered Inward Lob.jpg",
//       gender: "female",
//       barbers: ["Hair Experts"],
//     ),
//     Haircut(
//       name: "Feathered Layers",
//       image: "assets/images/hairs/female/Feathered Layers.jpg",
//       gender: "female",
//       barbers: ["Luxury Salon"],
//     ),
//
//     Haircut(
//       name: "Center Part",
//       image: "assets/images/hairs/male/Center Part.jpg",
//       gender: "male",
//       barbers: ["Classic Barber"],
//     ),
//     Haircut(
//       name: "Curly Top With Low Fade",
//       image: "assets/images/hairs/male/Curly Top With Low Fade.jpg",
//       gender: "male",
//       barbers: ["Curl Studio"],
//     ),
//   ],
//
//   "long": [
//     Haircut(
//       name: "Textured Crop",
//       image: "assets/images/hairs/male/Textured Crop.jpg",
//       gender: "male",
//       barbers: ["Trim House"],
//     ),
//     Haircut(
//       name: "French Crop",
//       image: "assets/images/hairs/male/french cut.jpg",
//       gender: "male",
//       barbers: ["Classic Barber"],
//     ),
//     Haircut(
//       name: "Caesar Cut",
//       image: "assets/images/hairs/male/ceaser.webp",
//       gender: "male",
//       barbers: ["Elite Barber"],
//     ),
//
//     Haircut(
//       name: "Blunt Bangs",
//       image: "assets/images/hairs/female/Blunt Bangs.jpg",
//       gender: "female",
//       barbers: ["Beauty Lounge"],
//     ),
//     Haircut(
//       name: "Butterfly Cut",
//       image: "assets/images/hairs/female/Butterfly Cut.jpg",
//       gender: "female",
//       barbers: ["Pink Salon"],
//     ),
//     Haircut(
//       name: "Layered Lob",
//       image: "assets/images/hairs/female/Layered Lob.jpg",
//       gender: "female",
//       barbers: ["Style Hub"],
//     ),
//   ],
// };
//
// List<Haircut> getRecommendation(String faceShape, String gender) {
//   final list = haircutRules[faceShape.toLowerCase()] ?? [];
//
//   return list
//       .where((h) => h.gender.toLowerCase() == gender.toLowerCase())
//       .toList();
// }