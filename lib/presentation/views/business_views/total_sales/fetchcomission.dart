import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

fetchmycommission() async {
  final prefs = await SharedPreferences.getInstance();
  String sehercode = prefs.getString("sehrCode").toString();

  var token = prefs.get('accessToken');
  final uri =
      Uri.parse('http://3.133.0.29/api/business/by-sehr-code/$sehercode');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  var response = await http.get(uri, headers: headers);

  return response;
}
