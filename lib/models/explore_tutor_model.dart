class ExploreTutorModel {
  final String id;
  final String name;
  final String subject;
  final String category;
  final String image; 
  final double rating;
  final int reviews;
  final double price;
  final bool isOnline;
  final bool isHome;

  const ExploreTutorModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.category,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.price,
    this.isOnline = true,
    this.isHome = true,
  });
}