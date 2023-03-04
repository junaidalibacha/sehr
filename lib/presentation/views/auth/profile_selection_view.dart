import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/view_models/auth_view_model.dart';

import '../../common/top_back_button_widget.dart';
import '../../routes/routes.dart';
import '../../src/index.dart';

class ProfileSelectionView extends StatelessWidget {
  const ProfileSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return SafeArea(
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
                      'Sign up As',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  buildVerticleSpace(52),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(27)),
                    child: kTextBentonSansMed(
                      'This data will be displayed in your\n\naccount profile for security',
                      fontSize: getProportionateScreenHeight(12),
                    ),
                  ),
                  buildVerticleSpace(83),
                  _buildSelectionCard(
                    // ProfileType.customer,
                    profileType: ProfileType.customer,
                    value: ProfileType.customer,
                    groupValue: viewModel.selectedProfileType,
                    onChanged: (value) => viewModel.selectProfileType(value!),
                  ),
                  buildVerticleSpace(38),
                  _buildSelectionCard(
                    // ProfileType.business,
                    profileType: ProfileType.business,
                    value: ProfileType.business,
                    groupValue: viewModel.selectedProfileType,
                    onChanged: (value) => viewModel.selectProfileType(value!),
                  ),
                  buildVerticleSpace(78),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(118),
                    ),
                    child: AppButtonWidget(
                      ontap: () {
                        viewModel.selectedProfileType == null
                            ? null
                            : Get.toNamed(
                                viewModel.selectedProfileType ==
                                        ProfileType.customer
                                    ? Routes.addCustomerBioRoute
                                    : Routes.addBusinessBioRoute,
                              );
                        print(viewModel.selectedProfileType);
                      },
                      text: 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required ProfileType profileType,
    required ProfileType value,
    ProfileType? groupValue,
    required ValueChanged<ProfileType?> onChanged,
  }) {
    bool isSelect = value == groupValue;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(34),
      ),
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(22),
        ),
        child: Container(
          height: getProportionateScreenHeight(129),
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(14),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: getProportionateScreenHeight(10),
                backgroundColor: ColorManager.grey,
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(3)),
                  child: CircleAvatar(
                    backgroundColor: isSelect
                        ? ColorManager.primary
                        : ColorManager.transparent,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    profileType == ProfileType.customer
                        ? AppIcons.customerIcon
                        : AppIcons.businessIcon,
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenHeight(50),
                  ),
                  buildVerticleSpace(9),
                  kTextBentonSansMed(profileType == ProfileType.customer
                      ? 'Customer'
                      : 'Business'),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: getProportionateScreenHeight(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
