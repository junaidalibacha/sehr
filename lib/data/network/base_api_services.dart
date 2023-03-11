import 'package:http/http.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, dynamic headers);

  Future<dynamic> getPostApiResponse(String url, dynamic data);

  Future<dynamic> getPostMultiPartResponse(MultipartRequest request);
}
