import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/api_error_model.dart';
import 'package:sehr/domain/models/api_response_model.dart';
import 'package:sehr/domain/services/http_services.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/routes.dart';

class AuthViewModel extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;
  bool keepAuthData = false;
  ProfileType? _selectedProfileType;
  ProfileType? get selectedProfileType => _selectedProfileType;

  void showPass() {
    showPassword = showPassword.toggle();
    notifyListeners();
  }

  void keepAuth() {
    keepAuthData = keepAuthData.toggle();
    notifyListeners();
  }

  Future<void> selectProfileType(ProfileType type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedProfileType = type;

    if (_selectedProfileType == ProfileType.customer) {
      prefs.setString('profileType', 'customer');
    }
    if (_selectedProfileType == ProfileType.business) {
      prefs.setString('profileType', 'business');
    } else {
      null;
    }
    notifyListeners();
  }

//==> User Login Method
  ApiResponseModel _apiResponse = ApiResponseModel();

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      _apiResponse = await authenticateUser(
        userNameController.text.toString(),
        passwordController.text.toString(),
      );
      if (_apiResponse.ApiError == null) {
        print('Success');
      } else {
        print((_apiResponse.ApiError as ApiErrorModel).message);
      }
    }
  }

//==> User Sign-Up Method
  Future<void> setSignUpDataToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', userNameController.text.trim());
    prefs.setString('email', emailController.text.trim());
    prefs.setString('password', passwordController.text.trim());
    prefs.setBool('keepAuthData', keepAuthData);
    Get.toNamed(Routes.profileSelectionRoute);
  }

  //   void _saveAndRedirectToHome() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // await prefs.setString("userId", (_apiResponse.Data as User).userId);
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, '/home', ModalRoute.withName('/home'),
  //       arguments: (_apiResponse.Data as User));
  // }
}
