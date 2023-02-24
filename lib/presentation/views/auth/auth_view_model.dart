import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sehr/app/index.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;
  bool keepAuthData = false;
  ProfileType? _selectedProfileType;
  ProfileType? get selectedProfileType => _selectedProfileType;

  void showPass() {
    showPassword = showPassword.revese();
    notifyListeners();
  }

  void keepAuth() {
    keepAuthData = keepAuthData.revese();
    notifyListeners();
  }

  void selectProfileType(ProfileType type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedProfileType = type;

    notifyListeners();
    if (_selectedProfileType == ProfileType.customer) {
      prefs.setString('profileType', 'customer');
    }
    if (_selectedProfileType == ProfileType.business) {
      prefs.setString('profileType', 'business');
    } else {
      null;
    }
    // print(selectedProfileType);
  }
//
// facebook auth
//

  final bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  AccessToken? _accessToken;

  AccessToken? get accessToken => _accessToken;

  Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  Future<void> facebookSignIn() async {
    // final prefs = await SharedPreferences.getInstance();

    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      // final response = await http.post(
      //   Uri.parse('https://your-rest-api.com/authenticate'),
      //   body: json.encode({
      //     'accessToken': _accessToken?.token,
      //   }),
      //   headers: {
      //     'Content-Type': 'application/json',
      //   },
      // );

      // if (response.statusCode == 200) {
      final userDataResponse = await http.get(
        Uri.parse(
            'https://graph.facebook.com/v12.0/me?fields=name,email,picture&access_token=${_accessToken?.token}'),
      );

      if (userDataResponse.statusCode == 200) {
        _userData = json.decode(userDataResponse.body);
        print(_userData);
      }

      //       _isAuthenticated = true;
      //     } else {
      //       _isAuthenticated = false;
      //     }
      //   } else {
      //     throw Exception('Sign in with Facebook was cancelled or failed.');
      //   }
      // } catch (error) {
      //   print('Error signing in with Facebook: $error');
      // }

      notifyListeners();
    }
  }
}

extension ShowPass on bool {
  bool revese() {
    return !this;
  }
}
