import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:sehr/presentation/views/profile/add_bio/apicalling.dart';

import '../../common/app_button_widget.dart';
import '../../common/drop_down_widget.dart';
import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';
import 'dart:convert' as convert;

class SetLocationView extends StatefulWidget {
  // final File imageFile;
  const SetLocationView({
    super.key,
    // required this.imageFile,
  });

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  final BioApiCalls _orderApi = BioApiCalls();

  fetchorders() async {
    await citycall();
    await proviencecall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {
      filterlist.forEach((element) {
        print(element);
      });
    }

    setState(() {});
  }

  bool nodata = false;
  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  Future citycall() async {
    var responseofdata = await _orderApi.citiesapi();
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      filterlist.add(element);
    });

    return datatest;
  }

  //provience

  Map<String, dynamic>? provincetest;
  final List<dynamic> _list2 = [];
  List<dynamic> filterlist2 = [];
  Future proviencecall() async {
    var responseofdata = await _orderApi.provincesApi();
    provincetest = convert.jsonDecode(responseofdata.body);
    _list2.add(provincetest == null ? [] : provincetest!.values.toList());
    _list2[0][0].forEach((element) {
      filterlist2.add(element);
    });

    return provincetest;
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image.asset(
              AppImages.pattern2,
              color: ColorManager.primary.withOpacity(0.1),
            ),
            ChangeNotifierProvider<ProfileViewModel>(
              create: (context) => ProfileViewModel(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBackButtonWidget(),
                  buildVerticleSpace(20),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(27),
                    ),
                    child: kTextBentonSansMed(
                      'Set Your Location',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  buildVerticleSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(22),
                    ),
                    child: Container(
                      // height: getProportionateScreenHeight(287),
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(22),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.05),
                            blurRadius: getProportionateScreenHeight(15),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(11),
                              vertical: getProportionateScreenHeight(20),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppIcons.pinIcon,
                                  height: getProportionateScreenHeight(33),
                                  width: getProportionateScreenHeight(33),
                                ),
                                buildHorizontalSpace(14),
                                kTextBentonSansMed(
                                  'Address',
                                  fontSize: getProportionateScreenHeight(15),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(17),
                              right: getProportionateScreenWidth(8),
                            ),
                            child: Consumer<ProfileViewModel>(
                              builder: (context, viewModel, child) => Form(
                                key: viewModel.customerAddressFormKey,
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      controller:
                                          viewModel.addressTextController,
                                      hintText: 'Address',
                                      fillColor: ColorManager.lightGrey,
                                      blurRadius:
                                          getProportionateScreenHeight(3),
                                    ),
                                    buildVerticleSpace(12),
                                    DropDownWidget(
                                      bgColor: ColorManager.lightGrey,
                                      dropdownColor: ColorManager.white,
                                      blurRadius:
                                          getProportionateScreenHeight(3),
                                      lableText: 'Tehsil',
                                      hintText: 'Select Tehsil',
                                      selectedOption: viewModel.selectedTehsil,
                                      dropdownMenuItems: viewModel.tehsilOptions
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: kTextBentonSansReg(value),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (value) =>
                                          viewModel.setTehsil(value!),
                                    ),
                                    buildVerticleSpace(12),
                                    DropDownWidget(
                                      bgColor: ColorManager.lightGrey,
                                      dropdownColor: ColorManager.white,
                                      blurRadius:
                                          getProportionateScreenHeight(3),
                                      lableText: 'District',
                                      hintText: 'Select District',
                                      selectedOption:
                                          viewModel.selectedDistrict,
                                      dropdownMenuItems: viewModel
                                          .districtOptions
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: kTextBentonSansReg(value),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (value) =>
                                          viewModel.setDistrict(value!),
                                    ),
                                    buildVerticleSpace(12),
                                    DropDownWidget(
                                      bgColor: ColorManager.lightGrey,
                                      dropdownColor: ColorManager.white,
                                      blurRadius:
                                          getProportionateScreenHeight(3),
                                      lableText: 'Division',
                                      hintText: 'Select Division',
                                      selectedOption:
                                          viewModel.selectedDivision,
                                      dropdownMenuItems: viewModel
                                          .divisionOptions
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: kTextBentonSansReg(value),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (value) =>
                                          viewModel.setDivision(value!),
                                    ),
                                    buildVerticleSpace(12),
                                    DropDownWidget(
                                      bgColor: ColorManager.lightGrey,
                                      dropdownColor: ColorManager.white,
                                      blurRadius:
                                          getProportionateScreenHeight(3),
                                      lableText: 'City',
                                      hintText: 'Select Your City',
                                      selectedOption: viewModel.selectedCity,
                                      dropdownMenuItems: filterlist
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem(
                                              value: value["title"],
                                              child: kTextBentonSansReg(
                                                  value["title"]),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (value) =>
                                          viewModel.setCity(value!),
                                    ),
                                    buildVerticleSpace(12),
                                    DropDownWidget(
                                      bgColor: ColorManager.lightGrey,
                                      dropdownColor: ColorManager.white,
                                      blurRadius:
                                          getProportionateScreenHeight(3),
                                      lableText: 'Province',
                                      hintText: 'Select Your Province',
                                      selectedOption:
                                          viewModel.selectedProvince,
                                      dropdownMenuItems: filterlist2
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem(
                                              value: value["title"],
                                              child: kTextBentonSansReg(
                                                  value["title"]),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (value) =>
                                          viewModel.setProvince(value!),
                                    ),
                                    buildVerticleSpace(20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // buildVerticleSpace(50),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(118),
                    ),
                    child: Consumer<ProfileViewModel>(
                      builder: (context, value, child) => AppButtonWidget(
                        ontap: () {
                          // Get.toNamed(Routes.verificationCodeRoute);

                          // value.registerMultiPartApi(context);
                          value.addUserAddressAndGoNext(context);
                        },
                        text: 'Next',
                      ),
                    ),
                  ),
                  buildVerticleSpace(50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
