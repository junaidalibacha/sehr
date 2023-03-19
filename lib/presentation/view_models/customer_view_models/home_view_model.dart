import 'package:geolocator/geolocator.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/models/models.dart';
import 'package:sehr/domain/services/location_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/business_model.dart';
import '../../../domain/models/userFavouriteBusinessModel.dart';
import '../../../domain/repository/app_urls.dart';
import '../../../domain/repository/business_repository.dart';
import '../../src/index.dart';

String? address;
Position? position;

class HomeViewModel extends ChangeNotifier {
  BusinessRepository model = BusinessRepository();
  NetworkApiService _networkApiService = NetworkApiService();
  BusinessModel businessModel = BusinessModel();
  List<UserFavouriteBusiness> listOfUserFavouriteBusiness = [];

  List<BusinessModel>? business = [];

  HomeViewModel() {
    init();
  }

  init() async {
    await userFavouriteBusiness();
    await getShops();
    notifyListeners();
  }

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

  ///    Get List of Shops

  Future getShops() async {
    business = await model.getBusiness();
    business?.forEach((business) {
      listOfUserFavouriteBusiness.forEach((favBusiness) {
        if (favBusiness.businessId == business.id) {
          print("Trueeeeeeeeeee");
          business.isFavourite = true;
        }
      });
    });
    print("Business lengthlllll: ${business?.length}");
    //  notifyListeners();
  }

  /// Toggle Favourite

  void toggleFav(int index) async {
    print("Toggle Favourite");
    if (business![index].isFavourite!) {
      /// delete Favourite api

      await deleteFromFavourite(index);
      business![index].isFavourite = false;
    } else {
      // Favourite post api
      await addToFavourite(index);
      business![index].isFavourite = true;
    }

    notifyListeners();
  }

  ///   Add Business To Favourite

  Future addToFavourite(index) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {"businessId": business?[index].id};

    try {
      final response = await _networkApiService
          .getPostApiResponse(AppUrls.addToFavourite, body, headers: headers);

      print("Successfully Added To Favourite: ");
    } catch (e) {
      print("Error Occured: $e");
      rethrow;
    }
  }

  ///   Delete Business From Favourite

  Future deleteFromFavourite(index) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await _networkApiService.getDeletetApiResponse(
          AppUrls.addToFavourite + "/${business?[index].id}",
          headers: headers);

      print("Successfully Deleted From Favourite: ");
    } catch (e) {
      print("Error Occured: $e");
      rethrow;
    }
  }

  ///  Get user Favourite Business

  Future userFavouriteBusiness() async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await _networkApiService.getGetApiResponse(
        AppUrls.addToFavourite,
        headers: headers,
      );

      response.forEach((favBusiness) {
        listOfUserFavouriteBusiness
            .add(UserFavouriteBusiness.fromJson(favBusiness));
      });
    } catch (e) {
      print("Error Occured: $e");
      rethrow;
    }

    print("Favourite Business Length: ${listOfUserFavouriteBusiness.length}");
  }

  /// Get Business Detail when scan
  Future getBusinessOnScan(id) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await _networkApiService.getGetApiResponse(
          AppUrls.businessEndPoint + "/${id}",
          headers: headers);

      businessModel = BusinessModel.fromJson(response);
      print("Successfully Fetched: ${businessModel.businessName}");
    } catch (e) {
      print("Error Occured: $e");
      rethrow;
    }
  }
}
