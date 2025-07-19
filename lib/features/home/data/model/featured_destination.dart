class FeaturedDestination {
  final String title;
  final double rating;
  final String imageUrl;

  FeaturedDestination({
    required this.title,
    required this.rating,
    required this.imageUrl,
  });

  factory FeaturedDestination.fromJson(Map<String, dynamic> json) {
    return FeaturedDestination(
      title: json['title'],
      rating: double.parse(json['rating'].toString()),
      imageUrl: json['imageUrl'],
    );
  }
}
