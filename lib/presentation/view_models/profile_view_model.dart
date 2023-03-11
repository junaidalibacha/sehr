import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../domain/repository/app_urls.dart';
import '../../domain/repository/auth_repository.dart';
import '../routes/routes.dart';

class ProfileViewModel extends ChangeNotifier {
  final _customerFormKey = GlobalKey<FormState>();
  final _businessFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get customerFormKey => _customerFormKey;
  GlobalKey<FormState> get businessFormKey => _businessFormKey;

  // Customer Bio Data
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final cnicNoTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final userMobNoTextController = TextEditingController();

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
    dobTextController.text = DateFormat('dd-MM-yyyy').format(date);
    notifyListeners();
  }

  Gender? _selectedGender;
  Gender? get selectedGender => _selectedGender;

  void setGender(Gender? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  final List<String> _educationOptions = [
    'High School',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'PhD',
  ];
  List<String> get educationOptions => _educationOptions;

  String? _selectedEducation;
  String? get selectedEducation => _selectedEducation;

  void setEducationOption(String option) {
    _selectedEducation = option;
    notifyListeners();
  }

  // Business Bio Data
  final businessNameTextController = TextEditingController();
  final ownerNameTextController = TextEditingController();
  final shopMobileNoTextController = TextEditingController();

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

//! void addBioDataToPref(){
  void addBioData(BuildContext context) async {
    if (!_customerFormKey.currentState!.validate()) {
      return;
    } else if (_selectedEducation == null) {
      Utils.flushBarErrorMessage(context, 'Please select education');
    } else {
      _saveBioToPrefsAndGoNext();
    }
  }

  void _saveBioToPrefsAndGoNext() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('profileType') == 'user') {
      prefs.setString('firstName', firstNameTextController.text.trim());
      prefs.setString('lastName', lastNameTextController.text.trim());
      prefs.setString('cnicNo', cnicNoTextController.text.trim());
      prefs.setString('education', _selectedEducation!);
      prefs.setString('dob', _selectedDate!.toIso8601String());
      prefs.setString('mobileNo', userMobNoTextController.text.trim());
      if (_selectedGender == Gender.male) {
        prefs.setString('gender', 'male');
      } else {
        prefs.setString('gender', 'female');
      }
    } else {
      prefs.setString('businessName', businessNameTextController.text.trim());
      prefs.setString('ownerName', ownerNameTextController.text.trim());
      prefs.setString('category', _selectedBusinessCategory!);
      prefs.setString('grad', _selectedBusinessGrade!);
    }
    // print(prefs.getString('gender'));
    Get.toNamed(Routes.photoSelectionRoute);
  }

  // void addPhotoToPrefs() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('photoUrl', _image);
  // }

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
  String? _imageString;
  String? get imageString => _imageString;

  Future<void> setImageFrom(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('image', base64Image);

      _image = File(pickedFile.path);
      _imageString = base64Image;
      print(_image);
      notifyListeners();
    }
  }

  Future<void> getImageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final image = prefs.getString('image');
    if (image != null) {
      _imageString = image;
      notifyListeners();
    }
  }

  String? _profileType;
  String? get profileType => _profileType;
  Future<void> getProfileTypeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final profile = prefs.getString('profileType');
    if (profile != null) {
      _profileType = profile;
      notifyListeners();
    }
    print(profileType);
  }

  void cancelProfileImage() {
    _image = null;
    notifyListeners();
  }

  // Set Location
  final addressTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final provinceTextController = TextEditingController();

  // final ApiResponseModel _apiResponse = ApiResponseModel();

  // void registerData() async {
  //   // if (loginFormKey.currentState!.validate()) {
  //   //   loginFormKey.currentState!.save();
  //   // try {
  //   //   print(userNameController.text.toString());
  //   //   print(passwordController.text.toString());
  //   //   var response = await post(
  //   //     Uri.parse("http://3.133.0.29/api/auth/login"),
  //   //     body: {
  //   // 'username': userNameController.text.toString(),
  //   // 'password': passwordController.text.toString(),
  //   //     },
  //   //   );

  //   //   if (response.statusCode == 201) {
  //   //     print('Successfull');
  //   //   } else if (response.statusCode == 500) {
  //   //     print('500 error accured');
  //   //   } else if (response.statusCode == 401) {
  //   //     print('500 error accured');
  //   //   } else {
  //   //     print('error accured');
  //   //   }
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  //   final prefs = await SharedPreferences.getInstance();
  //   _apiResponse = await registerUser(
  //     'name',
  //     'name',
  //     // nameTextController.text.trim(),

  //     prefs.getString('username')!,
  //     prefs.getString('email')!,
  //     shopMobileNoTextController.text.trim(),
  //     prefs.getString('password')!,
  //     prefs.getString('password')!,
  //     prefs.getString('gender')!,
  //     // dobTextController.text.trim(),
  //     '03444444444',
  //     prefs.getString('profileType')!,
  //     // profileImage,
  //   );
  //   if ((_apiResponse.ApiError) == null) {
  //     print('Success');
  //   } else {
  //     print('Error');
  //   }
  // }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final _authRepo = AuthRepository();

  // Future<void> registerApi(BuildContext context) async {
  //   // Map<String, String> headers = {
  //   //   'accept': '*/*',
  //   //   'Content-Type': 'multipart/form-data',
  //   // };
  //   // var formData = FormData({
  //   //   'image': [await MultipartFile.fromFile()]
  //   // });
  //   // if (!_customerFormKey.currentState!.validate()) {
  //   //   return;
  //   // } else if (_selectedEducation == null) {
  //   //   Utils.flushBarErrorMessage(context, 'Please select education');
  //   final prefs = await SharedPreferences.getInstance();

  //   Map<String, dynamic> registerData = {
  //     'firstName': prefs.getString('firstName')!,
  //     'lastName': prefs.getString('lastName')!,
  //     'username': prefs.getString('username')!,
  //     'email': prefs.getString('email')!,
  //     'mobile': prefs.getString('mobileNo')!,
  //     'password': prefs.getString('password')!,
  //     're_password': prefs.getString('password')!,
  //     'gender': prefs.getString('gender')!,
  //     'dob': prefs.getString('dob')!,
  //     'role': prefs.getString('profileType')!,
  //     // 'profileImage': ,
  //   };
  //   print(registerData);
  //   setLoading(true);
  //   _authRepo.signUpApi(registerData).then((value) {
  //     setLoading(false);

  //     // final userPreference = Provider.of<UserViewModel>(context, listen: false);
  //     // userPreference.saveUser(UserModel(token: value['token'].toString()));

  //     Utils.flushBarErrorMessage(context, 'Register Successfully');
  //     // Navigator.pushNamed(context, RoutesName.home);
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //   }).onError((error, stackTrace) {
  //     setLoading(false);
  //     Utils.flushBarErrorMessage(context, error.toString());
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }

  // void uploadImage() async {
  //   http.ByteStream stream = http.ByteStream(_image!.openRead());

  //   stream.cast();

  //   int lenght = await _image!.length();

  //   Uri url = Uri.parse('http://3.133.0.29/api/user/register');

  //   http.MultipartRequest request = http.MultipartRequest('POST', url);

  //   request.fields['firstName'] = 'firstName';

  //   http.MultipartFile multiPartFile =
  //       http.MultipartFile('profileImage', stream, lenght);
  //   request.files.add(multiPartFile);
  // }

  Future<void> registerMultiPartApi(BuildContext context) async {
    var imageFile;
    final prefs = await SharedPreferences.getInstance();
    String? selectedImage = prefs.getString('image');
    if (selectedImage != null) {
      Uint8List imageBytes = base64Decode(selectedImage);
      imageFile = imageFile.readAsBytes(imageBytes);
    }
    print(_image);
    http.ByteStream stream = http.ByteStream(imageFile!.openRead());
    stream.cast();

    int length = await _image!.length();

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.registerEndPoint));
    request.fields['firstName'] = prefs.getString('firstName')!;
    request.fields['lastName'] = prefs.getString('lastName')!;
    request.fields['username'] = prefs.getString('username')!;
    request.fields['email'] = prefs.getString('email')!;
    request.fields['mobile'] = prefs.getString('mobileNo')!;
    request.fields['password'] = prefs.getString('password')!;
    request.fields['re_password'] = prefs.getString('password')!;
    request.fields['gender'] = prefs.getString('gender')!;
    request.fields['dob'] = prefs.getString('dob')!;
    request.fields['role'] = prefs.getString('profileType')!;

    http.MultipartFile multipartFile =
        http.MultipartFile('profileImage', stream, length);
    request.files.add(multipartFile);
    _authRepo.signUpMultiPartApi(request).then((value) {
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
}
// }
