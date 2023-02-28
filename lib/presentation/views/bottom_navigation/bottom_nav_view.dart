import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/views/auth/auth.dart';
import 'package:sehr/presentation/views/bottom_navigation/bottom_nav_view_model.dart';

class CustomerBottomNavView extends StatelessWidget {
  const CustomerBottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    var profileType =
        Provider.of<AuthViewModel>(context, listen: false).selectedProfileType;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => CustomerBottomNavViewModel(),
      child: SafeArea(
        child: Consumer<CustomerBottomNavViewModel>(
          builder: (context, viewModel, child) {
            return WillPopScope(
              onWillPop: () async {
                if (profileType == ProfileType.customer) {
                  if (viewModel.index == 2) {
                    viewModel.pageChange(0);
                  } else {
                    Get.back();
                  }
                } else {
                  Get.back();
                }
                return false;
              },
              child: Scaffold(
                // drawer: const Drawer(),
                appBar: profileType == ProfileType.customer
                    ? (viewModel.index == 2 ? null : _buildAppBar(context))
                    : _buildAppBar(context),
                body: profileType == ProfileType.customer
                    ? viewModel.customerPages[viewModel.index]
                    : viewModel.businessPages[viewModel.index],

                // bottomNavigationBar: ,
                bottomNavigationBar: profileType == ProfileType.customer
                    ? (viewModel.index == 2
                        ? null
                        : _buildBottomNavigation(profileType))
                    : _buildBottomNavigation(profileType),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(var type) {
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
            type == ProfileType.customer
                ? viweModel.customerIcons.length
                : viweModel.businessPages.length,
            (index) => InkWell(
              onTap: () {
                viweModel.pageChange(index);
              },
              child: type == ProfileType.customer
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
            'Detail of current location',
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
