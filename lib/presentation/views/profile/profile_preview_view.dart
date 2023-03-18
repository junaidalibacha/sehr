import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';

import '../../common/app_button_widget.dart';
import '../../common/custom_chip_widget.dart';
import '../../src/index.dart';

class ProfilePreviewView extends StatelessWidget {
  const ProfilePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          // color: ColorManager.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: SizeConfig.screenHeight * 0.38,
                  width: SizeConfig.screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AppImages.profilePreview,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TopBackButtonWidget(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(35),
                          right: getProportionateScreenWidth(10),
                        ),
                        child: ActionChip(
                          onPressed: () {},
                          backgroundColor: ColorManager.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(5),
                            ),
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(5),
                          ),
                          labelPadding: EdgeInsets.zero,
                          label: kTextBentonSansMed(
                            'Change image',
                            color: ColorManager.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //  Image.asset(
                //   AppImages.profilePreview,
                // height: SizeConfig.screenHeight * 0.5,
                // width: SizeConfig.screenWidth,
                // fit: BoxFit.cover,
                // ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: SizeConfig.screenHeight * 0.62,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(getProportionateScreenHeight(30)),
                      topRight:
                          Radius.circular(getProportionateScreenHeight(30)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildVerticleSpace(44),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomChipWidget(
                              width: getProportionateScreenWidth(110),
                              bgColor: ColorManager.ambar.withOpacity(0.2),
                              text: 'Member Gold',
                              textColor: ColorManager.ambar,
                            ),
                            AppButtonWidget(
                              ontap: () {},
                              height: getProportionateScreenHeight(26.5),
                              width: getProportionateScreenWidth(72),
                              text: 'Update',
                              textSize: getProportionateScreenHeight(12),
                            ),
                          ],
                        ),
                      ),
                      buildVerticleSpace(20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(33),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                kTextBentonSansMed(
                                  'Full Name',
                                  fontSize: getProportionateScreenHeight(27),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: getProportionateScreenWidth(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Image.asset(
                                      AppIcons.editIcon,
                                      height: getProportionateScreenHeight(24),
                                      width: getProportionateScreenHeight(24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            buildVerticleSpace(4),
                            kTextBentonSansReg(
                              'anamwp66@gmail.com',
                              color: ColorManager.textGrey.withOpacity(0.2),
                            ),
                            buildVerticleSpace(18),
                            TextFieldWidget(
                              // readOnly: true,
                              controller:
                                  TextEditingController(text: 'Cnic No'),
                              hintText: 'Cnic No',
                            ),
                            buildVerticleSpace(18),
                            const TextFieldWidget(
                              hintText: 'DOB',
                            ),
                            buildVerticleSpace(18),
                            const TextFieldWidget(
                              hintText: 'Education',
                            ),
                            buildVerticleSpace(18),
                            const TextFieldWidget(
                              hintText: 'Mobile Number',
                            ),
                          ],
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
}
