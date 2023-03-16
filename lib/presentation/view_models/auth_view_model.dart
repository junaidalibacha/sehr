import 'package:flutter/foundation.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../routes/routes.dart';
import 'user_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  final loginUserNameFocusNode = FocusNode();
  final loginPasswordFocusNode = FocusNode();
  final loginUserNameController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final signupUserNameFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();
  final signUpPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final signupUserNameController = TextEditingController();
  final mobileNoTextController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool loginPassObscureText = true;
  bool signupPassObscureText = true;
  bool confirmPassObscureText = true;
  bool keepAuthData = false;

  void showLoginPass() {
    loginPassObscureText = !loginPassObscureText;
    notifyListeners();
  }

  void showSignupPass() {
    signupPassObscureText = !signupPassObscureText;
    notifyListeners();
  }

  void showSignupConfirmPass() {
    confirmPassObscureText = !confirmPassObscureText;
    notifyListeners();
  }

  // void keepAuth() {
  //   keepAuthData = keepAuthData.toggle();
  //   notifyListeners();
  // }

//==> User Login Method
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // final ApiResponseModel _apiResponse = ApiResponseModel();
  // Future<void> login(BuildContext context) async {
  //   if (userNameController.text.isEmpty && passwordController.text.isEmpty) {
  //     Utils.flushBarErrorMessage(context, 'Please Enter Your Email & Pasword');
  //   } else if (userNameController.text.isEmpty) {
  //     Utils.flushBarErrorMessage(context, 'Email is empty');
  //   } else if (passwordController.text.isEmpty) {
  //     Utils.flushBarErrorMessage(context, 'Password is empty');
  //   } else if (passwordController.text.length < 8) {
  //     Utils.flushBarErrorMessage(context, 'Password must be 8 charactors');
  //   } else {
  //     if (loginFormKey.currentState!.validate()) {
  //       loginFormKey.currentState!.save();
  //       _apiResponse = await authenticateUser(
  //         userNameController.text.toString(),
  //         passwordController.text.toString(),
  //       ).then((value) {
  //         print(value);
  //         return value;
  //       });
  //       if (_apiResponse.ApiError == null) {
  //         // ignore: use_build_context_synchronously
  //         Utils.toastMessage(context, 'Login Successfully');
  //       } else {
  //         // ignore: use_build_context_synchronously
  //         Utils.flushBarErrorMessage(
  //             context, (_apiResponse.ApiError as ApiErrorModel).message!);
  //         print((_apiResponse.ApiError as ApiErrorModel).message);
  //       }
  //     }
  //   }
  // }

  final _authRepo = AuthRepository();

//! ==> User Login Service
  Future<void> loginApi(BuildContext context) async {
    if (loginUserNameController.text.isEmpty &&
        loginPasswordController.text.isEmpty) {
      Utils.flushBarErrorMessage(context, 'Please Enter Your Email & Pasword');
    } else if (loginUserNameController.text.isEmpty) {
      Utils.flushBarErrorMessage(context, 'Email is empty');
    } else if (loginPasswordController.text.isEmpty) {
      Utils.flushBarErrorMessage(context, 'Password is empty');
    } else if (loginPasswordController.text.length < 8) {
      Utils.flushBarErrorMessage(context, 'Password must be 8 charactors');
    } else {
      Map<String, dynamic> loginData = {
        'username': loginUserNameController.text.trim(),
        'password': loginPasswordController.text.trim(),
      };
      setLoading(true);

      _authRepo.loginApi(loginData).then((value) {
        setLoading(false);

        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveUser(
          UserModel(accessToken: value['accessToken'].toString()),
        );

        Utils.flushBarErrorMessage(context, 'Login Successfully');
        Get.offAll(const DrawerView());
        if (kDebugMode) {
          print(value.toString());
        }
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.flushBarErrorMessage(context, error.toString());
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }
  }

  // Future<void> loginApi(BuildContext context) async {
  //   setLoading(true);
  // if (userNameController.text.isEmpty && passwordController.text.isEmpty) {
  //   Utils.flushBarErrorMessage(context, 'Please Enter Your Email & Pasword');
  // } else if (userNameController.text.isEmpty) {
  //   Utils.flushBarErrorMessage(context, 'Email is empty');
  // } else if (passwordController.text.isEmpty) {
  //   Utils.flushBarErrorMessage(context, 'Password is empty');
  // } else if (passwordController.text.length < 8) {
  //   Utils.flushBarErrorMessage(context, 'Password must be 8 charactors');
  // } else {
  // Map<String, dynamic> loginData = {
  //   'username': userNameController.text.trim(),
  //   'password': passwordController.text.trim(),
  // };
  //   _authRepo.loginApi(loginData).then((value) {
  //     setLoading(false);
  //     Utils.flushBarErrorMessage(context, 'Login Succesfully');
  //     if (kDebugMode) {
  //       print(value);
  //     }
  //   }).onError(
  //     (error, stackTrace) {
  //       setLoading(false);
  //       Utils.flushBarErrorMessage(
  //         context,
  //         error.toString(),
  //       );
  //       print(error.toString());
  //     },
  //   );
  //   // }
  // }

//! ==> Set User Sign-Up data to prefs
  Future<void> setSignUpDataToPrefs(BuildContext context) async {
    // if (userNameController.text.isEmpty &&
    //     emailController.text.isEmpty &&
    //     passwordController.text.isEmpty) {
    //   Utils.flushBarErrorMessage(
    //       context, 'Plaese fill all the required fields');
    // } else if (passwordController.text.length < 8) {
    //   Utils.flushBarErrorMessage(
    //       context, 'Password should be 8 characters minimum');
    if (!signUpFormKey.currentState!.validate()) {
      return;
    } else {
      _saveSignupDataAndGoNext();
    }
  }

  void _saveSignupDataAndGoNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', signupUserNameController.text.trim());
    prefs.setString('mobileNo', mobileNoTextController.text.trim());
    prefs.setString('password', signupPasswordController.text.trim());
    prefs.setString('re_password', confirmPasswordController.text.trim());
    // prefs.setBool('keepAuthData', keepAuthData);
    Get.toNamed(Routes.addCustomerBioRoute);
  }
}
