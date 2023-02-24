import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/models.dart';

class HomeViewModel extends ChangeNotifier {
  final List<ShopDataModel> _shops = [
    ShopDataModel(
      shopName: 'Shop Name 1',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 2',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 2',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 4',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 5',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 6',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 7',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 8',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopName: 'Shop Name 9',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
  ];

  List<ShopDataModel> get shops => [..._shops];
  // bool isFavourite = false;
  void toggleFav(int index) async {
    shops[index].isFavourite = !shops[index].isFavourite;
    notifyListeners();
  }

  List<ShopDataModel> get favItems {
    // return _shops.where((element) => element.isFavourite).toList();
    return [
      ShopDataModel(
        shopName: 'Shop Name 1',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
      ShopDataModel(
        shopName: 'Shop Name 2',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
      ShopDataModel(
        shopName: 'Shop Name 2',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
    ];
  }
}
