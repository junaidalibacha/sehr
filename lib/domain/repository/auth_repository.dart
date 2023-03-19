import 'package:sehr/data/network/base_api_services.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:http/http.dart';

import 'app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    print("hereeeeeeee");
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrls.loginEndPoint,
        data,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.registerEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerMultiPartApi(MultipartRequest request) async {
    try {
      dynamic response = await _apiServices.getPostMultiPartResponse(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
