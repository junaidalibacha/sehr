import 'dart:async';

import 'package:sehr/app/index.dart';

import '../../common/logo_widget.dart';
import '../../routes/routes.dart';
import '../../src/index.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  void _splashScreenDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  void _goNext() {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  @override
  void initState() {
    _splashScreenDelay();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(AppImages.splashLogo),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(80),
                  ),
                  child: Image.asset(AppImages.ellipse1),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LogoWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
