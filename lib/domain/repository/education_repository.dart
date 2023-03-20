import 'dart:developer';

import 'package:sehr/data/network/base_api_services.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/repository/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<void> getEducationApi() async {
    // List<EducationModel>? educationList = [];

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      Map<String, dynamic> response = await _apiServices
          .getGetApiResponse(AppUrls.educationEndPoint, headers: headers);
      // response.forEach((education) {
      //   educationList.add(EducationModel.fromJson(education));
      // });
      print('Education API response$response');
      log(response.toString());
      // return response = EducationModel.fromJson(response);
    } catch (e) {
      print('Education API error===>$e');
      log(e.toString());

      rethrow;
    }
  }
}
