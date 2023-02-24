import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/logo_widget.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/views/auth/auth.dart';

import '../../common/app_button_widget.dart';
import '../../common/text_field_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BgPatternWidget(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(34),
              ),
              child: Center(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildVerticleSpace(120),
                    const LogoWidget(),
                    buildVerticleSpace(32),
                    kTextBentonSansBold(
                      'Sign Up',
                      fontSize: getProportionateScreenHeight(20),
                    ),
                    buildVerticleSpace(40),
                    TextFieldWidget(
                      controller: viewModel.userNameController,
                      keyboardType: TextInputType.name,
                      hintText: 'username',
                      prefixIcon: Image.asset(
                        AppIcons.profileIcon,
                      ),
                    ),
                    buildVerticleSpace(12),
                    TextFieldWidget(
                      controller: viewModel.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      prefixIcon: Image.asset(
                        AppIcons.emailIcon,
                      ),
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
                    ),
                    buildVerticleSpace(20),
                    _buildKeepMeSignIn(viewModel),
                    buildVerticleSpace(78),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(75),
                      ),
                      child: AppButtonWidget(
                        ontap: () {
                          Get.toNamed(Routes.profileSelectionRoute);
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
                    buildVerticleSpace(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildKeepMeSignIn(AuthViewModel viewModel) {
    return Row(
      children: [
        InkWell(
          onTap: () => viewModel.keepAuth(),
          child: Container(
            height: getProportionateScreenHeight(22),
            width: getProportionateScreenHeight(22),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                ColorManager.gradient1,
                ColorManager.gradient2,
              ]),
            ),
            child: viewModel.keepAuthData
                ? Icon(
                    Icons.check_rounded,
                    size: getProportionateScreenHeight(15),
                    color: ColorManager.white,
                  )
                : null,
          ),
        ),
        buildHorizontalSpace(6),
        kTextBentonSansMed(
          'Keep Me Sign In',
          fontSize: getProportionateScreenHeight(12),
          color: ColorManager.black.withOpacity(0.5),
        ),
      ],
    );
  }
}
