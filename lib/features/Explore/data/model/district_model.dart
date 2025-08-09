class DistrictModel {
  final String name;
  final List<Place> topPicks;
  final List<Place> hiddenGems;

  DistrictModel({
    required this.name,
    required this.topPicks,
    required this.hiddenGems,
  });

  // I have to add fromJson/toJson methods if needed
}

class Place {
  final String title;
  final String description;
  final String type;

  Place({required this.title, required this.description, required this.type});
}
