import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/routes/routes.dart';
import 'package:sehr/presentation/view_models/auth_view_model.dart';
import 'package:sehr/presentation/view_models/bottom_nav_view_model.dart';
import 'package:sehr/presentation/views/bottom_navigation/permissionhandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/index.dart';

import '../../view_models/customer_view_models/home_view_model.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  @override
  void initState() {
    checklocation();
    fetchscreen();
    // TODO: implement initState
    super.initState();
  }

  checklocation() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      } else {
        Get.offAll(() => const PermissionHandler());
        timer.cancel();
      }
    });
  }

  String showbussinespages = "";
  fetchscreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showbussinespages = prefs.getString("openbussiness").toString();
    _userRole = prefs.getString("userRole").toString();
    if (_userRole == "null") {
      _userRole = "user";
    }

    if (mounted) {
      setState(() {});
    }
  }

  String _userRole = '';

  @override
  Widget build(BuildContext context) {
    // var profileType =
    //     Provider.of<ProfileViewModel>(context, listen: false).selectedUserRole;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return ChangeNotifierProvider(
        create: (context) => CustomerBottomNavViewModel(),
        child: Consumer<AuthViewModel>(builder: (context, viewModel, child) {
          if (address == null) {
            viewModel.init();
          }
          return SafeArea(
            child: Consumer<CustomerBottomNavViewModel>(
              builder: (ctx, viewModel, child) {
                return WillPopScope(
                  onWillPop: () async {
                    if (viewModel.index == 2) {
                      viewModel.pageChange(0);
                    } else {
                      Get.back();
                    }
                    return false;
                  },
                  child: Scaffold(
                    // drawer: const Drawer(),
                    appBar: viewModel.index == 2 ? null : _buildAppBar(context),

                    body: showbussinespages == "true"
                        ? viewModel.businessPages[viewModel.index]
                        : viewModel.customerPages[viewModel.index],
                    // : viewModel.businessPages[viewModel.index],

                    // bottomNavigationBar: ,
                    bottomNavigationBar: _userRole == 'business'
                        ? _buildBottomNavigation(_userRole)
                        : viewModel.index == 2
                            ? null
                            : _buildBottomNavigation(_userRole),
                  ),
                );
              },
            ),
          );
        }));
  }

  int pageindex = 0;

  Widget _buildBottomNavigation(String userRole) {
    return Container(
      height: getProportionateScreenHeight(65),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getProportionateScreenHeight(22),
          ),
          topRight: Radius.circular(
            getProportionateScreenHeight(22),
          ),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: 10.0,
            // spreadRadius: 1.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Consumer<CustomerBottomNavViewModel>(
        builder: (context, viweModel, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            userRole == 'user'
                ? viweModel.customerPages.length
                : viweModel.businessPages.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  pageindex = index;
                });
                viweModel.pageChange(index);
              },
              child: userRole == 'user'
                  ? index == 2
                      ? Lottie.asset(
                          AppIcons.lottieIcon2,
                          height: getProportionateScreenHeight(55),
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          viweModel.customerIcons[index],
                          height: getProportionateScreenHeight(25),
                          color: viweModel.index == index
                              ? ColorManager.primary
                              : null,
                        )
                  : Image.asset(
                      viweModel.businessIcons[index],
                      height: getProportionateScreenHeight(25),
                      color: viweModel.index == index
                          ? ColorManager.primary
                          : null,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.primary,
      leadingWidth: getProportionateScreenWidth(30),
      leading: IconButton(
        onPressed: () {
          if (ZoomDrawer.of(context)!.isOpen()) {
            ZoomDrawer.of(context)!.close();
          } else {
            ZoomDrawer.of(context)!.open();
          }
          // final zoomDrawer = ZoomDrawer.of(context);
          // if (zoomDrawer != null) {
          //   if (zoomDrawer.isOpen()) {
          //     zoomDrawer.close();
          //   } else {
          //     zoomDrawer.open();
          //   }
          // }
        },
        icon: const Icon(Icons.menu),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kTextBentonSansMed(
            'Current Location',
            fontSize: getProportionateScreenHeight(16),
            color: ColorManager.white,
          ),
          kTextBentonSansReg(
            address.toString() == "null" ? "" : address.toString(),
            fontSize: getProportionateScreenHeight(13),
            color: ColorManager.white,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_rounded,
            size: getProportionateScreenHeight(30),
            color: ColorManager.white,
          ),
          // iconSize: getProportionateScreenHeight(10),
        ),
      ],
    );
  }
}
