class Product {
  Product({
    this.id,
    this.productId,
    this.productStatus,
    this.productQuantity,
    this.productWeight,
    this.brandId,
    this.status,
    this.productName,
    this.productImage,
    this.productImage1,
    this.productImage2,
    this.productImage3,
    this.productImage4,
    this.productImage5,
    this.productImage6,
    this.productCategoryId,
    this.productCategoryNm,
    this.productDescription,
    this.slPrice,
    this.mrpPrice,
  });

  String id;
  String productId;
  String productStatus;
  String productQuantity;
  String productWeight;
  String brandId;
  String status;
  String productName;
  String productImage;
  String productImage1;
  String productImage2;
  String productImage3;
  String productImage4;
  String productImage5;
  String productImage6;
  String productCategoryId;
  String productCategoryNm;
  String productDescription;
  String slPrice;
  String mrpPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["productId"],
        productStatus: json["productStatus"],
        productQuantity: json["productQuantity"],
        productWeight: json["productWeight"],
        brandId: json["brandId"],
        status: json["status"],
        productName: json["productName"],
        productImage: json["productImage1"],
        productImage1: json["productImage2"],
        productImage2: json["productImage3"],
        productImage3: json["productImage4"],
        productImage4: json["productImage5"],
        productImage5: json["productImage6"],
        productImage6: json["productImage7"],
        productCategoryId: json["productCategoryId"],
        productCategoryNm: json["productCategoryNM"],
        productDescription: json["productDescription"],
        slPrice: json["slPrice"],
        mrpPrice: json["mrpPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productStatus": productStatus,
        "productQuantity": productQuantity,
        "productWeight": productWeight,
        "brandId": brandId,
        "status": status,
        "productName": productName,
        "productImage": productImage,
        "productCategoryId": productCategoryId,
        "productCategoryNM": productCategoryNm,
        "productDescription": productDescription,
        "slPrice": slPrice,
        "mrpPrice": mrpPrice,
      };
}

// class Product {
//   String name;
//   int price;
//   int price1;
//   String type;
//   List<String> typeList;
//   int discount;
//   String description;
//   String ingredients;
//   List<String> images;
//   List<String> relatedproducts;
//   Product({
//     this.name,
//     this.price,
//     this.typeList,
//     this.price1,
//     this.type,
//     this.discount,
//     this.description,
//     this.ingredients,
//     this.images,
//     this.relatedproducts,
//   });
// }
