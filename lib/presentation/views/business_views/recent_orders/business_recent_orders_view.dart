import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/business_view_models/business_recent_orders_view_model.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';
import '../../../src/index.dart';
import 'dart:convert' as convert;

class BusinessRecentOrdersView extends StatefulWidget {
  const BusinessRecentOrdersView({super.key});

  @override
  State<BusinessRecentOrdersView> createState() =>
      _BusinessRecentOrdersViewState();
}

class _BusinessRecentOrdersViewState extends State<BusinessRecentOrdersView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    }

    setState(() {});
  }

  bool nodata = false;

  List<dynamic> filterlist = [];

  Future apicall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseofdata = await _orderApi
        .fetchorderrequest(prefs.getString("sehrcode").toString());
    datatest = convert.jsonDecode(responseofdata.body) as dynamic;
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      if (element["status"].toString() != "pending") {
        filterlist.add(element);
      }
    });

    return datatest;
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessRecentOrdersViewModel(),
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
          nodata == true
              ? Container(
                  child: Center(
                    child: Text("No Recent Orders"),
                  ),
                )
              : filterlist.isEmpty
                  ? Container(
                      child: const Center(
                        child: LinearProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(25),
                          // vertical: getProportionateScreenHeight(15),
                        ),
                        child: Consumer<BusinessRecentOrdersViewModel>(
                          builder: (context, viewModel, child) =>
                              ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: filterlist.length,
                                  separatorBuilder: (context, index) =>
                                      buildVerticleSpace(20),
                                  padding: EdgeInsets.only(
                                    bottom: getProportionateScreenHeight(50),
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Card(
                                        elevation: 0,
                                        child: ListTile(
                                          trailing: Text(
                                            "RS ${filterlist[index]["amount"]}",
                                            style: TextStyle(),
                                          ),
                                          subtitle: AppButtonWidget(
                                            bgColor: filterlist[index]
                                                        ["status"] ==
                                                    "accepted"
                                                ? null
                                                : Colors.red,
                                            ontap: () {},
                                            height:
                                                getProportionateScreenHeight(
                                                    29),
                                            width:
                                                getProportionateScreenWidth(85),
                                            text: filterlist[index]["status"],
                                            textSize:
                                                getProportionateScreenHeight(
                                                    12),
                                            letterSpacing:
                                                getProportionateScreenWidth(
                                                    0.5),
                                          ),
                                          leading: Image.asset(AppImages.menu),
                                          title: Text(
                                            filterlist[index]["date"],
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      )),
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

class OrderInfoModel {
  String title;
  String value;
  OrderInfoModel(this.title, this.value);
}
