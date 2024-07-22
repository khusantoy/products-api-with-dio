class Product {
  int id;
  String title;
  int price;
  String description;
  List<String> images;
  String creationAt;
  String updatedAt;
  Category category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      images: List<String>.from(map['images']),
      creationAt: map['creationAt'],
      updatedAt: map['updatedAt'],
      category: Category.fromMap(map['category']),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'description': description});
    result.addAll({'images': images});
    result.addAll({'creationAt': creationAt});
    result.addAll({'updatedAt': updatedAt});
    result.addAll({'category': category});

    return result;
  }
}

class Category {
  int id;
  String name;
  String image;
  String creationAt;
  String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      creationAt: map['creationAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }
}
