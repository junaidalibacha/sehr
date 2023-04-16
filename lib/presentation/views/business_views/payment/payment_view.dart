import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/business_view_models/payment_view_model.dart';
import 'package:sehr/presentation/views/payment/paymentpage.dart';

import '../../../common/top_back_button_widget.dart';
import '../../../src/index.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => PayementViewModel(),
          child: Stack(
            children: [
              Image.asset(
                AppImages.pattern2,
                color: ColorManager.primary.withOpacity(0.1),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBackButtonWidget(),
                  buildVerticleSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(34),
                      vertical: getProportionateScreenHeight(20),
                    ),
                    child: kTextBentonSansBold(
                      'Payment',
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30),
                    ),
                    child: Column(
                      children: [
                        _buildPaymentCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Consumer<PayementViewModel>(
      builder: (context, viewModel, child) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.paymentImages.length,
        separatorBuilder: (context, index) => buildVerticleSpace(17),
        itemBuilder: (context, index) => InkWell(
            onTap: () =>
                viewModel.selecPayment(viewModel.paymentTypeList[index]),
            child: PaymentWidget(
                value: viewModel.paymentTypeList[index],
                groupValue: viewModel.paymentType,
                label: viewModel.paymentImages[index],
                text: viewModel.paymentNumber[index],
                onChanged: (value) {
                  viewModel.selecPayment(value!);
                  Get.to(() => const PaymentPage());
                })),
      ),
    );
  }
}

class PaymentWidget<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const PaymentWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        height: getProportionateScreenHeight(73),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.white : ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(22),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              label,
              height: getProportionateScreenHeight(23),
              width: getProportionateScreenWidth(110),
            ),
            const Spacer(),
            kTextBentonSansReg(text),
          ],
        ),
      ),
    );
  }
}
