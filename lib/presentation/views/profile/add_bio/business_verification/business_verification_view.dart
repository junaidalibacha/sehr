import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';

import '../../../../common/app_button_widget.dart';
import '../../../../common/top_back_button_widget.dart';
import '../../../../routes/routes.dart';
import '../../../../src/index.dart';

class BusinessVerificationView extends StatelessWidget {
  const BusinessVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
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
                      _buildCard(
                        ontap: () => viewModel.getCnic(),
                        icon: AppIcons.galleryIcon,
                        label: 'Upload CNIC',
                        child: viewModel.cnic != null
                            ? Image.file(
                                viewModel.cnic!,
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                      buildVerticleSpace(20),
                      _buildCard(
                        ontap: () => viewModel.getFbr(),
                        icon: AppIcons.galleryIcon,
                        label: 'Upload FBR',
                        child: viewModel.fbr != null
                            ? Image.file(
                                viewModel.fbr!,
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                      buildVerticleSpace(20),
                      _buildCard(
                        ontap: () => viewModel.getOtherDocs(),
                        icon: AppImages.file,
                        label: 'Upload Other',
                        child: viewModel.otherDocs != null
                            ? Image.file(
                                viewModel.otherDocs!,
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
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
                      Get.toNamed(Routes.businessVerificationProcesingRoute);
                      // Get.to(const CountdownTimerDemo());
                    },
                    text: 'Submit',
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

  Widget _buildCard({
    required String icon,
    required String label,
    void Function()? ontap,
    Widget? child,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: getProportionateScreenHeight(129),
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(getProportionateScreenHeight(5)),
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
        child: child ??
            Column(
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
}
