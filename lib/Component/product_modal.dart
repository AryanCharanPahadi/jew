class Product {
  final int itemId;
  final String itemTitle;
  final String itemName;
  final String itemPrice;
  final String itemSize;
  final String itemDesc;
  final String itemImg;

  Product({
    required this.itemId,
    required this.itemTitle,
    required this.itemName,
    required this.itemPrice,
    required this.itemSize,
    required this.itemDesc,
    required this.itemImg,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': itemId,
      'item_name': itemName,
      'item_img': itemImg,
      'item_price': itemPrice,
      'item_size': itemSize,
      'item_desc': itemDesc,
      'item_title': itemTitle,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      itemId: json['id'],
      itemTitle: json['item_title'],
      itemName: json['item_name'],
      itemPrice: json['item_price'],
      itemSize: json['item_size'],
      itemDesc: json['item_desc'],
      itemImg: json['item_img'],
    );
  }
}
