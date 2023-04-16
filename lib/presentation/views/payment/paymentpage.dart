import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/common/drop_down_widget.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/src/assets_manager.dart';
import 'package:sehr/presentation/src/colors_manager.dart';
import 'package:sehr/presentation/src/size_config.dart';
import 'package:sehr/presentation/src/styles_manager.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/profile/add_bio/apicalling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final BioApiCalls _orderApi = BioApiCalls();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {}
    if (mounted) {
      setState(() {});
    }
  }

  bool nodata = false;

  Future apicall() async {
    var responseofdata =
        await _orderApi.adressdetailsApi("http://3.133.0.29/api/category");
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      print(element);
      filterlist.add(element);
    });

    return datatest;
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<AuthViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppImages.pattern2,
              color: ColorManager.primary.withOpacity(0.1),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(35),
                      left: getProportionateScreenWidth(25),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(15),
                      ),
                      child: Container(
                        height: getProportionateScreenHeight(45),
                        width: getProportionateScreenHeight(45),
                        decoration: BoxDecoration(
                          color: ColorManager.secondaryLight.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(15),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: ColorManager.icon,
                          size: getProportionateScreenHeight(22),
                        ),
                      ),
                    ),
                  ),
                  buildVerticleSpace(24),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(27),
                    ),
                    child: kTextBentonSansMed(
                      'Pay Commission To SEHER',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  buildVerticleSpace(34),
                  Consumer<ProfileViewModel>(
                    builder: (context, viewModel, child) => Form(
                      key: viewModel.businessFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(23),
                        ),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              controller: viewModel.businessNameTextController,
                              hintText: 'Paid at (date)',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Business/Company name is required';
                                } else if (value.length < 3) {
                                  return 'Invalid Business/Company name';
                                }
                                return null;
                              },
                            ),
                            buildVerticleSpace(20),
                            TextFieldWidget(
                              controller: viewModel.ownerNameTextController,
                              hintText: 'Amount',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Owner name is required';
                                } else if (value.length < 3) {
                                  return 'Invalid Owner name';
                                }
                                return null;
                              },
                            ),
                            buildVerticleSpace(20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenHeight(15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.black.withOpacity(0.1),
                                    blurRadius:
                                        getProportionateScreenHeight(15),
                                  ),
                                ],
                              ),
                              child: TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  errorStyle: TextStyleManager.regularTextStyle(
                                    fontSize: getProportionateScreenHeight(12),
                                    color: ColorManager.error,
                                  ),
                                  // errorText: null,
                                  filled: true,
                                  fillColor: ColorManager.white,
                                  hintText: 'Description',
                                  hintStyle: TextStyleManager.regularTextStyle(
                                    fontSize: getProportionateScreenHeight(14),
                                    color:
                                        ColorManager.textGrey.withOpacity(0.3),
                                  ),

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenHeight(15),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(20),
                                  ),
                                  // errorBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: ColorManager.error,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(
                                  //     getProportionateScreenHeight(15),
                                  //   ),
                                  // ),
                                  // constraints: BoxConstraints(
                                  //   maxHeight: getProportionateScreenHeight(60),
                                  // ),
                                ),
                              ),
                            ),
                            viewModel.image == null
                                ? Column(
                                    children: [
                                      buildVerticleSpace(10),
                                      _buildCard(
                                        icon: AppIcons.galleryIcon,
                                        label: 'From Gallery',
                                        ontap: () {
                                          viewModel.setImageFrom(
                                              ImageSource.gallery);
                                        },
                                      ),
                                      buildVerticleSpace(10),
                                      _buildCard(
                                        icon: AppIcons.cameraIcon,
                                        label: 'Take Photo',
                                        ontap: () {
                                          viewModel
                                              .setImageFrom(ImageSource.camera);
                                        },
                                      ),
                                    ],
                                  )
                                : _buildImagePreview(viewModel),
                            buildVerticleSpace(10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(95),
                              ),
                              child: AppButtonWidget(
                                ontap: () {
                                  viewModel.addBussinessDataAndGoNext(context);
                                  // Get.toNamed(Routes.photoSelectionRoute);
                                  // print(value.selectedProfileType);
                                },
                                text: 'Next',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String icon,
    required String label,
    void Function()? ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: getProportionateScreenHeight(129),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(15),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.05),
              blurRadius: getProportionateScreenHeight(15),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenHeight(50),
            ),
            buildVerticleSpace(9),
            kTextBentonSansMed(label),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(ProfileViewModel viewModel) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: getProportionateScreenHeight(30), top: 30),
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(200),
          width: getProportionateScreenWidth(250),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.file(
                height: getProportionateScreenHeight(260),
                width: getProportionateScreenWidth(250),
                File(viewModel.image!.path),
              ).image,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(18),
                    vertical: getProportionateScreenHeight(10),
                  ),
                  child: InkWell(
                    onTap: () => viewModel.cancelProfileImage(),
                    child: Image.asset(
                      AppIcons.closeIcon,
                      height: getProportionateScreenHeight(31),
                      width: getProportionateScreenHeight(31),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
