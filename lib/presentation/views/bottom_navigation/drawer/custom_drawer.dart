import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sehr/presentation/index.dart';

import '../../../../app/index.dart';
import '../bottom_nav_view.dart';
import 'drawer_menu_screen.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    // final drawerController = ZoomDrawerController();
    return ZoomDrawer(
      //  controller: drawerController,
      menuScreenWidth: SizeConfig.screenWidth,
      mainScreen: const CustomerBottomNavView(),
      menuScreen: DrawerMenuScreenView(),
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
