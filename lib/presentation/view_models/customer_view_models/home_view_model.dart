import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/models.dart';

import '../../src/index.dart';

class HomeViewModel extends ChangeNotifier {
  final List<ShopDataModel> _shops = [
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 1',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 2',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 2',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 4',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 5',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 6',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 7',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 8',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
    ShopDataModel(
      shopImage: AppImages.menu,
      shopName: 'Shop Name 9',
      shopCategory: 'Category',
      shopDescription:
          'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
    ),
  ];

  List<ShopDataModel> get shops => [..._shops];
  void toggleFav(int index) async {
    shops[index].isFavourite = !shops[index].isFavourite;
    notifyListeners();
  }

  List<ShopDataModel> get favItems {
    // return _shops.where((element) => element.isFavourite).toList();
    return [
      ShopDataModel(
        shopImage: AppImages.menu,
        shopName: 'Shop Name 1',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
      ShopDataModel(
        shopImage: AppImages.menu,
        shopName: 'Shop Name 2',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
      ShopDataModel(
        shopImage: AppImages.menu,
        shopName: 'Shop Name 2',
        shopCategory: 'Category',
        shopDescription:
            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        isFavourite: true,
      ),
    ];
  }

  Set<String> selectedFilters = {};
  List<String> filterList = ['Filter 1', 'Filter 2', 'Filter 3'];

  void selectFilter(String value) {
    if (selectedFilters.contains(value)) {
      selectedFilters.remove(value);
    } else {
      selectedFilters.add(value);
    }
    notifyListeners();
    // print(selectedFilters);
  }

//  final filteredData = data.where((item) => selectedFilters.contains(item.filter)).toList();
}
