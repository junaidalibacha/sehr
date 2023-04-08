import 'package:http/http.dart' as http;

class BioApiCalls {
  educationApi() async {
    final uri = Uri.parse('http://3.133.0.29/api/education');
    final headers = {'accept': '*/*'};

    var response = await http.get(uri, headers: headers);

    return response;
  }

  provincesApi() async {
    final uri = Uri.parse('http://3.133.0.29/api/proviences');
    final headers = {'accept': '*/*'};

    var response = await http.get(uri, headers: headers);

    return response;
  }

  citiesapi() async {
    final uri = Uri.parse('http://3.133.0.29/api/cities');
    final headers = {'accept': '*/*'};

    var response = await http.get(uri, headers: headers);

    return response;
  }
}
