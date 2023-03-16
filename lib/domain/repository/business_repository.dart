import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../models/business_model.dart';
import 'app_urls.dart';

class BusinessRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<BusinessModel> postBusinessData(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.businessEndPoint, data);
      return response = BusinessModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
