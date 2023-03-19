import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';

import '../../common/app_button_widget.dart';
import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

class BusinessVerificationView extends StatelessWidget {
  const BusinessVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                    'Verify Your Business',
                    fontSize: getProportionateScreenHeight(25),
                  ),
                ),
                buildVerticleSpace(20),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(27)),
                  child: kTextBentonSansMed(
                    'Upload Your Business Related Documents\nto verify Your Business',
                    fontSize: getProportionateScreenHeight(12),
                  ),
                ),
                buildVerticleSpace(38),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    children: [
                      kTextBentonSansMed('CNIC'),
                      const Card(),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(118),
                  ),
                  child: AppButtonWidget(
                    ontap: () {
                      // value.getuserRoleFromPrefs();
                      // Get.toNamed(Routes.profileCompleteRoute);
                      // Get.to(const CountdownTimerDemo());
                    },
                    text: 'Next',
                  ),
                ),
                buildVerticleSpace(50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
