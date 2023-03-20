import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/common/text_field_widget.dart';

import '../../../common/custom_chip_widget.dart';
import '../../../src/index.dart';

class RequestOrderView extends StatelessWidget {
  const RequestOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                AppImages.restourant,
                height: SizeConfig.screenHeight * 0.5,
                width: SizeConfig.screenWidth,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.screenHeight * 0.55,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getProportionateScreenHeight(30)),
                    topRight: Radius.circular(getProportionateScreenHeight(30)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildVerticleSpace(35),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomChipWidget(text: 'Popular'),
                          CircleAvatar(
                            radius: getProportionateScreenHeight(17),
                            backgroundColor:
                                ColorManager.error.withOpacity(0.1),
                            child: Icon(
                              Icons.favorite_rounded,
                              color: ColorManager.errorLight,
                              size: getProportionateScreenHeight(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildVerticleSpace(20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(33),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kTextBentonSansMed(
                            'Shop Name',
                            fontSize: getProportionateScreenHeight(27),
                          ),
                          buildVerticleSpace(10),
                          SizedBox(
                            height: getProportionateScreenHeight(88),
                            child: kTextBentonSansMed(
                              'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole nothing like getting the whole ',
                              height: 1.5,
                              maxLines: 4,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          ),
                          buildVerticleSpace(10),
                          Card(
                            color: ColorManager.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(22),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(10),
                                vertical: getProportionateScreenHeight(12),
                              ),
                              child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        getProportionateScreenHeight(22),
                                      ),
                                    ),
                                    color: ColorManager.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(10),
                                        vertical:
                                            getProportionateScreenHeight(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                AppImages.cash,
                                                height:
                                                    getProportionateScreenHeight(
                                                        35),
                                              ),
                                              kTextBentonSansMed(
                                                'Enter Total Amount',
                                              ),
                                            ],
                                          ),
                                          TextFieldWidget(
                                            shadow: false,
                                            textAlign: TextAlign.center,
                                            fillColor: ColorManager.grey
                                                .withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  buildVerticleSpace(8),
                                  AppButtonWidget(
                                    ontap: () {},
                                    bgColor: ColorManager.white,
                                    child: kTextBentonSansBold(
                                      'Verify My Order',
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
