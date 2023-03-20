import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';

import '../../src/index.dart';
import '../customer_views/progress/customer_progress_view.dart';

class RewardView extends StatelessWidget {
  const RewardView({super.key});

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
              child: kTextBentonSansBold("SEHR Reward",
                  fontSize: getProportionateScreenHeight(31)),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25)),
                shrinkWrap: true,
                itemCount: 100,
                separatorBuilder: (context, index) => buildVerticleSpace(15),
                itemBuilder: (context, index) => const CustomCardWidget(
                  titleText: 'Reward Details',
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
}
