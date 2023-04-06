import 'package:sehr/app/index.dart';

import 'package:sehr/presentation/view_models/business_view_models/request_orders_view_model.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';

import 'package:sehr/presentation/views/business_views/requested_order/ganeratercode.dart';
import 'package:sehr/presentation/views/business_views/requested_order/verifyorder.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../../common/custom_chip_widget.dart';
import '../../../src/index.dart';

class RequestedOrdersView extends StatefulWidget {
  const RequestedOrdersView({super.key});

  @override
  State<RequestedOrdersView> createState() => _RequestedOrdersViewState();
}

class _RequestedOrdersViewState extends State<RequestedOrdersView> {
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
    var responseofdata = await _orderApi
        .fetchorderrequest(prefs.getString("sehrcode").toString());
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      if (element["status"].toString() == "pending") {
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primary,
          title: const Text("Requested Orders"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QRImageGanerate("")),
                    );
                  },
                  icon: const Icon(Icons.qr_code)),
            )
          ],
        ),
        body: nodata == false
            ? filterlist.isEmpty
                ? Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ChangeNotifierProvider(
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
                            "${filterlist.length} New Requests",
                            fontSize: getProportionateScreenHeight(31),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(23),
                            ),
                            child: Consumer<RequestedOrdersViewModel>(
                              builder: (context, viewModel, child) =>
                                  ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: filterlist.length,
                                      separatorBuilder: (context, index) =>
                                          buildVerticleSpace(8),
                                      padding: EdgeInsets.only(
                                        bottom:
                                            getProportionateScreenHeight(60),
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: SizedBox(
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Image.asset(
                                                              AppImages.menu),
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              filterlist[index]
                                                                  ["date"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'RS ${filterlist[index]["amount"]}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorManager
                                                                        .primary,
                                                                    fontSize:
                                                                        getProportionateScreenHeight(
                                                                            19),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                showdialogOrders(
                                                                    context,
                                                                    "Accept",
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                  pleasewaitDIALOG(
                                                                      context);
                                                                  var response = await _orderApi.sendStatusOfOrders(
                                                                      filterlist[index]
                                                                              [
                                                                              "id"]
                                                                          .toString(),
                                                                      "accepted");
                                                                  print(
                                                                      response);
                                                                  if (response !=
                                                                      null) {
                                                                    Navigator.pop(
                                                                        context);

                                                                    _buildOrderDetails(
                                                                            context)
                                                                        .then(
                                                                            (value) async {
                                                                      await fetchorders();
                                                                    });
                                                                  } else {
                                                                    Navigator.pop(
                                                                        context);
                                                                    errordialog(
                                                                        context);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                    color: ColorManager
                                                                        .primary,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                width: 60,
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  "Accept",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                showdialogOrders(
                                                                    context,
                                                                    "Reject",
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                  pleasewaitDIALOG(
                                                                      context);

                                                                  var response = await _orderApi.sendStatusOfOrders(
                                                                      filterlist[index]
                                                                              [
                                                                              "id"]
                                                                          .toString(),
                                                                      "rejected");

                                                                  if (response !=
                                                                      null) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    await fetchorders();
                                                                  } else {
                                                                    Navigator.pop(
                                                                        context);
                                                                    errordialog(
                                                                        context);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .red),
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                width: 60,
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  "Reject",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              )),
                                        );
                                      }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            : Container(
                child: const Center(
                  child: Text(
                    "NO New Request Right Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ));
  }

  Future<dynamic> _buildOrderDetails(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: ColorManager.transparent,
      builder: (context) => AlertDialog(
        // backgroundColor: ColorManager.white,
        // elevation: 5,
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

// class RecentOrdersWidget extends StatelessWidget {
//   const RecentOrdersWidget({
//     Key? key,
//     // required this.name,
//     // required this.category,
//     // required this.distance,
//     // required this.onFavourite,
//     // required this.onDetail,
//     // required this.isFavourite,
//     required this.items,
//   }) : super(key: key);
//   // final String name;
//   // final String category;
//   // final String distance;
//   // final bool isFavourite;
//   // final void Function() onFavourite;
//   // final void Function() onDetail;
//   final List<RequestedOrdersModel> items;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       itemCount: items.length,
//       separatorBuilder: (context, index) => buildVerticleSpace(18),
//       padding: EdgeInsets.only(
//         bottom: getProportionateScreenHeight(60),
//       ),
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) => ListTile(
//         tileColor: ColorManager.white,
//         // selectedTileColor: ColorManager.white,
//         // selected: items[index].isCompleted,
//         contentPadding: EdgeInsets.only(
//           left: getProportionateScreenWidth(14),
//           right: getProportionateScreenHeight(20),
//           top: getProportionateScreenHeight(18),
//           bottom: getProportionateScreenHeight(10),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(
//             getProportionateScreenHeight(22),
//           ),
//         ),
//         leading: Image.asset(
//           AppImages.menu,
//           height: getProportionateScreenHeight(56.5),
//           width: getProportionateScreenHeight(56.5),
//         ),

//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             kTextBentonSansMed(
//               items[index].customerName,
//               fontSize: getProportionateScreenHeight(15),
//             ),
//             buildVerticleSpace(4),
//             kTextBentonSansReg(
//               items[index].shopName,
//               color: ColorManager.textGrey.withOpacity(0.8),
//               letterSpacing: getProportionateScreenWidth(0.5),
//             ),
//             buildVerticleSpace(8),
//             kTextBentonSansMed(
//               'RS ${items[index].price}',
//               color: ColorManager.primary,
//               fontSize: getProportionateScreenHeight(19),
//             ),
//           ],
//         ),

//         trailing: Column(
//           children: [
//             AppButtonWidget(
//               ontap: () {
//                 _buildOrderDetails(context);
//               },
//               height: getProportionateScreenHeight(29),
//               width: getProportionateScreenWidth(80),
//               text: 'Accept',
//               textSize: getProportionateScreenHeight(12),
//               letterSpacing: getProportionateScreenWidth(0.5),
//             ),
//             // buildVerticleSpace(10),
//             const Spacer(),
//             AppButtonWidget(
//               bgColor: Colors.transparent,
//               border: true,
//               ontap: () {},
//               height: getProportionateScreenHeight(29),
//               width: getProportionateScreenWidth(80),
//               text: 'Reject',
//               textColor: ColorManager.error.withOpacity(0.6),
//               textSize: getProportionateScreenHeight(12),
//               letterSpacing: getProportionateScreenWidth(0.5),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class OrderInfoModel {
  String title;
  String value;
  OrderInfoModel(this.title, this.value);
}
