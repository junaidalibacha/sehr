import 'package:sehr/data/network/base_api_services.dart';
import 'package:sehr/data/network/network_api_services.dart';
import 'package:sehr/domain/models/education_model.dart';
import 'package:sehr/domain/repository/app_urls.dart';

class EducationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<EducationModel> getEducationApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrls.educationEndPoint,
        // headers: headers,
      );
      // print('Education API response' + response);
      return response;
    } catch (e) {
      // print('Education API error===>$e');
      rethrow;
    }
  }
}
