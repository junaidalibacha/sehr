import 'package:sehr/app/index.dart';

import '../../../../common/top_back_button_widget.dart';
import '../../../../src/size_config.dart';
import '../../../customer_views/progress/customer_progress_view.dart';

class MemberShipView extends StatelessWidget {
  MemberShipView({super.key});

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
              child: kTextBentonSansBold("Membership",
                  fontSize: getProportionateScreenHeight(31)),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(25)) +
                    EdgeInsets.only(
                      bottom: getProportionateScreenHeight(50),
                    ),
                shrinkWrap: true,
                itemCount: gradeList.length,
                separatorBuilder: (context, index) => buildVerticleSpace(12),
                itemBuilder: (context, index) => CustomCardWidget(
                  titleText: gradeList[index],
                  valueText: 'Activate',
                  description:
                      'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> gradeList = [
    'Grade A',
    'Grade B',
    'Grade C',
  ];
}
