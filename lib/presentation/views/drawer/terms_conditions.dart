import 'package:sehr/app/index.dart';

import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

class TermsConditionView extends StatelessWidget {
  const TermsConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBackButtonWidget(),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(30)),
              child: kTextBentonSansBold("Terms & Conditions",
                  fontSize: getProportionateScreenHeight(31)),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25)),
                shrinkWrap: true,
                itemCount: 100,
                separatorBuilder: (context, index) => buildVerticleSpace(15),
                itemBuilder: (context, index) => TermCardWidget(
                  title: 'Terms-$index',
                  discription:
                      'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole.Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TermCardWidget extends StatelessWidget {
  const TermCardWidget({
    super.key,
    required this.title,
    required this.discription,
  });
  final String title;
  final String discription;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: getProportionateScreenHeight(15),
      shadowColor: ColorManager.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(24),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(15),
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(15),
            ),
            child: Row(
              children: [
                kTextBentonSansMed(
                  title,
                  fontSize: getProportionateScreenHeight(17),
                ),
              ],
            ),
          ),
          // buildVerticleSpace(32),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(20),
            ),
            child: kTextBentonSansReg(
              discription,
              fontSize: getProportionateScreenHeight(12),
              lineHeight: getProportionateScreenHeight(2),
              // overFlow: TextOverflow.ellipsis,
              // maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}
