import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/drop_down_widget.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/top_back_button_widget.dart';
import '../../../src/index.dart';

class AddBusinessDetailsView extends StatelessWidget {
  const AddBusinessDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<AuthViewModel>(context);
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: SafeArea(
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
                    const TopBackButtonWidget(),
                    buildVerticleSpace(24),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(27),
                      ),
                      child: kTextBentonSansMed(
                        'Fill in your business\ndetail to get started',
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
                                controller:
                                    viewModel.businessNameTextController,
                                hintText: 'Business / Company',
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
                                hintText: 'Owner Name',
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
                              TextFieldWidget(
                                controller:
                                    viewModel.shopKeeperMobileNoTextController,
                                hintText: 'Mobile Number',
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mobile number is required';
                                  } else if (value.length < 11) {
                                    return 'Invalid mobile number';
                                  }
                                  return null;
                                },
                              ),
                              buildVerticleSpace(20),
                              DropDownWidget(
                                lableText: 'Category',
                                hintText: 'Select Category',
                                selectedOption:
                                    viewModel.selectedBusinessCategory,
                                dropdownMenuItems: viewModel.businessOptions
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem(
                                        value: value,
                                        child: kTextBentonSansReg(value),
                                      ),
                                    )
                                    .toList(),
                                onChange: (value) =>
                                    viewModel.setBusinessOption(value!),
                              ),
                              buildVerticleSpace(20),
                              DropDownWidget(
                                lableText: 'Grade',
                                hintText: 'Select Grade',
                                selectedOption: viewModel.selectedBusinessGrade,
                                dropdownMenuItems:
                                    viewModel.businessGradeOptions
                                        .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem(
                                            value: value,
                                            child: kTextBentonSansReg(value),
                                          ),
                                        )
                                        .toList(),
                                onChange: (value) =>
                                    viewModel.setBusinessGrade(value!),
                              ),
                              buildVerticleSpace(100),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(95),
                                ),
                                child: AppButtonWidget(
                                  ontap: () {
                                    viewModel
                                        .addBussinessDataAndGoNext(context);
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
      ),
    );
  }
}