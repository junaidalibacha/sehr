import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/logo_widget.dart';
import 'package:sehr/presentation/index.dart';
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
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            const BgPatternWidget(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(34),
              ),
              child: Form(
                key: viewModel.loginFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildVerticleSpace(120),
                    const LogoWidget(),
                    buildVerticleSpace(32),
                    kTextBentonSansBold(
                      'Login To Your Account',
                      fontSize: getProportionateScreenHeight(20),
                    ),
                    buildVerticleSpace(40),
                    TextFieldWidget(
                      controller: viewModel.userNameController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      prefixIcon: Image.asset(
                        AppIcons.emailIcon,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'User name is required';
                        }
                        return null;
                      },
                    ),
                    buildVerticleSpace(12),
                    TextFieldWidget(
                      controller: viewModel.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      obscureText: viewModel.showPassword,
                      prefixIcon: Image.asset(
                        AppIcons.passwordIcon,
                      ),
                      sufixIcon: InkWell(
                        onTap: () => viewModel.showPass(),
                        child: Image.asset(AppIcons.showIcon),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
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
                          viewModel.login();
                        },
                        text: 'Login',
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
                  ],
                ),
              ),
            ),
          ],
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
