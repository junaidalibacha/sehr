import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/views/business_views/payment/payment_view_model.dart';
import 'package:sehr/presentation/views/business_views/payment/payment_widget.dart';

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
                        // buildVerticleSpace(20),
                        // _buildPaymentCard(
                        //   image: AppImages.visa,
                        //   text: '2121 6352 8465 ****',
                        //   isSelect: false,
                        // ),
                        // buildVerticleSpace(20),
                        // _buildPaymentCard(
                        //   image: AppImages.jazzCash,
                        //   text: '2121 6352 8465 ****',
                        //   isSelect: false,
                        // ),
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

  Widget _buildPaymentCard(
      //   {
      //   // required String image,
      //   // required String text,
      //   // required bool isSelect,
      // }
      ) {
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
              onChanged: (value) => viewModel.selecPayment(value!),
            )),
      ),
    );
  }

  // List<String> paymentImages
}
