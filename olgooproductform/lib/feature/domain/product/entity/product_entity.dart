
class ProductEntity {
  final int id;
  final int price;
  final String title;
  final String status;
  final String type;
  final DateTime? registerDate;
  final String imgPath;

  ProductEntity({
    required this.id,
    required this.price,
    required this.imgPath,
    required this.title,
    required this.status,
    required this.type,
    this.registerDate,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      price: json['price'],
      title: json['title'],

      status: json['status'],
      imgPath: json['imgPath'],
      type: json['type'],
      registerDate: DateTime.parse(json['registerDate']),
      
    
    );
  }

}


class Category {
  final int id;
  final String title;
  final bool isCustom;

  Category({
    required this.id,
    required this.title,
    required this.isCustom,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      isCustom: json['isCustom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCustom': isCustom,
    };
  }
}
class TempProduct {
  String title;
  String description;
  String imgPath;
  int minOrder;
  int price;

  TempProduct({
    this.title = '',
    this.description = '',
    this.imgPath = '',
    this.minOrder = 0,
    this.price = 0,
  });
}
