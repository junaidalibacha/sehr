import 'dart:async';

import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/profile_view_model.dart';

import '../../common/app_button_widget.dart';
import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(builder: (context, model, ch) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Image.asset(
                AppImages.pattern2,
                color: ColorManager.primary.withOpacity(0.1),
              ),
              Consumer<ProfileViewModel>(
                builder: (context, viewModel, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBackButtonWidget(),
                    buildVerticleSpace(20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(27),
                      ),
                      child: kTextBentonSansMed(
                        'Enter 4-digit\nVerification code',
                        fontSize: getProportionateScreenHeight(25),
                      ),
                    ),
                    buildVerticleSpace(20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(27)),
                      child: kTextBentonSansMed(
                        'Code send to +6282045**** . This code will \nexpired in 01:30',
                        fontSize: getProportionateScreenHeight(12),
                      ),
                    ),
                    buildVerticleSpace(38),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(23),
                      ),
                      child: Container(
                        height: getProportionateScreenHeight(100),
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(30),
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(22),
                          ),
<<<<<<< HEAD
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.black.withOpacity(0.05),
                              blurRadius: getProportionateScreenHeight(20),
                            ),
                          ],
                        ),
                        child: PinCodeFields(
                          length: 4,
                          controller: viewModel.otpController,
                          // focusNode: focusNode,
                          // borderWidth: 0,
                          autoHideKeyboard: false,
                          keyboardType: TextInputType.number,
                          borderColor: ColorManager.lightGrey,
                          activeBorderColor: ColorManager.primary,
                          textStyle: TextStyleManager.regularTextStyle(
                            fontSize: getProportionateScreenHeight(40),
                          ),
                          onComplete: (result) {},
=======
                        ],
                      ),
                      child: PinCodeFields(
                        controller: model.otpController,
                        length: 6,
                        // controller: newTextEditingController,
                        // focusNode: focusNode,
                        // borderWidth: 0,
                        autoHideKeyboard: false,
                        keyboardType: TextInputType.number,
                        borderColor: ColorManager.lightGrey,
                        activeBorderColor: ColorManager.primary,
                        textStyle: TextStyleManager.regularTextStyle(
                          fontSize: getProportionateScreenHeight(40),
>>>>>>> 3fafb3b9180d3b7021a9a8084ea487f7027f220a
                        ),
                      ),
                    ),
<<<<<<< HEAD
                    // buildVerticleSpace(50),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(118),
                      ),
                      child: Consumer<ProfileViewModel>(
                        builder: (context, value, child) => AppButtonWidget(
                          ontap: () {
                            // value.getuserRoleFromPrefs();
                            // Get.toNamed(Routes.profileCompleteRoute);
                            Get.to(const CountdownTimerDemo());
                          },
                          text: 'Next',
                        ),
                      ),
=======
                  ),
                  // buildVerticleSpace(50),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(118),
                    ),
                    child: AppButtonWidget(
                      ontap: () {
                        // value.getuserRoleFromPrefs();
                        if (model.otpController.text.isNotEmpty) {
                          model.verifyPhoneNo(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Enter OTP")));
                        }

                        Get.toNamed(Routes.profileCompleteRoute);
                      },
                      text: 'Next',
                      child: model.isLoading
                          ? const CircularProgressIndicator()
                          : null,
>>>>>>> 3fafb3b9180d3b7021a9a8084ea487f7027f220a
                    ),
                    buildVerticleSpace(50),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({super.key});

  @override
  State<CountdownTimerDemo> createState() => _CountdownTimerDemoState();
}

class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  // Step 2
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 1, seconds: 30);
  @override
  void initState() {
    super.initState();
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 5));
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    // final days = strDigits(myDuration.inDays);
    // Step 7
    // final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      // appBar: ...,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // Step 8
            Text(
              '$minutes:$seconds',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            const SizedBox(height: 20),
            // Step 9
            ElevatedButton(
              onPressed: startTimer,
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 10
            ElevatedButton(
              onPressed: () {
                if (countdownTimer == null || countdownTimer!.isActive) {
                  stopTimer();
                }
              },
              child: const Text(
                'Stop',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 11
            ElevatedButton(
              onPressed: () {
                resetTimer();
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
