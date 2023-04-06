import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/custom_card_widget.dart';
import 'package:sehr/presentation/common/custom_chip_widget.dart';

import 'package:sehr/presentation/view_models/blog_view_model.dart';
import 'package:sehr/presentation/view_models/customer_view_models/customer_recent_orders_view_model.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../../common/app_button_widget.dart';
import '../../../src/index.dart';

class CustomerRecentOrdersView extends StatefulWidget {
  const CustomerRecentOrdersView({super.key});

  @override
  State<CustomerRecentOrdersView> createState() =>
      _CustomerRecentOrdersViewState();
}

class _CustomerRecentOrdersViewState extends State<CustomerRecentOrdersView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    }

    setState(() {});
  }

  bool nodata = false;

  Future apicall() async {
    print("object checkinh");
    datatest = null;
    filterlist.clear();
    _list.clear();
    setState(() {});
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseofdata = await _orderApi.fetchmyorderscustomers();
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
    print(_list);
    _list[0][0].forEach((element) {
      filterlist.add(element);
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
                Row(
                  children: [
                    kTextBentonSansReg(
                      "${appUser.firstName.toString()}${appUser.lastName.toString()}",
                      fontSize: getProportionateScreenHeight(27),
                    ),
                  ],
                ),
                Row(
                  children: [
                    kTextBentonSansReg(
                      appUser.email.toString(),
                      color: ColorManager.textGrey.withOpacity(0.3),
                    ),
                  ],
                )
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
          nodata == true
              ? Expanded(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: const Text(
                      "No Recent Completed Orders",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
                  ],
                ))
              : filterlist.isEmpty
                  ? Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: LinearProgressIndicator(),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(24),
                        ),
                        child: Consumer<CustomerRecentOrdersViewModel>(
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
                                            bgColor: null,
                                            ontap: () {
                                              _buildOrderDetails(context);
                                            },
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
