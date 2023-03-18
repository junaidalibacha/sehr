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

  // Get List Of Business Api Hitting Place

  Future<List<BusinessModel>?> getBusiness() async {
    final prefs = await SharedPreferences.getInstance();
    List<BusinessModel>? business = [];
    var token = prefs.get('accessToken');
    // print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await _apiServices
          .getBusinessDetail(AppUrls.getBusinessEndPoint, headers: headers);

      response.forEach((busines) {
        print(">>>>objecct");
        business.add(BusinessModel.fromJson(busines));
      });

      print("Business length: ${business.length}");

      return business;
    } catch (e) {
      print("Error Occured: $e");
      rethrow;
    }
  }
}
