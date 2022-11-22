class SheetModel {
  final int id;
  final String title;
  final String? subtitle;
  final String? image;

  SheetModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.image,
  });

  factory SheetModel.fromJson(Map<String, dynamic> json) {
    return SheetModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'BasicModel{id: $id, title: $title, subtitle: $subtitle, image: $image}';
  }

  static List<SheetModel> countryExample = [
    SheetModel(id: 1, title: 'Egypt', subtitle: 'EG', image: ''),
    SheetModel(id: 2, title: 'United States', subtitle: 'US', image:   ''),
    SheetModel(id: 3, title: 'United Kingdom', subtitle: 'UK', image:   ''),
    SheetModel(id: 4, title: 'France', subtitle: 'FR', image:   ''),
    SheetModel(id: 5, title: 'Germany', subtitle: 'DE', image:   ''),
  ];
}
