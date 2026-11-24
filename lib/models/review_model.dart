class ReviewModel {
  final String studentName;
  final String timeAgo;
  final double rating;
  final String comment;

  const ReviewModel({
    required this.studentName,
    required this.timeAgo,
    required this.rating,
    required this.comment,
  });
}