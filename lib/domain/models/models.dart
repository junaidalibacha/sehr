import 'package:sehr/app/index.dart';

class AuthDataModel {
  final String id;
  final String name;
  final String email;
  final String imgUrl;

  AuthDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imgUrl,
  });

  // factory AuthDataModel.fromJson(Map<String, dynamic> jsonData) {
  //   return AuthDataModel(
  //     id: jsonData['id'] ?? '',
  //     name: jsonData['name'] ?? '',
  //     email: jsonData['email'] ?? '',
  //     imgUrl: jsonData['imgUrl'] ?? '',
  //   );
  // }
}

class ShopDataModel extends ChangeNotifier {
  final String shopName;
  final String shopCategory;
  final String shopDescription;
  bool isFavourite;

  ShopDataModel({
    required this.shopName,
    required this.shopCategory,
    required this.shopDescription,
    this.isFavourite = false,
  });

  // void toggleFav() {
  //   isFavourite = !isFavourite;
  //   notifyListeners();
  // }

}

class CompleteOrdersModel {
  final String itemName;
  final String shopName;
  final double price;
  bool isFavourite;

  CompleteOrdersModel({
    required this.itemName,
    required this.shopName,
    required this.price,
    this.isFavourite = false,
  });
}

class RecentOrdersModel {
  final String customerName;
  final String shopName;
  final double price;
  bool isCompleted;

  RecentOrdersModel({
    required this.customerName,
    required this.shopName,
    required this.price,
    this.isCompleted = false,
  });
}

class RequestedOrdersModel {
  final String customerName;
  final String shopName;
  final double price;
  bool isAccept;
  bool isReject;

  RequestedOrdersModel({
    required this.customerName,
    required this.shopName,
    required this.price,
    this.isAccept = false,
    this.isReject = false,
  });
}
