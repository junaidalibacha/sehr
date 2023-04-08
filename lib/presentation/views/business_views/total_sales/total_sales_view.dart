import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/view_models/business_view_models/total_sales_view_model.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:sehr/presentation/views/business_views/total_sales/fetchcomission.dart';
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
  fetchorders(String datetimerange) async {
    await apicall(datetimerange);
    if (mounted) {
      setState(() {});
    }
  }

  bool nodata = false;

  Future apicall(String datetimerange) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var responseofdata = await reportscommissions(datetimerange);
    datatest = convert.jsonDecode(responseofdata.body) as dynamic;
    _list.add(datatest == null ? [] : datatest!.values.toList());

    return datatest;
  }

  String datetimerange = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    fetchorders(datetimerange);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TotalSaleViewModel(),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Consumer<TotalSaleViewModel>(
              builder: (context, viewModel, child) => Card(
                margin: EdgeInsets.zero,
                elevation: 2,
                shadowColor: ColorManager.lightGrey,
                child: TabBar(
                  labelColor: ColorManager.black,
                  labelStyle: TextStyleManager.mediumTextStyle(
                    fontSize: getProportionateScreenHeight(16),
                  ),
                  indicatorColor: ColorManager.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'Daily'),
                    Tab(text: 'Monthly'),
                    Tab(text: 'Yearly'),
                  ],
                  onTap: (value) {
                    viewModel.changeDuration(value);
                    print(value);

                    setState(() {
                      if (value == 0) {
                        _list.clear();
                        datetimerange =
                            DateFormat("yyyy-MM-dd").format(DateTime.now());
                        fetchorders(datetimerange);
                      } else if (value == 1) {
                        _list.clear();
                        datetimerange = DateFormat("yyyy-MM-dd").format(
                            DateTime.now().subtract(const Duration(days: 30)));
                        fetchorders(datetimerange);
                      } else if (value == 2) {
                        _list.clear();
                        datetimerange = DateFormat("yyyy-MM-dd").format(
                            DateTime.now().subtract(const Duration(days: 365)));
                        fetchorders(datetimerange);
                      }
                    });
                  },
                ),
              ),
            ),
            _list.isEmpty
                ? Container(
                    child: const Center(
                      child: LinearProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(23),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            _buildDetailCard('Total Completed\nOrders',
                                _list[0][0].toString()),
                            buildVerticleSpace(22),
                            _buildDetailCard('Total Seher\nSale',
                                'PKR: ${_list[0][1].toString()}/-'),
                            buildVerticleSpace(22),
                            _buildDetailCard('Total Commision\nTo be Paid',
                                'PKR: ${_list[0][2].toString()}/-'),
                            buildVerticleSpace(36),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15),
                              ),
                              child: Row(
                                children: [
                                  kTextBentonSansBold(
                                    "commission:",
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
