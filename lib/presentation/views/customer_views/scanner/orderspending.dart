import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';

import 'package:sehr/presentation/src/index.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';

class OrderProcessingView extends StatefulWidget {
  const OrderProcessingView({super.key});

  @override
  State<OrderProcessingView> createState() => _OrderProcessingViewState();
}

class _OrderProcessingViewState extends State<OrderProcessingView> {
  @override
  void initState() {
    Utils.flushBarErrorMessage(
        context, 'order placed successfully, check out the status of order');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // const TopBackButtonWidget(),
            const Spacer(flex: 2),
            Image.asset(
              AppImages.process,
              height: getProportionateScreenHeight(120),
            ),
            buildVerticleSpace(50),
            kTextBentonSansMed(
              'Processing',
              color: ColorManager.primary,
              fontSize: getProportionateScreenHeight(30),
            ),
            buildVerticleSpace(12),
            kTextBentonSansMed(
              'Your Order is in Process',
              fontSize: getProportionateScreenHeight(20),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 3),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(125),
              ),
              child: AppButtonWidget(
                ontap: () {
                  Get.offAll(() => const DrawerView());
                },
                text: 'Back',
              ),
            ),
            buildVerticleSpace(80),
          ],
        ),
      ),
    );
  }
}
