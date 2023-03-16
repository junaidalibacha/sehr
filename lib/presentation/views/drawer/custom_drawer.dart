import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../app/index.dart';
import '../../src/index.dart';
import '../bottom_navigation/bottom_nav_view.dart';
import 'drawer_menu_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    // final drawerController = ZoomDrawerController();
    return ZoomDrawer(
      menuScreenWidth: SizeConfig.screenWidth,
      mainScreen: const BottomNavigationView(),
      menuScreen: DrawerMenuView(),
      borderRadius: 24.0,
      //   showShadow: true,
      angle: 0.0,
      menuBackgroundColor: ColorManager.white,
      drawerShadowsBackgroundColor: ColorManager.black,
      mainScreenTapClose: true,

      // drawerShadowsBackgroundColor: ,
      slideWidth: MediaQuery.of(context).size.width * 0.65,

      //style: DrawerStyle.style4,
    );
  }
}
