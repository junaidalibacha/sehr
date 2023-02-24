import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/views/profile/profile_view_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/top_back_button_widget.dart';
import '../../../routes/routes.dart';
import '../../../src/index.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBackButtonWidget(),
                  buildVerticleSpace(20),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(27),
                    ),
                    child: kTextBentonSansMed(
                      'Enter 4-digit\nVerification code',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  buildVerticleSpace(20),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(27)),
                    child: kTextBentonSansMed(
                      'Code send to +6282045**** . This code will \nexpired in 01:30',
                      fontSize: getProportionateScreenHeight(12),
                    ),
                  ),
                  buildVerticleSpace(38),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(23),
                    ),
                    child: Container(
                      height: getProportionateScreenHeight(100),
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(22),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.05),
                            blurRadius: getProportionateScreenHeight(20),
                          ),
                        ],
                      ),
                      child: PinCodeFields(
                        length: 4,
                        // controller: newTextEditingController,
                        // focusNode: focusNode,
                        // borderWidth: 0,
                        autoHideKeyboard: false,
                        keyboardType: TextInputType.number,
                        borderColor: ColorManager.lightGrey,
                        activeBorderColor: ColorManager.primary,
                        textStyle: TextStyleManager.regularTextStyle(
                          fontSize: getProportionateScreenHeight(40),
                        ),
                        onComplete: (result) {},
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
                          value.getProfileTypeFromPrefs();
                          Get.toNamed(Routes.profileCompleteRoute);
                        },
                        text: 'Next',
                      ),
                    ),
                  ),
                  buildVerticleSpace(50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
