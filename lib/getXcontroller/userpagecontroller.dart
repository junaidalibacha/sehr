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
    getshops();

    super.onInit();
  }

  String internererror = "";

  userFavouriteBusiness() async {
    internererror = "";
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.get('accessToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await _networkApiService
          .getGetApiResponse(
        AppUrls.addToFavourite,
        headers: headers,
      )
          .catchError((e) {
        internererror = e.toString();
        return e;
      });
      if (internererror.isEmpty) {
        return response;
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  getshops() async {
    try {
      postloading.value = true;
      var result = await model.getBusiness().catchError((e) {
        internererror = e.toString();
        return e;
      });
      if (result != null) {
        business.assignAll(result);
      } else {}
      internererror = "";
      // ignore: body_might_complete_normally_catch_error
    } finally {
      postloading.value = false;
    }

    update();
  }

  //
  // getfavshops() async {
  //   try {
  //     for (var business in business) {
  //       for (var favBusiness in listOfUserFavouriteBusiness) {
  //         if (favBusiness.businessId == business.id) {
  //           business.isFavourite = true;
  //         }
  //       }
  //     }
  //     business.forEach((element) {
  //       if (element.isFavourite == true) {
  //         favBusinesses.assign(element);
  //       }
  //     });
  //   } finally {
  //     postloading2.value = false;
  //   }

  //   update();
  // }

  ///   add Business to Favourite

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
      return response;
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
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
