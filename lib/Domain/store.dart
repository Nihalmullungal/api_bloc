class Store {
  String name;
  dynamic price;
  String image;
  String description;
  Store(
      {required this.name,
      required this.description,
      required this.price,
      required this.image});
  static Store fromJson(Map<String, dynamic> json) {
    return Store(
        name: json["title"],
        description: json["description"],
        price: json["price"],
        image: json["image"]);
  }
}
