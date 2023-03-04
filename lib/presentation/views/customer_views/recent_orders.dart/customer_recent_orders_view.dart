import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/custom_card_widget.dart';
import 'package:sehr/presentation/common/custom_chip_widget.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/view_models/customer_view_models/customer_recent_orders_view_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../src/index.dart';

class CustomerRecentOrdersView extends StatelessWidget {
  CustomerRecentOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerRecentOrdersViewModel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(17),
            ),
            child: Column(
              children: [
                buildVerticleSpace(37),
                kTextBentonSansReg(
                  'Anam Wusono',
                  fontSize: getProportionateScreenHeight(27),
                ),
                kTextBentonSansReg(
                  'anamwp66@gmail.com',
                  color: ColorManager.textGrey.withOpacity(0.3),
                ),
              ],
            ),
          ),
          buildVerticleSpace(20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(40),
              vertical: getProportionateScreenHeight(10),
            ),
            child: kTextBentonSansReg(
              'Completed',
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
              ),
              child: Consumer<CustomerRecentOrdersViewModel>(
                builder: (context, viewModel, child) => ListView.separated(
                  shrinkWrap: true,
                  itemCount: viewModel.orders.length,
                  separatorBuilder: (context, index) => buildVerticleSpace(10),
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(100),
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CustomListTileWidget(
                    leading: Image.asset(AppImages.menu),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kTextBentonSansMed(
                          viewModel.orders[index].itemName,
                          fontSize: getProportionateScreenHeight(15),
                        ),
                        // buildVerticleSpace(4),
                        kTextBentonSansReg(
                          viewModel.orders[index].shopName,
                          color: ColorManager.textGrey.withOpacity(0.8),
                          letterSpacing: getProportionateScreenWidth(0.5),
                        ),
                        // buildVerticleSpace(8),
                        kTextBentonSansReg(
                          'RS ${viewModel.orders[index].price}',
                          color: ColorManager.primary,
                          fontSize: getProportionateScreenHeight(19),
                          letterSpacing: getProportionateScreenWidth(0.5),
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        AppButtonWidget(
                          ontap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (ctx) => Container(
                                height: SizeConfig.screenHeight,
                                width: SizeConfig.screenWidth,
                                color: ColorManager.ambar,
                              ),
                            );
                          },
                          height: getProportionateScreenHeight(29),
                          width: getProportionateScreenWidth(85),
                          text: 'Buy Again',
                          textSize: getProportionateScreenHeight(12),
                          letterSpacing: getProportionateScreenWidth(0.5),
                        ),
                        // buildVerticleSpace(11),
                        const Spacer(),
                        InkWell(
                          onTap: () => _buildOrderDetails(context),
                          child: kTextBentonSansReg(
                            'Detail',
                            color: ColorManager.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildOrderDetails(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: ColorManager.transparent,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17),
          vertical: getProportionateScreenHeight(16),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(kToolbarHeight + 8),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        backgroundColor: ColorManager.white,
        elevation: 5,
        content: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  kTextBentonSansBold(
                    'Detail of Order',
                    fontSize: getProportionateScreenHeight(31),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: getProportionateScreenHeight(24),
                    ),
                  ),
                ],
              ),
              buildVerticleSpace(30),
              CustomChipWidget(
                width: getProportionateScreenWidth(108),
                text: 'Pervious shop',
              ),
              buildVerticleSpace(20),
              kTextBentonSansMed(
                'Shop Name',
                fontSize: getProportionateScreenHeight(27),
              ),
              buildVerticleSpace(25),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorManager.primaryLight,
                    size: getProportionateScreenHeight(20),
                  ),
                  buildHorizontalSpace(12),
                  kTextBentonSansReg(
                    '19 Km',
                    color: ColorManager.textGrey.withOpacity(0.2),
                  ),
                ],
              ),
              buildVerticleSpace(20),
              kTextBentonSansReg(
                'Nulla occaecat velit laborum exercitation ullamco. Elit labore eu aute elit nostrud culpa velit excepteur deserunt sunt. Velit non est cillum consequat cupidatat ex Lorem laboris labore aliqua ad duis eu laborum.',
                fontSize: getProportionateScreenHeight(12),
                lineHeight: getProportionateScreenHeight(2.5),
                maxLines: 4,
                textOverFlow: TextOverflow.ellipsis,
              ),
              buildVerticleSpace(12),
              CustomChipWidget(
                width: getProportionateScreenWidth(95),
                bgColor: ColorManager.ambar.withOpacity(0.2),
                text: 'Completed',
                textColor: ColorManager.ambar,
              ),
              buildVerticleSpace(25),
              SizedBox(
                height: getProportionateScreenHeight(120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    orderInfoList.length,
                    (index) => Row(
                      children: [
                        kTextBentonSansMed(orderInfoList[index].title),
                        buildHorizontalSpace(5),
                        kTextBentonSansReg(orderInfoList[index].value),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // color: ColorManager.transparent,
        ),
      ),
    );
  }

  List<OrderInfoModel> orderInfoList = [
    OrderInfoModel('Order Date :', '02/02/2023'),
    OrderInfoModel('Order Time :', '23:36 pm'),
    OrderInfoModel('Customer contact :', '+92 3xxxxxxxx'),
    OrderInfoModel('Total Amount :', '3500/-'),
  ];
}

class OrderInfoModel {
  String title;
  String value;
  OrderInfoModel(this.title, this.value);
}
