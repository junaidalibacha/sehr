import '../../../../app/index.dart';
import '../../../../core/mapscreen/map_screen.dart';
import '../../../../domain/models/business_model.dart';
import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';
import '../../../src/index.dart';

class ShopDetailsView extends StatelessWidget {
  BusinessModel businessModel;
  ShopDetailsView({
    required this.businessModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      // color: ColorManager.white,
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30),
                      vertical: getProportionateScreenHeight(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomChipWidget(text: 'Popular'),
                        CircleAvatar(
                          radius: getProportionateScreenHeight(17),
                          backgroundColor: ColorManager.error.withOpacity(0.1),
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
                      vertical: getProportionateScreenHeight(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kTextBentonSansMed(
                          '${businessModel.businessName}',
                          fontSize: getProportionateScreenHeight(27),
                        ),
                        buildVerticleSpace(20),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: ColorManager.primaryLight,
                            ),
                            buildHorizontalSpace(13),
                            kTextBentonSansReg(
                              '${businessModel.distance?.toStringAsFixed(2)} Km',
                              color: ColorManager.textGrey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        buildVerticleSpace(25),
                        SizedBox(
                          height: getProportionateScreenHeight(88),
                          child: kTextBentonSansMed(
                            'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole nothing like getting the whole ',
                            height: 1.5,
                            maxLines: 4,
                            overFlow: TextOverflow.ellipsis,
                          ),
                        ),
                        buildVerticleSpace(40),
                        Row(
                          children: [
                            AppButtonWidget(
                              ontap: () {},
                              height: getProportionateScreenHeight(26),
                              width: getProportionateScreenWidth(72),
                              borderRadius: getProportionateScreenHeight(18),
                              text: 'Contact',
                              textSize: getProportionateScreenHeight(12),
                              letterSpacing: getProportionateScreenWidth(0.5),
                            ),
                            const Spacer(),
                            AppButtonWidget(
                              ontap: () {
                                Get.off(MapDirection(
                                  destLatitude: double.parse(
                                      businessModel.lat.toString()),
                                  destLongitude: double.parse(
                                      businessModel.lon.toString()),
                                ));
                              },
                              height: getProportionateScreenHeight(26),
                              width: getProportionateScreenWidth(115),
                              borderRadius: getProportionateScreenHeight(18),
                              text: 'Get Direction ↗',
                              textSize: getProportionateScreenHeight(12),
                              letterSpacing: getProportionateScreenWidth(0.5),
                            ),
                          ],
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
    );
  }
}
