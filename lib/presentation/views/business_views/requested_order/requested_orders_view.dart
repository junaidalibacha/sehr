import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/views/business_views/requested_order/request_orders_view_model.dart';

import '../../../../domain/models/models.dart';
import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';

class RequestedOrdersView extends StatelessWidget {
  const RequestedOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RequestedOrdersViewModel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(25),
              vertical: getProportionateScreenHeight(15),
            ),
            child: kTextBentonSansBold(
              'Requested Orders',
              fontSize: getProportionateScreenHeight(31),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(23),
              ),
              child: Consumer<RequestedOrdersViewModel>(
                builder: (context, viewModel, child) => RecentOrdersWidget(
                  items: viewModel.requestedOrders,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentOrdersWidget extends StatelessWidget {
  RecentOrdersWidget({
    Key? key,
    // required this.name,
    // required this.category,
    // required this.distance,
    // required this.onFavourite,
    // required this.onDetail,
    // required this.isFavourite,
    required this.items,
  }) : super(key: key);
  // final String name;
  // final String category;
  // final String distance;
  // final bool isFavourite;
  // final void Function() onFavourite;
  // final void Function() onDetail;
  final List<RequestedOrdersModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (context, index) => buildVerticleSpace(18),
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(60),
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        tileColor: ColorManager.white,
        // selectedTileColor: ColorManager.white,
        // selected: items[index].isCompleted,
        contentPadding: EdgeInsets.only(
          left: getProportionateScreenWidth(14),
          right: getProportionateScreenHeight(20),
          top: getProportionateScreenHeight(18),
          bottom: getProportionateScreenHeight(10),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(22),
          ),
        ),
        leading: Image.asset(
          AppImages.menu,
          height: getProportionateScreenHeight(56.5),
          width: getProportionateScreenHeight(56.5),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kTextBentonSansMed(
              items[index].customerName,
              fontSize: getProportionateScreenHeight(15),
            ),
            buildVerticleSpace(4),
            kTextBentonSansReg(
              items[index].shopName,
              color: ColorManager.textGrey.withOpacity(0.8),
              letterSpacing: getProportionateScreenWidth(0.5),
            ),
            buildVerticleSpace(8),
            kTextBentonSansMed(
              'RS ${items[index].price}',
              color: ColorManager.primary,
              fontSize: getProportionateScreenHeight(19),
            ),
          ],
        ),
        trailing: Column(
          children: [
            AppButtonWidget(
              ontap: () {
                _buildOrderDetails(context);
              },
              height: getProportionateScreenHeight(29),
              width: getProportionateScreenWidth(80),
              text: 'Accept',
              textSize: getProportionateScreenHeight(12),
              letterSpacing: getProportionateScreenWidth(0.5),
            ),
            // buildVerticleSpace(10),
            const Spacer(),
            AppButtonWidget(
              bgColor: Colors.transparent,
              border: true,
              ontap: () {},
              height: getProportionateScreenHeight(29),
              width: getProportionateScreenWidth(80),
              text: 'Reject',
              textColor: ColorManager.error.withOpacity(0.6),
              textSize: getProportionateScreenHeight(12),
              letterSpacing: getProportionateScreenWidth(0.5),
            ),
          ],
        ),
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
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(80),
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
                    'Order Accepted',
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
                width: getProportionateScreenWidth(132),
                text: 'Pervious Customer',
              ),
              buildVerticleSpace(20),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(40),
                ),
                child: kTextBentonSansMed(
                  'Customer Name',
                  fontSize: getProportionateScreenHeight(27),
                ),
              ),
              buildVerticleSpace(65),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(40),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      // color: Colors.amber,
                      height: getProportionateScreenHeight(120),
                      // width: SizeConfig.screenWidth,
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
                    Positioned(
                      bottom: getProportionateScreenHeight(-120),
                      right: getProportionateScreenWidth(80),
                      child: Image.asset(
                        AppImages.paid,
                        height: getProportionateScreenHeight(145),
                        width: getProportionateScreenWidth(140),
                      ),
                    ),
                  ],
                ),
              ),
              // buildVerticleSpace(14),
              // AppButtonWidget(
              //   ontap: () {},
              //   text: 'Mark as Spam',
              // ),
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
