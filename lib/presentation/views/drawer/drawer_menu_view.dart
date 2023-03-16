
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';
import 'package:sehr/presentation/views/drawer/blog_view.dart';
import 'package:sehr/presentation/views/drawer/membership_view.dart';
import 'package:sehr/presentation/views/drawer/reward_view.dart';

import '../../routes/routes.dart';
import '../../src/index.dart';
import '../../view_models/user_view_model.dart';

class DrawerMenuView extends StatelessWidget {
  DrawerMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserViewModel>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: ChangeNotifierProvider(
          create: (context) => DrawerMenuViewModel(),
          child: Padding(
            padding: EdgeInsets.only(left: getProportionateScreenHeight(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // buildVerticleSpace(100),
                const Spacer(),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(18)),
                        child: CircleAvatar(
                          backgroundColor: ColorManager.primary,
                          radius: getProportionateScreenHeight(40),
                          child: Padding(
                            padding:
                                EdgeInsets.all(getProportionateScreenHeight(4)),
                            child: Image.asset('assets/images/profile.png'),
                          ),
                        ),
                      ),
                      buildVerticleSpace(15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          kTextBentonSansBold(
                            'Mattie\nHardwick',
                            fontSize: getProportionateScreenHeight(19),
                          ),
                          buildHorizontalSpace(11),
                          Container(
                            color: ColorManager.secondaryLight.withOpacity(0.2),
                            padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(5),
                              right: getProportionateScreenWidth(15),
                              top: getProportionateScreenHeight(3),
                              bottom: getProportionateScreenWidth(3),
                            ),
                            child: kTextBentonSansReg(
                              'Grade A',
                              fontSize: getProportionateScreenHeight(9),
                              color: ColorManager.secondaryLight,
                            ),
                          ),
                        ],
                      ),
                      buildVerticleSpace(5),
                      kTextBentonSansReg('Check your profile',
                          fontSize: getProportionateScreenHeight(15),
                          color: ColorManager.primary),
                      buildVerticleSpace(3),
                      kTextBentonSansReg('Verify your Business',
                          fontSize: getProportionateScreenHeight(12),
                          color: ColorManager.blue),
                      buildVerticleSpace(15),
                      DefaultTabController(
                        length: 2,
                        child: Container(
                          height: getProportionateScreenHeight(33),
                          width: getProportionateScreenWidth(150),
                          decoration: BoxDecoration(
                            color: ColorManager.grey,
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(10),
                            ),
                          ),
                          child: TabBar(
                            onTap: (value) {},
                            labelStyle: TextStyleManager.boldTextStyle(
                              fontSize: getProportionateScreenHeight(12),
                            ),
                            labelPadding: EdgeInsets.zero,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(10),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  ColorManager.gradient1,
                                  ColorManager.gradient2,
                                ],
                              ),
                            ),
                            tabs: const [
                              Tab(text: 'Business'),
                              Tab(text: 'Customer'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                buildVerticleSpace(35),
                Consumer<DrawerMenuViewModel>(
                  builder: (context, value, child) => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        index == 0
                            ? Get.to(() => const RewardView())
                            : index == 1
                                ? {
                                    // value.blogApi(),
                                    Get.to(() => const BlogView()),
                                  }
                                : index == 2
                                    ? {
                                        // value.educationApi(),
                                        // Get.to(() => const BlogView()),
                                      }
                                    : index == 3
                                        ? Get.to(() => MemberShipView())
                                        : const SizedBox();
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            munuList[index].icon,
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(11),
                          ),
                          kTextBentonSansReg(
                            munuList[index].text,
                            fontSize: getProportionateScreenHeight(16),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        buildVerticleSpace(25),
                    itemCount: munuList.length,
                  ),
                ),
                buildVerticleSpace(40),
                InkWell(
                  onTap: () {
                    userPrefs.remove().then(
                          (value) => Get.offAndToNamed(Routes.loginRoute),
                        );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        size: getProportionateScreenHeight(24),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(11),
                      ),
                      kTextBentonSansReg(
                        'Logout',
                        fontSize: getProportionateScreenHeight(16),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<DrawerMenuModel> munuList = [
    DrawerMenuModel(
        icon: 'assets/icons/reward_icons.png', text: 'SEHR Rewards'),
    DrawerMenuModel(icon: 'assets/icons/blog_icon.png', text: 'Blogs'),
    DrawerMenuModel(icon: 'assets/icons/settings.png', text: 'Settings'),
    DrawerMenuModel(
        icon: 'assets/icons/membership_icon.png', text: 'Membership'),
    DrawerMenuModel(
        icon: 'assets/icons/terms_icons.png', text: 'Terms & Conditions'),
    DrawerMenuModel(icon: 'assets/icons/help_icon.png', text: 'Help & Support'),
  ];

  final List<Widget> _pages = [
    const RewardView(),
    const BlogView(),
    MemberShipView(),
  ];
}

class DrawerMenuModel {
  String icon;
  String text;
  DrawerMenuModel({required this.icon, required this.text});
}