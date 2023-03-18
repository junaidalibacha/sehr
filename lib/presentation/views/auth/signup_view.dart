import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/logo_widget.dart';

import '../../common/app_button_widget.dart';
import '../../common/text_field_widget.dart';
import '../../src/index.dart';
import '../../utils/utils.dart';
import '../../view_models/auth_view_model.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(34),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // buildVerticleSpace(20),
              const Spacer(),
              Column(
                children: [
                  const LogoWidget(),
                  buildVerticleSpace(30),
                ],
              ),
              kTextBentonSansBold(
                'Sign Up',
                fontSize: getProportionateScreenHeight(20),
              ),
              buildVerticleSpace(20),
              Form(
                key: viewModel.signUpFormKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: viewModel.signupUserNameController,
                      focusNode: viewModel.signupUserNameFocusNode,
                      keyboardType: TextInputType.name,
                      hintText: 'username',
                      prefixIcon: Icon(
                        Icons.person_rounded,
                        size: getProportionateScreenHeight(18),
                        color: ColorManager.primaryLight,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'username is required';
                        }
                        return null;
                      },
                      onFieldSubmit: (value) {
                        Utils.fieldFocusChange(
                          context,
                          viewModel.signupUserNameFocusNode,
                          viewModel.mobileFocusNode,
                        );
                      },
                    ),
                    buildVerticleSpace(12),
                    TextFieldWidget(
                      controller: viewModel.mobileNoTextController,
                      focusNode: viewModel.mobileFocusNode,
                      keyboardType: TextInputType.number,
                      hintText: 'Mobile',
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        size: getProportionateScreenHeight(18),
                        color: ColorManager.primaryLight,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mobile No is required';
                        } else if (value.length < 11) {
                          return 'Invalid mobile number';
                        }
                        return null;
                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Mobile No is required';
                      //   }
                      //   if (!RegExp(
                      //           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      //       .hasMatch(value)) {
                      //     return "Please enter a valid email address";
                      //   }
                      //   return null;
                      // },
                      onFieldSubmit: (value) {
                        Utils.fieldFocusChange(
                          context,
                          viewModel.mobileFocusNode,
                          viewModel.signUpPasswordFocusNode,
                        );
                      },
                    ),
                    buildVerticleSpace(12),
                    TextFieldWidget(
                      controller: viewModel.signupPasswordController,
                      focusNode: viewModel.signUpPasswordFocusNode,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      obscureText: viewModel.signupPassObscureText,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        size: getProportionateScreenHeight(18),
                        color: ColorManager.primaryLight,
                      ),
                      sufixIcon: IconButton(
                        splashRadius: 1,
                        onPressed: () => viewModel.showSignupPass(),
                        icon: Icon(
                          viewModel.signupPassObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: getProportionateScreenHeight(20),
                          color: ColorManager.textGrey.withOpacity(0.6),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 8) {
                          return 'Password should be 8 charators minimum';
                        }
                        return null;
                      },
                      onFieldSubmit: (value) {
                        Utils.fieldFocusChange(
                          context,
                          viewModel.signUpPasswordFocusNode,
                          viewModel.confirmPasswordFocusNode,
                        );
                      },
                    ),
                    buildVerticleSpace(12),
                    TextFieldWidget(
                      controller: viewModel.confirmPasswordController,
                      focusNode: viewModel.confirmPasswordFocusNode,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Confirm Password',
                      obscureText: viewModel.confirmPassObscureText,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        size: getProportionateScreenHeight(18),
                        color: ColorManager.primaryLight,
                      ),
                      sufixIcon: IconButton(
                        splashRadius: 1,
                        onPressed: () => viewModel.showSignupConfirmPass(),
                        icon: Icon(
                          viewModel.confirmPassObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: getProportionateScreenHeight(20),
                          color: ColorManager.textGrey.withOpacity(0.6),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required';
                        } else if (value !=
                            viewModel.signupPasswordController.text) {
                          return 'Password did\'t match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              // buildVerticleSpace(20),
              // _buildKeepMeSignIn(viewModel),
              // buildVerticleSpace(70),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(75),
                ),
                child: AppButtonWidget(
                  ontap: () {
                    viewModel.setSignUpDataToPrefs(context);
                    // viewModel.signUp();
                  },
                  text: 'Create Account',
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: kTextBentonSansMed(
                  'Already have an account?',
                  color: ColorManager.primary,
                  fontSize: getProportionateScreenHeight(12),
                  textDecoration: TextDecoration.underline,
                ),
              ),
              buildVerticleSpace(50),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildKeepMeSignIn(AuthViewModel viewModel) {
  //   return Row(
  //     children: [
  //       InkWell(
  //         onTap: () => viewModel.keepAuth(),
  //         child: Container(
  //           height: getProportionateScreenHeight(22),
  //           width: getProportionateScreenHeight(22),
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             gradient: LinearGradient(colors: [
  //               ColorManager.gradient1,
  //               ColorManager.gradient2,
  //             ]),
  //           ),
  //           child: viewModel.keepAuthData
  //               ? Icon(
  //                   Icons.check_rounded,
  //                   size: getProportionateScreenHeight(15),
  //                   color: ColorManager.white,
  //                 )
  //               : null,
  //         ),
  //       ),
  //       buildHorizontalSpace(6),
  //       kTextBentonSansMed(
  //         'Keep Me Sign In',
  //         fontSize: getProportionateScreenHeight(12),
  //         color: ColorManager.black.withOpacity(0.5),
  //       ),
  //     ],
  //   );
  // }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
