import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/view_models/business_view_models/total_sales_view_model.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../../routes/routes.dart';
import '../../../src/index.dart';

class TotalSalesView extends StatefulWidget {
  const TotalSalesView({super.key});

  @override
  State<TotalSalesView> createState() => _TotalSalesViewState();
}

class _TotalSalesViewState extends State<TotalSalesView> {
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
    return filterlist.isEmpty
        ? Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ChangeNotifierProvider(
            create: (context) => TotalSaleViewModel(),
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(23),
                        ),
                        child: Column(
                          children: [
                            _buildDetailCard('Total Completed\nOrders',
                                filterlist.length.toString()),
                            buildVerticleSpace(22),
                            _buildDetailCard('Total Seher\nSale',
                                'PKR: ${filterlist.fold(0, (t, e) => t + int.parse(e["amount"])).toString()}/-'),
                            buildVerticleSpace(22),
                            _buildDetailCard('Total Commision\nTo be Paid',
                                'PKR: ${(int.parse(filterlist.fold(0, (t, e) => t + int.parse(e["amount"])).toString()) / 10).truncate()}/-'),
                            buildVerticleSpace(36),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15),
                              ),
                              child: Row(
                                children: [
                                  kTextBentonSansBold(
                                    'Commission :',
                                    fontSize: getProportionateScreenHeight(16),
                                  ),
                                  const Spacer(),
                                  TextFormField(
                                    // controller: ,
                                    keyboardType: TextInputType.number,
                                    style: TextStyleManager.boldTextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(14),
                                    ),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            getProportionateScreenWidth(194),
                                        minHeight:
                                            getProportionateScreenHeight(57),
                                      ),
                                      filled: true,
                                      fillColor: ColorManager.lightGrey,
                                      hintText: 'Enter Amount',
                                      hintStyle: TextStyleManager.boldTextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(14),
                                        color: ColorManager.textGrey
                                            .withOpacity(0.3),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ColorManager.lightGrey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenHeight(15),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ColorManager.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenHeight(15),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ColorManager.primary,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenHeight(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            buildVerticleSpace(28),
                            AppButtonWidget(
                              ontap: () {
                                Get.toNamed(Routes.paymentRoute);
                              },
                              text: 'Pay Online',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildDetailCard(String title, String value) {
    return Container(
      height: getProportionateScreenHeight(103),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(22),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: getProportionateScreenHeight(5),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: kTextBentonSansBold(
              title,
              fontSize: getProportionateScreenHeight(18),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(15)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(
                  getProportionateScreenHeight(10),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10),
              ),
              child: kTextBentonSansBold(
                value,
                color: ColorManager.primary,
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
