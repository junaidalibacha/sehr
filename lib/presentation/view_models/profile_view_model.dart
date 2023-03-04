import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/domain/services/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/api_response_model.dart';
import '../routes/routes.dart';

class ProfileViewModel extends ChangeNotifier {
  // Customer Bio Data
  final nameTextController = TextEditingController();
  final cnicNoTextController = TextEditingController();
  final dobTextController = TextEditingController();

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
  final mobileNoTextController = TextEditingController();

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

  // void addBioDataToPref(){

  // }
  void addBioDataToPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('profileType') == 'customer') {
      prefs.setString('fullName', nameTextController.text.trim());
      prefs.setString('cnicNo', cnicNoTextController.text.trim());
      prefs.setString('dob', dobTextController.text.trim());
      prefs.setString('education', _selectedEducation!);
      prefs.setString('mobileNo', mobileNoTextController.text.trim());
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

  Future<void> setImageFrom(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      // final bytes = await pickedFile.readAsBytes();
      // final base64Image = base64Encode(bytes);

      // final prefs = await SharedPreferences.getInstance();
      // await prefs.set('image', pickedFile);

      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  // Future<void> getImageFromPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final image = prefs.getString('image');
  //   if (image != null) {
  //     _image = image;
  //     notifyListeners();
  //   }
  // }

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

  ApiResponseModel _apiResponse = ApiResponseModel();

  void registerData() async {
    // if (loginFormKey.currentState!.validate()) {
    //   loginFormKey.currentState!.save();
    // try {
    //   print(userNameController.text.toString());
    //   print(passwordController.text.toString());
    //   var response = await post(
    //     Uri.parse("http://3.133.0.29/api/auth/login"),
    //     body: {
    // 'username': userNameController.text.toString(),
    // 'password': passwordController.text.toString(),
    //     },
    //   );

    //   if (response.statusCode == 201) {
    //     print('Successfull');
    //   } else if (response.statusCode == 500) {
    //     print('500 error accured');
    //   } else if (response.statusCode == 401) {
    //     print('500 error accured');
    //   } else {
    //     print('error accured');
    //   }
    // } catch (e) {
    //   print(e);
    // }
    final prefs = await SharedPreferences.getInstance();
    _apiResponse = await registerUser(
      'name',
      'name',
      // nameTextController.text.trim(),

      prefs.getString('username')!,
      prefs.getString('email')!,
      mobileNoTextController.text.trim(),
      prefs.getString('password')!,
      prefs.getString('password')!,
      prefs.getString('gender')!,
      // dobTextController.text.trim(),
      '03444444444',
      prefs.getString('profileType')!,
      // profileImage,
    );
    if ((_apiResponse.ApiError) == null) {
      print('Success');
    } else {
      print('Error');
    }
  }
}
