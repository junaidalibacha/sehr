import 'package:sehr/data/network/base_api_services.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/repository/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/education_model.dart';

class EducationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  List<EducationModel> educationList = [];

  Future<List<EducationModel>> getEducationApi() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.get('accessToken');
    print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrls.educationEndPoint, headers);
      for (Map<String, dynamic> i in response) {
        // print(response);
        educationList.add(EducationModel.fromJson(i));
        print(i['title']);
      }
      return educationList;
    } catch (e) {
      rethrow;
    }
  }
}
