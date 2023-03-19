import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';
import 'package:sehr/presentation/view_models/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/network/network_api_services.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repository/app_urls.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/education_repository.dart';
import '../../domain/services/location_services.dart';
import '../routes/routes.dart';
import '../views/drawer/custom_drawer.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'customer_view_models/home_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
// //! Select User Role
//   String? _selectedUserRole;
//   String? get selectedUserRole => _selectedUserRole;

  // Future<void> selectUserRole(String userRole) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _selectedUserRole = userRole;
  //   prefs.setString('userRole', userRole);
  //   notifyListeners();
  // }

//! Fill User Bio
  final _customerBioFormKey = GlobalKey<FormState>();
  final _customerAddressFormKey = GlobalKey<FormState>();
  final _businessFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get customerAddressFormKey => _customerAddressFormKey;
  GlobalKey<FormState> get customerBioFormKey => _customerBioFormKey;
  GlobalKey<FormState> get businessFormKey => _businessFormKey;

  // Customer Bio Data
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final cnicNoTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final otpController = TextEditingController();
  // final userMobNoTextController = TextEditingController();

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
    dobTextController.text = DateFormat('dd-MM-yyyy').format(date);
    notifyListeners();
  }

  String? _selectedGender;
  String? get selectedGender => _selectedGender;

  void setGender(String? gender) {
    _selectedGender = gender;
    print(_selectedGender);
    notifyListeners();
  }

  final List<String> _educationOptions = [
    'Bachelor',
    'Intermediate',
    'Matric',
  ];
  List<String> get educationOptions => _educationOptions;
  //
//! Get Education API
  final _educationRepo = EducationRepository();
  Future<void> educationApi() async {
    await _educationRepo.getEducationApi().then((value) {
      //
      print(value);
      //
    }).onError((error, stackTrace) {
      // Utils.flushBarErrorMessage(context, error.toString());
      print("Error==> $error");
    });

    // http.Response response =
    //     await http.get(Uri.parse('http://3.133.0.29/api/education'));
    // if (response.statusCode == 200) {
    //   try {
    //     print(jsonDecode(response.body));
    //     return Education.fromJson(jsonDecode(response.body));
    //   } catch (e) {
    //     print(e);
    //   }
    // }
  }

  String? _selectedEducation;
  String? get selectedEducation => _selectedEducation;

  void setEducationOption(String option) {
    _selectedEducation = option;
    notifyListeners();
  }

  final NetworkApiService _networkApiService = NetworkApiService();
  // Business Bio Data
  final businessNameTextController = TextEditingController();
  final ownerNameTextController = TextEditingController();
  final shopKeeperMobileNoTextController = TextEditingController();

  final List<String> _businessOptions = [
    'Cloth House',
    'Cosmetics Store',
    'Utility Store',
  ];
  List<String> get businessOptions => _businessOptions;

  String? _selectedBusinessCategory;
  String? get selectedBusinessCategory => _selectedBusinessCategory;

  void setBusinessOption(String option) {
    _selectedBusinessCategory = option;
    notifyListeners();
  }

  final List<String> _businessGradeOptions = ['A', 'B', 'C'];
  List<String> get businessGradeOptions => _businessGradeOptions;

  String? _selectedBusinessGrade;
  String? get selectedBusinessGrade => _selectedBusinessGrade;

  void setBusinessGrade(String grade) {
    _selectedBusinessGrade = grade;
    notifyListeners();
  }

  final List<String> _cityOptions = ['City1', 'City2', 'City3'];
  List<String> get cityOptions => _cityOptions;

  String? _selectedCity;
  String? get selectedCity => _selectedCity;

  void setCity(String city) {
    _selectedCity = city;
    notifyListeners();
  }

  final List<String> _tehsilOptions = ['Tehsil1', 'Tehsil2', 'Tehsil3'];
  List<String> get tehsilOptions => _tehsilOptions;

  String? _selectedTehsil;
  String? get selectedTehsil => _selectedTehsil;

  void setTehsil(String tehsil) {
    _selectedTehsil = tehsil;
    notifyListeners();
  }

  final List<String> _districtOptions = ['District1', 'District2', 'District3'];
  List<String> get districtOptions => _districtOptions;

  String? _selectedDistrict;
  String? get selectedDistrict => _selectedDistrict;

  void setDistrict(String district) {
    _selectedDistrict = district;
    notifyListeners();
  }

  final List<String> _divisionOptions = ['Division1', 'Division2', 'Division3'];
  List<String> get divisionOptions => _divisionOptions;

  String? _selectedDivision;
  String? get selectedDivision => _selectedDivision;

  void setDivision(String devision) {
    _selectedDivision = devision;
    notifyListeners();
  }

  final List<String> _provinceOptions = [
    'KPK',
    'Panjab',
    'Sindh',
    'Balochistan',
  ];
  List<String> get provinceOptions => _provinceOptions;

  String? _selectedProvince;
  String? get selectedProvince => _selectedProvince;

  void setProvince(String province) {
    _selectedProvince = province;
    notifyListeners();
  }

  // Upload Profile Photo
  File? _image;
  File? get image => _image;
  // String? _imageString;
  // String? get imageString => _imageString;

  Future<void> setImageFrom(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 20,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('image', base64Image);

      // _imageString = base64Image;
      print(_image);
      notifyListeners();
    }
  }

  // Future<void> getImageFromPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final image = prefs.getString('image');
  //   if (image != null) {
  //     _imageString = image;
  //     notifyListeners();
  //   }
  // }

  void cancelProfileImage() {
    _image = null;
    notifyListeners();
  }

  // Set Location
  final addressTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final provinceTextController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//!  add Bio Data to Prefs
  void addUserBioAndGoNext(BuildContext context) async {
    if (!_customerBioFormKey.currentState!.validate()) {
      return;
    } else if (_selectedEducation == null) {
      Utils.flushBarErrorMessage(context, 'Please select Your Education');
    } else if (_selectedGender == null) {
      Utils.flushBarErrorMessage(context, 'Please select Your Gender');
    } else {
      // _saveBioToPrefsAndGoNext();
      _saveUserBioToPrefs();
      Get.toNamed(Routes.setLocationRoute);
    }
  }

  void _saveUserBioToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('firstName', firstNameTextController.text.trim());
    prefs.setString('lastName', lastNameTextController.text.trim());
    prefs.setString('cnic', cnicNoTextController.text.trim());
    prefs.setString('education', _selectedEducation!);
    prefs.setString('dob', _selectedDate!.toIso8601String());
    // prefs.setString('email', userMobNoTextController.text.trim());
    prefs.setString('gender', _selectedGender!);
  }

//!  add User_Address to Prefs
  void addUserAddressAndGoNext(BuildContext context) async {
    if (!_customerAddressFormKey.currentState!.validate()) {
      return;
    } else if (_selectedTehsil == null) {
      Utils.flushBarErrorMessage(context, 'Please select Tehsil');
    } else if (_selectedDistrict == null) {
      Utils.flushBarErrorMessage(context, 'Please select District');
    } else if (_selectedDivision == null) {
      Utils.flushBarErrorMessage(context, 'Please select Division');
    } else if (_selectedProvince == null) {
      Utils.flushBarErrorMessage(context, 'Please select Province');
    } else {
      _saveUserAddressToPrefs();

      Get.toNamed(Routes.photoSelectionRoute);
    }
  }

  void _saveUserAddressToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('address', addressTextController.text.trim());
    prefs.setString('tehsil', _selectedTehsil!);
    prefs.setString('district', _selectedDistrict!);
    prefs.setString('division', _selectedDivision!);
    prefs.setString('province', _selectedProvince!);
    prefs.setString('city', _selectedCity!);
    prefs.setString('isBusiness', 'no');
    // prefs.setString('country', 'Pakistan');
  }

  final _authRepo = AuthRepository();

// //! User Register PostApi
//   Future<void> registerApi(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();

//     Map<String, dynamic> registerData = {
//       'firstName': prefs.getString('firstName')!,
//       'lastName': prefs.getString('lastName')!,
//       'username': prefs.getString('username')!,
//       // 'email': prefs.getString('email')!,
//       'email': '',
//       'mobile': prefs.getString('mobileNo')!,
//       'password': prefs.getString('password')!,
//       're_password': prefs.getString('password')!,
//       'gender': prefs.getString('gender')!,
//       'dob': prefs.getString('dob')!,
//       'cnic': prefs.getString('cnic'),
//       'education': prefs.getString('education'),
//       'address': prefs.getString('address'),
//       'tehsil': prefs.getString('tehsil'),
//       'district': prefs.getString('district'),
//       'division': prefs.getString('division'),
//       'province': prefs.getString('province'),
//       'city': prefs.getString('city'),
//       'country': 'Pakistan',
//       'role': 'user',
//     };

//     print(registerData);
//     setLoading(true);
//     _authRepo.registerApi(registerData).then((value) {
//       setLoading(false);

  // final userPreference = Provider.of<UserViewModel>(context, listen: false);
  // userPreference.saveUser(
  //   UserModel(accessToken: value['token']),
  // );

  // Utils.flushBarErrorMessage(context, 'Register Successfully');
//       // Navigator.pushNamed(context, RoutesName.home);
//       if (kDebugMode) {
//         print(value.toString());
//       }
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       Utils.flushBarErrorMessage(context, error.toString());
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }

//! Register MultiPartApi
  Future<void> registerMultiPartApi(BuildContext context) async {
    setLoading(true);
    final prefs = await SharedPreferences.getInstance();

    var stream = File(_image!.path).readAsBytes().asStream();
    // File(_image!.path).readAsBytes().asStream();
    // stream.cast();

    int length = await File(_image!.path).length();
    List<int> fileBytes = await File(_image!.path).readAsBytes();
    String base64Image = base64Encode(fileBytes);
    print(prefs.getString('gender')!);
    print(stream);
    print(length);

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.registerEndPoint));

    request.fields['firstName'] = prefs.getString('firstName')!;
    request.fields['lastName'] = prefs.getString('lastName')!;
    request.fields['username'] = prefs.getString('username')!;
    request.fields['email'] =
        ('${prefs.getString('firstName')!}${prefs.getString('password')!}${prefs.getString('mobileNo')!}@email.com');
    // request.fields['email'] = 'email@testmultipartapi2.com';
    request.fields['mobile'] = prefs.getString('mobileNo')!;
    request.fields['password'] = prefs.getString('password')!;
    request.fields['re_password'] = prefs.getString('re_password')!;
    // request.fields['gender'] = prefs.getString('gender')!;
    request.fields['gender'] = 'male';
    request.fields['dob'] = prefs.getString('dob')!;
    request.fields['cnic'] = prefs.getString('cnic')!;
    request.fields['education'] = prefs.getString('education')!;
    request.fields['address'] = prefs.getString('address')!;
    request.fields['tehsil'] = prefs.getString('tehsil')!;
    request.fields['district'] = prefs.getString('district')!;
    request.fields['division'] = prefs.getString('division')!;
    request.fields['province'] = prefs.getString('province')!;
    request.fields['city'] = prefs.getString('city')!;
    request.fields['country'] = 'Pakistan';
    request.fields['role'] = 'user';

    var profileImage = http.MultipartFile.fromString(
      'profileImage',
      base64.encode(base64Image.codeUnits),
      filename: _image?.path.split("/").last,
    );

    request.files.add(profileImage);
    await _authRepo.registerMultiPartApi(request).then((value) {
      setLoading(false);

      Utils.flushBarErrorMessage(context, 'Register Successfully');
      Get.toNamed(Routes.verificationCodeRoute);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(context, error.toString());
      if (kDebugMode) {
        print("MultiPart API Error=============> $error");
      }
    });
  }

//!  add Bussiness Data
  void addBussinessDataAndGoNext(BuildContext context) async {
    if (!_businessFormKey.currentState!.validate()) {
      return;
    } else if (_selectedBusinessCategory == null &&
        _selectedBusinessGrade == null) {
      Utils.flushBarErrorMessage(context, 'Please select Category & Grade');
    } else if (_selectedBusinessCategory == null) {
      Utils.flushBarErrorMessage(context, 'Please select Category');
    } else if (_selectedBusinessGrade == null) {
      Utils.flushBarErrorMessage(context, 'Please select Grade');
    } else {
      _saveBussinessDetailsToPrefs();
      Get.toNamed(Routes.photoSelectionRoute);
    }
  }

  void _saveBussinessDetailsToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('businessName', businessNameTextController.text.trim());
    prefs.setString('ownerName', ownerNameTextController.text.trim());
    prefs.setString('mobileNo', shopKeeperMobileNoTextController.text.trim());
    prefs.setString('category', _selectedBusinessCategory!);
    prefs.setString('grade', _selectedBusinessGrade!);
    prefs.setString('isBusiness', 'yes');
  }

  /// Register Business

  Future registerBusiness(context) async {
    print("called");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> fileBytes = await File(_image!.path).readAsBytes();
    String base64Image = base64Encode(
        fileBytes); //// Encode the bytes as a base64-encoded string
    var token = prefs.get('accessToken');

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.businessEndPoint));
    request.headers.addAll({
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });
    print(
        "businessName:${businessNameTextController.text} owner name ${ownerNameTextController.text}, mobile no: ${shopKeeperMobileNoTextController.text}");
    int grade = 1;
    int category = 1;
    request.fields['businessName'] = businessNameTextController.text;
    request.fields['ownerName'] = ownerNameTextController.text;

    request.fields['mobile'] = shopKeeperMobileNoTextController.text;

    request.fields['address'] = "deom address";
    request.fields['tehsil'] = "deom tehsil";
    request.fields['district'] = "deom division";
    request.fields['division'] = "deom district";
    request.fields['province'] = "deom province";
    request.fields['city'] = "demo city";
    request.fields['country'] = "Pakistan";
    request.fields['category'] = "$category";
    request.fields['grade'] = '$grade';
    request.fields['email'] = appUser.email.toString();
    request.fields['lat'] = "33.597524";
    request.fields['lon'] = "73.143872";

    var logoMediaFile = http.MultipartFile.fromString(
      'logoMedia',
      base64.encode(base64Image.codeUnits),
      filename: _image?.path.split("/").last,
    );

    request.files.add(logoMediaFile);

    await _authRepo.registerMultiPartApi(request).then((value) {
      setLoading(false);

      Utils.flushBarErrorMessage(context, 'Register Successfully');
      // Get.toNamed(Routes.verificationCodeRoute);
      Get.to(const DrawerView());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(context, error.toString());
      if (kDebugMode) {
        print("MultiPart API Error=============> $error");
      }
    });
  }

  init() async {
    position = await LocationServices.myLoction();
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );

      address =
          ("${placemarks.last.locality.toString()} ${placemarks.last.administrativeArea.toString().trim()} ${placemarks.last.name.toString()}");
      print("Address: $address");
    } catch (e) {
      print("give me error ${e.toString()}");
    }

    notifyListeners();
  }

  /// Verify Phone Number Through Otp
  Future verifyPhoneNo(context) async {
    setLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _networkApiService
        .getGetApiResponse(
      "${AppUrls.verifyPhoneNo}?mobile=${prefs.getString('mobileNo')}&otp=123456",
    )
        .then((value) async {
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(accessToken: value['accessToken'].toString()),
      );

      Utils.flushBarErrorMessage(context, 'Login Successfully');
      await init();
      setLoading(false);

      Get.offAll(const DrawerView());
    });
  }

//! OTP verification
  // final otpController = TextEditingController();
  // Future<void> verifyOtp(BuildContext context) async {
  //   if (otpController.text.isEmpty && otpController.text.isEmpty) {
  //     Utils.flushBarErrorMessage(context, 'Please Enter Your Email & Pasword');
  //   }
  //   else _authRepo.
  // }
}
// }
