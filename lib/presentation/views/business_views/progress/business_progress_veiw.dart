import 'dart:convert' as convert;

import 'package:intl/intl.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/common/custom_card_widget.dart';
import 'package:sehr/presentation/views/business_views/progress/mypayments.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../src/index.dart';

class CustomCardWidget extends StatelessWidget {
  final String titleText;

  final String valueText;
  final String? description;
  final Widget? child;
  const CustomCardWidget({
    Key? key,
    required this.titleText,
    required this.valueText,
    this.description,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: getProportionateScreenHeight(15),
      shadowColor: ColorManager.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(24),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(11),
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(15),
            ),
            child: Row(
              children: [
                kTextBentonSansMed(
                  titleText,
                  fontSize: getProportionateScreenHeight(17),
                ),
                const Spacer(),
                Container(
                  height: getProportionateScreenHeight(31),
                  width: getProportionateScreenWidth(145),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primaryLight,
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(24),
                    ),
                  ),
                  child: kTextBentonSansReg(
                    valueText,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
          // buildVerticleSpace(32),
          child ??
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                  vertical: getProportionateScreenHeight(20),
                ),
                child: kTextBentonSansReg(
                  description ?? '',
                  fontSize: getProportionateScreenHeight(12),
                  lineHeight: getProportionateScreenHeight(2),
                  textOverFlow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
        ],
      ),
    );
  }
}

class BusinessProgresView extends StatefulWidget {
  const BusinessProgresView({super.key});

  @override
  State<BusinessProgresView> createState() => _BusinessProgresViewState();
}

class SpendData {
  final String day;

  final double amount;
  SpendData(this.day, this.amount);
}

class _BusinessProgresViewState extends State<BusinessProgresView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  bool nodata = false;

  Future apicall() async {
    datatest = null;
    filterlist.clear();
    _list.clear();
    if (mounted) {
      setState(() {});
    }
    setState(() {});
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseofdata = await sendStatusOfPayments();
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][1].forEach((element) {
      filterlist.add(element);
    });

    return datatest;
  }

  @override
  Widget build(BuildContext context) {
    return nodata == true
        ? Container(
            child: const Center(
              child: Text("No Any payment to submitted"),
            ),
          )
        : filterlist.isEmpty
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(27),
                          ),
                          child: kTextBentonSansMed(
                            'Payment History',
                            fontSize: getProportionateScreenHeight(25),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(25),
                          vertical: getProportionateScreenHeight(25),
                        ),
                        child: SizedBox(
                          height: 1000,
                          child: ListView.builder(
                              itemCount: filterlist.length,
                              itemBuilder: (context, index) {
                                return CustomListTileWidget(
                                  leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.network(
                                        filterlist[index]['screenshot'],
                                        fit: BoxFit.cover,
                                      )),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      kTextBentonSansMed(
                                        DateFormat("yyyy-MM-dd")
                                            .format(DateTime.parse(
                                                filterlist[index]["paidAt"]
                                                    .toString()))
                                            .toString(),
                                        fontSize:
                                            getProportionateScreenHeight(15),
                                      ),
                                      kTextBentonSansReg(
                                        filterlist[index]["description"],

                                        // searchfilterlist[index]["date"],
                                        color: ColorManager.textGrey
                                            .withOpacity(0.8),
                                        letterSpacing:
                                            getProportionateScreenWidth(0.5),
                                      ),
                                      kTextBentonSansMed(
                                        '',
                                        color: filterlist[index]["status"] ==
                                                'accepted'
                                            ? ColorManager.primary
                                            : ColorManager.textGrey
                                                .withOpacity(0.3),
                                        fontSize:
                                            getProportionateScreenHeight(19),
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    children: [
                                      AppButtonWidget(
                                        bgColor: filterlist[index]["status"] ==
                                                'accepted'
                                            ? null
                                            : ColorManager.textGrey
                                                .withOpacity(0.2),
                                        ontap: () {},
                                        height:
                                            getProportionateScreenHeight(29),
                                        width: getProportionateScreenWidth(85),
                                        text: filterlist[index]["status"],
                                        textSize:
                                            getProportionateScreenHeight(12),
                                        letterSpacing:
                                            getProportionateScreenWidth(0.5),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: kTextBentonSansReg(
                                          'RS ${filterlist[index]["amount"]}',
                                          color: filterlist[index]["status"] ==
                                                  'accepted'
                                              ? ColorManager.blue
                                              : ColorManager.textGrey
                                                  .withOpacity(0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )),
                  ],
                ),
              );
  }

  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    }
    print(filterlist);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    fetchorders();
    // TODO: implement initState
    super.initState();
  }
}
