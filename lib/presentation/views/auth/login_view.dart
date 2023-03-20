import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/logo_widget.dart';
import 'package:sehr/presentation/utils/utils.dart';
// import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/view_models/auth_view_model.dart';

import '../../common/app_button_widget.dart';
import '../../common/social_button_widget.dart';
import '../../common/text_field_widget.dart';
import '../../routes/routes.dart';
import '../../src/index.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
          child: Form(
            key: viewModel.loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // buildVerticleSpace(80),
                const Spacer(),
                const LogoWidget(),
                buildVerticleSpace(32),
                kTextBentonSansBold(
                  'Login To Your Account',
                  fontSize: getProportionateScreenHeight(20),
                ),
                buildVerticleSpace(40),
                TextFieldWidget(
                  controller: viewModel.loginUserNameController,
                  focusNode: viewModel.loginUserNameFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    size: getProportionateScreenHeight(18),
                    color: ColorManager.primaryLight,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'User name is required';
                    }
                    return null;
                  },
                  onFieldSubmit: (value) {
                    Utils.fieldFocusChange(
                      context,
                      viewModel.loginUserNameFocusNode,
                      viewModel.loginPasswordFocusNode,
                    );
                  },
                ),
                buildVerticleSpace(12),
                TextFieldWidget(
                  controller: viewModel.loginPasswordController,
                  focusNode: viewModel.loginPasswordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Password',
                  obscureText: viewModel.loginPassObscureText,
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    size: getProportionateScreenHeight(18),
                    color: ColorManager.primaryLight,
                  ),
                  sufixIcon: IconButton(
                    splashRadius: 1,
                    onPressed: () => viewModel.showLoginPass(),
                    icon: Icon(
                      viewModel.loginPassObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: getProportionateScreenHeight(20),
                      color: ColorManager.textGrey.withOpacity(0.6),
                    ),
                  ),
                ),
                buildVerticleSpace(20),
                kTextBentonSansMed(
                  'Or Continue With',
                  fontSize: getProportionateScreenHeight(12),
                ),
                buildVerticleSpace(20),
                Row(
                  children: [
                    SocialButtonWidget(
                      onTap: () {
                        // viewModel.facebookSignIn();
                      },
                      icon: AppIcons.facebookIcon,
                      text: 'facebook',
                    ),
                    const Spacer(),
                    SocialButtonWidget(
                      onTap: () {},
                      icon: AppIcons.googleIcon,
                      text: 'Google',
                    ),
                  ],
                ),
                buildVerticleSpace(10),
                TextButton(
                  onPressed: () {},
                  child: kTextBentonSansMed(
                    'Forgot Your Password?',
                    color: ColorManager.primary,
                    fontSize: getProportionateScreenHeight(12),
                    textDecoration: TextDecoration.underline,
                  ),
                ),
                buildVerticleSpace(20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(90),
                  ),
                  child: AppButtonWidget(
                    ontap: () {
                      // Get.toNamed(Routes.signUpRoute);
                      // if (viewModel.userNameController.text.isEmpty &&
                      //     viewModel.passwordController.text.isEmpty) {
                      //   Utils.flushBarErrorMessage(
                      //       context, 'Please Enter Your Email & Pasword');
                      // } else if (viewModel
                      //     .userNameController.text.isEmpty) {
                      //   Utils.flushBarErrorMessage(
                      //       context, 'Email is empty');
                      // } else if (viewModel
                      //     .passwordController.text.isEmpty) {
                      //   Utils.flushBarErrorMessage(
                      //       context, 'Password is empty');
                      // } else if (viewModel.passwordController.text.length <
                      //     8) {
                      //   Utils.flushBarErrorMessage(
                      //       context, 'Password must be 8 charactors');
                      // } else {
                      viewModel.loginApi(context);
                      // }
                    },
                    text: 'Login',
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.signUpRoute);
                  },
                  child: kTextBentonSansMed(
                    'Need an account?',
                    color: ColorManager.primary,
                    fontSize: getProportionateScreenHeight(12),
                    textDecoration: TextDecoration.underline,
                  ),
                ),
                // const Spacer(),
                buildVerticleSpace(50),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}

class BgPatternWidget extends StatelessWidget {
  const BgPatternWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(AppImages.pattern),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: getProportionateScreenHeight(300),
              ),
              child: Image.asset(AppImages.ellipse6),
            ),
          ),
        ],
      ),
    );
  }
}
