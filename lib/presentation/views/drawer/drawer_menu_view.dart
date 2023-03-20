import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';
import 'package:sehr/presentation/views/drawer/blog_view.dart';
import 'package:sehr/presentation/views/drawer/membership_view.dart';
import 'package:sehr/presentation/views/drawer/reward_view.dart';
import 'package:sehr/presentation/views/profile/profile_preview_view.dart';

import '../../routes/routes.dart';
import '../../src/index.dart';
import '../../view_models/user_view_model.dart';

class DrawerMenuView extends StatefulWidget {
  const DrawerMenuView({super.key});

  @override
  State<DrawerMenuView> createState() => _DrawerMenuViewState();
}

class _DrawerMenuViewState extends State<DrawerMenuView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserViewModel>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: ChangeNotifierProvider(
          create: (context) => DrawerMenuViewModel(),
          child: Consumer<DrawerMenuViewModel>(builder: (context, model, ch) {
            return Padding(
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
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(4)),
                              child: Image.asset('assets/images/profile.png'),
                            ),
                          ),
                        ),
                        buildVerticleSpace(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            kTextBentonSansBold(
                              '${appUser.firstName}\n${appUser.lastName}',
                              fontSize: getProportionateScreenHeight(19),
                            ),
                            buildHorizontalSpace(11),
                            Container(
                              color:
                                  ColorManager.secondaryLight.withOpacity(0.2),
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(5),
                                right: getProportionateScreenWidth(15),
                                top: getProportionateScreenHeight(3),
                                bottom: getProportionateScreenWidth(3),
                              ),
                              child: kTextBentonSansReg(
                                ' ${appUser.country}',
                                fontSize: getProportionateScreenHeight(9),
                                color: ColorManager.secondaryLight,
                              ),
                            ),
                          ],
                        ),
                        buildVerticleSpace(5),
                        GestureDetector(
                          onTap: () => Get.to(() => const ProfilePreviewView()),
                          child: kTextBentonSansReg(
                            'Check your profile',
                            fontSize: getProportionateScreenHeight(15),
                            color: ColorManager.primary,
                          ),
                        ),
                        buildVerticleSpace(5),
                        kTextBentonSansReg(
                          'Verify your Business',
                          fontSize: getProportionateScreenHeight(12),
                          color: ColorManager.blue,
                        ),
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
                              onTap: (value) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      // contentPadding:
                                      //     const EdgeInsets.symmetric(),
                                      // insetPadding: EdgeInsets.symmetric(
                                      //   horizontal:
                                      //       getProportionateScreenWidth(20),
                                      // ),
                                      // title: const Text('Popup Dialog'),
                                      content: SizedBox(
                                        height:
                                            getProportionateScreenHeight(100),
                                        child: Column(
                                          children: [
                                            kTextBentonSansMed(
                                              'Please Register Your Business',
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      18),
                                            ),
                                            // buildVerticleSpace(50),
                                            const Spacer(),
                                            ActionChip(
                                              backgroundColor: ColorManager
                                                  .primary
                                                  .withOpacity(0.7),
                                              onPressed: () {
                                                Get.toNamed(
                                                    Routes.addBusinessBioRoute);
                                              },
                                              label: kTextBentonSansReg(
                                                'Register',
                                                color: ColorManager.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // actions: [
                                      //   TextButton(
                                      //     onPressed: () {
                                      //       Navigator.of(context).pop();
                                      //     },
                                      //     child: const Text('Close'),
                                      //   ),
                                      // ],
                                    );
                                  },
                                );
                              },
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
                                Tab(text: 'Customer'),
                                Tab(text: 'Business'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildVerticleSpace(35),
                  ListView.separated(
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
            );
          }),
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
