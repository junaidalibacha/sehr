import 'package:get/get.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/models/business_model.dart';
import 'package:sehr/domain/models/userFavouriteBusinessModel.dart';
import 'package:sehr/domain/repository/app_urls.dart';
import 'package:sehr/domain/repository/business_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  var business = <BusinessModel>[].obs;
  var filterbussiness = <BusinessModel>[].obs;
  var favBusinesses = <BusinessModel>[].obs;
  var listOfUserFavouriteBusiness = <UserFavouriteBusiness>[].obs;

  final NetworkApiService _networkApiService = NetworkApiService();

  var postloading = true.obs;
  var postloading2 = true.obs;
  BusinessRepository model = BusinessRepository();

  @override
  void onInit() {
    userFavouriteBusiness();
    fetchpromotions();

    super.onInit();
  }

  String internererror = "";

  userFavouriteBusiness() async {
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
      print("Error Occureddddd: $e");
      rethrow;
    }

    print("Favourite Business Length: ${listOfUserFavouriteBusiness.length}");
  }

  fetchpromotions() async {
    try {
      postloading.value = true;
      var result = await model.getBusiness().catchError((e) {
        internererror = e.toString();
        return e;
      });
      if (result != null) {
        business.assignAll(result);
        for (var business in business) {
          for (var favBusiness in listOfUserFavouriteBusiness) {
            if (favBusiness.businessId == business.id) {
              business.isFavourite = true;
            }
          }
        }

        var favBusinessess =
            business.where((business) => business.isFavourite == true).toList();
        favBusinesses.assignAll(favBusinessess);
      } else {}
      internererror = "";
      // ignore: body_might_complete_normally_catch_error
    } finally {
      postloading.value = false;
    }

    update();
  }

  //
  fetchpromotions2() async {
    try {} finally {
      postloading2.value = false;
    }

    update();
  }

  void toggleFav(int bussinessid, bool isfavourite) async {
    try {
      if (isfavourite != false) {
        await deleteFromFavourite(bussinessid);
        var data = business
            .where((element) =>
                element.id.toString().toLowerCase().trim() ==
                bussinessid.toString().toLowerCase().trim())
            .toList();
        data.first.isFavourite = true;
        business.removeWhere((element) =>
            element.id.toString().toLowerCase().trim() ==
            bussinessid.toString().toLowerCase().trim());
        business.add(data.first);
      } else {
        // Favourite post api
        await addToFavourite(bussinessid);
        var data = business
            .where((element) =>
                element.id.toString().toLowerCase().trim() ==
                bussinessid.toString().toLowerCase().trim())
            .toList();
        data.first.isFavourite = true;
        business.removeWhere((element) =>
            element.id.toString().toLowerCase().trim() ==
            bussinessid.toString().toLowerCase().trim());
        business.add(data.first);
      }
    } finally {}
    update();
  }

  Future addToFavourite(bussinessid) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {"businessId": bussinessid};

    try {
      final response = await _networkApiService
          .getPostApiResponse(AppUrls.addToFavourite, body, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  ///   Delete Business From Favourite

  Future deleteFromFavourite(bussinessid) async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await _networkApiService.getDeletetApiResponse(
        "${AppUrls.addToFavourite}/$bussinessid",
        headers: headers,
      );

      print("Successfully Deleted From Favourite: ");
    } catch (e) {
      print("Error Occured: $e");
      rethrow;
    }
  }
}
