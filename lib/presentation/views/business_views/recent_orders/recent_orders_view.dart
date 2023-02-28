import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/models.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/views/business_views/recent_orders/recent_orders_view_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';

class RecentOrdersView extends StatelessWidget {
  const RecentOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecentOrdersViewModel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildVerticleSpace(18),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(23),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kTextBentonSansBold(
                  'Find Your\nPervious Orders',
                  fontSize: getProportionateScreenHeight(31),
                ),
                buildVerticleSpace(18),
                const SearchRow(),
              ],
            ),
          ),
          buildVerticleSpace(15),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25),
                // vertical: getProportionateScreenHeight(15),
              ),
              child: Consumer<RecentOrdersViewModel>(
                builder: (context, viewModel, child) =>
                    RecentOrdersWidget(items: viewModel.recentOrders),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchRow extends StatelessWidget {
  const SearchRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSearchField(),
        const Spacer(),
        _buildFilterButton(),
      ],
    );
  }

  Widget _buildFilterButton() {
    return Container(
      height: getProportionateScreenHeight(50),
      width: getProportionateScreenHeight(50),
      padding: EdgeInsets.all(
        getProportionateScreenHeight(13),
      ),
      decoration: BoxDecoration(
        color: ColorManager.secondaryLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(15),
        ),
      ),
      child: IconButton(
        splashColor: ColorManager.transparent,
        splashRadius: getProportionateScreenHeight(30),
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Image.asset(
          AppIcons.filterIcon,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.secondaryLight.withOpacity(0.1),
        constraints: BoxConstraints(
          maxHeight: getProportionateScreenHeight(50),
          maxWidth: getProportionateScreenWidth(280),
        ),
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(15),
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(18),
            vertical: getProportionateScreenHeight(13),
          ),
          child: Image.asset(AppIcons.searchIcon),
        ),
        hintText: 'What do you want to order?',
        hintStyle: TextStyleManager.regularTextStyle(
          color: ColorManager.icon.withOpacity(0.4),
          fontSize: getProportionateScreenHeight(12),
        ),
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
  final List<RecentOrdersModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (context, index) => buildVerticleSpace(20),
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(50),
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        tileColor: ColorManager.grey.withOpacity(0.5),
        selectedTileColor: ColorManager.white,
        selected: items[index].isCompleted,
        contentPadding: EdgeInsets.only(
            left: getProportionateScreenWidth(14),
            right: getProportionateScreenHeight(20),
            top: getProportionateScreenHeight(18),
            bottom: getProportionateScreenHeight(12)),
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
              color: items[index].isCompleted
                  ? ColorManager.primary
                  : ColorManager.textGrey.withOpacity(0.3),
              fontSize: getProportionateScreenHeight(19),
            ),
          ],
        ),
        trailing: Column(
          children: [
            AppButtonWidget(
              bgColor: items[index].isCompleted
                  ? null
                  : ColorManager.textGrey.withOpacity(0.2),
              ontap: () {},
              height: getProportionateScreenHeight(29),
              width: getProportionateScreenWidth(85),
              text: 'Completed',
              textSize: getProportionateScreenHeight(12),
              letterSpacing: getProportionateScreenWidth(0.5),
            ),
            buildVerticleSpace(11),
            InkWell(
              onTap: items[index].isCompleted
                  ? () => _buildOrderDetails(context)
                  : null,
              child: kTextBentonSansReg(
                'Detail',
                color: items[index].isCompleted
                    ? ColorManager.blue
                    : ColorManager.textGrey.withOpacity(0.3),
              ),
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
                  width: getProportionateScreenWidth(132),
                  text: 'Pervious Customer'),
              buildVerticleSpace(20),
              kTextBentonSansMed(
                'Customer Name',
                fontSize: getProportionateScreenHeight(27),
              ),
              buildVerticleSpace(65),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.location_on_outlined,
              //       color: ColorManager.primaryLight,
              //       size: getProportionateScreenHeight(20),
              //     ),
              //     buildHorizontalSpace(12),
              //     kTextBentonSansReg(
              //       '19 Km',
              //       color: ColorManager.textGrey.withOpacity(0.2),
              //     ),
              //   ],
              // ),

              // buildVerticleSpace(20),
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
              buildVerticleSpace(14),
              AppButtonWidget(
                ontap: () {},
                text: 'Mark as Spam',
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
