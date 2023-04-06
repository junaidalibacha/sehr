import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/radio_button_widget.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/drop_down_widget.dart';
import '../../../common/top_back_button_widget.dart';
import '../../../src/index.dart';

class AddCustomerBioView extends StatefulWidget {
  const AddCustomerBioView({super.key});

  @override
  State<AddCustomerBioView> createState() => _AddCustomerBioViewState();
}

class _AddCustomerBioViewState extends State<AddCustomerBioView> {
  ProfileViewModel profileViewModel = ProfileViewModel();
  @override
  void initState() {
    // profileViewModel.educationApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<AuthViewModel>(context);
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                AppImages.pattern2,
                color: ColorManager.primary.withOpacity(0.1),
              ),
              Consumer<ProfileViewModel>(
                builder: (context, viewModel, child) => SingleChildScrollView(
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
                          'Fill in your bio to get\nstarted',
                          fontSize: getProportionateScreenHeight(25),
                        ),
                      ),
                      buildVerticleSpace(52),
                      Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(27)),
                        child: kTextBentonSansMed(
                          'This data will be displayed in your\n\naccount profile for security',
                          fontSize: getProportionateScreenHeight(12),
                        ),
                      ),
                      buildVerticleSpace(8),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(23),
                        ),
                        child: Form(
                          key: viewModel.customerBioFormKey,
                          child: Column(
                            children: [
                              TextFieldWidget(
                                controller: viewModel.firstNameTextController,
                                hintText: 'First Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is required';
                                  }
                                  return null;
                                },
                              ),
                              buildVerticleSpace(20),
                              TextFieldWidget(
                                controller: viewModel.lastNameTextController,
                                hintText: 'Last Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is required';
                                  }
                                  return null;
                                },
                              ),
                              buildVerticleSpace(20),
                              TextFieldWidget(
                                controller: viewModel.cnicNoTextController,
                                keyboardType: TextInputType.number,
                                hintText: 'Cnic No',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'CNIC is required';
                                  } else if (value.length < 13) {
                                    return 'Invalid cnic number';
                                  }
                                  return null;
                                },
                              ),
                              buildVerticleSpace(20),
                              DropDownWidget(
                                lableText: 'Education',
                                hintText: 'Select Education',
                                selectedOption: viewModel.selectedEducation,
                                dropdownMenuItems: viewModel.educationOptions
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem(
                                        value: value,
                                        child: kTextBentonSansReg(value),
                                      ),
                                    )
                                    .toList(),
                                onChange: (value) =>
                                    viewModel.setEducationOption(value!),
                              ),
                              buildVerticleSpace(20),
                              TextFieldWidget(
                                controller: viewModel.dobTextController,
                                hintText: 'DOB',
                                sufixIcon: _buildCalenderWidget(context),
                              ),
                              // buildVerticleSpace(20),
                              // TextFieldWidget(
                              //   controller: viewModel.userMobNoTextController,
                              //   hintText: 'Mobile Number',
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Mobile number is required';
                              //     } else if (value.length < 11) {
                              //       return 'Invalid mobile number';
                              //     }
                              //     return null;
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(43),
                          vertical: getProportionateScreenHeight(16),
                        ),
                        child: kTextBentonSansReg('Gender'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(60),
                        ),
                        child: Row(
                          children: [
                            RadioButtonWidget(
                              value: 'male',
                              groupValue: viewModel.selectedGender,
                              text: 'Male',
                              onChanged: (value) => viewModel.setGender(value),
                            ),
                            buildHorizontalSpace(44),
                            RadioButtonWidget(
                              value: 'female',
                              groupValue: viewModel.selectedGender,
                              text: 'Female',
                              onChanged: (value) => viewModel.setGender(value),
                            ),
                          ],
                        ),
                      ),
                      buildVerticleSpace(18),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(118),
                        ),
                        child: AppButtonWidget(
                          ontap: () {
                            // Get.toNamed(Routes.photoSelectionRoute);
                            viewModel.addUserBioAndGoNext(context);
                          },
                          text: 'Next',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalenderWidget(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) => InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (picked != null) {
            viewModel.setDate(picked);
          }
        },
        child: Icon(
          Icons.calendar_month,
          size: getProportionateScreenHeight(18),
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
