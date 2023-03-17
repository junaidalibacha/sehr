import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/view_models/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/user_model.dart';
import '../../domain/repository/app_urls.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/education_repository.dart';
import '../routes/routes.dart';

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
      print('Education Options===>$_educationOptions');
      // EducationModel.fromJson(value);
      // notifyListeners();
    }).onError((error, stackTrace) {
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
    // prefs.setString('country', 'Pakistan');
  }

  final _authRepo = AuthRepository();

//! User Register PostApi
  Future<void> registerApi(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> registerData = {
      'firstName': prefs.getString('firstName')!,
      'lastName': prefs.getString('lastName')!,
      'username': prefs.getString('username')!,
      // 'email': prefs.getString('email')!,
      'email': '',
      'mobile': prefs.getString('mobileNo')!,
      'password': prefs.getString('password')!,
      're_password': prefs.getString('password')!,
      'gender': prefs.getString('gender')!,
      'dob': prefs.getString('dob')!,
      'cnic': prefs.getString('cnic'),
      'education': prefs.getString('education'),
      'address': prefs.getString('address'),
      'tehsil': prefs.getString('tehsil'),
      'district': prefs.getString('district'),
      'division': prefs.getString('division'),
      'province': prefs.getString('province'),
      'city': prefs.getString('city'),
      'country': 'Pakistan',
      'role': 'user',
    };

    // Map<String, dynamic> businessData = {
    //   'businessName': prefs.getString('businessName')!,
    //   'ownerName': prefs.getString('ownerName')!,
    //   // 'username': prefs.getString('username')!,
    //   'email': prefs.getString('email')!,
    //   'mobile': prefs.getString('mobileNo')!,
    //   'logoMedia': '',
    //   'sehrCode': '1234567890',
    //   'lat': '33.598362',
    //   'lon': '73.147408',
    //   'about': 'About Business',
    //   'address': addressTextController.text.trim(),
    //   'tehsil': _selectedTehsil,
    //   'district': _selectedDistrict,
    //   'division': _selectedDivision,
    //   'province': _selectedProvince,
    //   'city': _selectedCity,
    //   'country': 'Pakistan',
    //   'category': 1,
    //   'role': prefs.getString('userRole')!,
    // };

    print(registerData);
    setLoading(true);
    _authRepo.registerApi(registerData).then((value) {
      setLoading(false);

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(accessToken: value['token']),
      );

      Utils.flushBarErrorMessage(context, 'Register Successfully');
      // Navigator.pushNamed(context, RoutesName.home);
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

//! Register MultiPartApi
  Future<void> registerMultiPartApi(BuildContext context) async {
    setLoading(true);
    final prefs = await SharedPreferences.getInstance();

    var stream = File(_image!.path).readAsBytes().asStream();
    // File(_image!.path).readAsBytes().asStream();
    // stream.cast();

    int length = await File(_image!.path).length();

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

    http.MultipartFile multipartFile =
        http.MultipartFile('profileImage', stream, length);

    request.files.add(multipartFile);
    _authRepo.registerMultiPartApi(request).then((value) {
      setLoading(false);
      // Utils.flushBarErrorMessage(context, 'Register Successfully');
      Get.toNamed(Routes.drawerRoute);
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
  }
}
// }
