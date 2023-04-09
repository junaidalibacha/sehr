import 'package:sehr/app/index.dart';

import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert' as convert;

import '../../../src/index.dart';

class SpendData {
  SpendData(this.day, this.amount);

  final String day;
  final double amount;
}

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  final OrderApi _orderApi = OrderApi();

  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  fetchorders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gradekey = prefs.getString("RewardsTarget").toString();
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    }
    if (mounted) {
      setState(() {
        targetamount = gradekey;
      });
    }
  }

  bool nodata = false;
  String targetamount = "";

  Future apicall() async {
    datatest = null;
    filterlist.clear();
    _list.clear();
    if (mounted) {
      setState(() {});
    }
    setState(() {});
    var responseofdata = await _orderApi.fetchmyorderscustomers();
    datatest = convert.jsonDecode(responseofdata.body);
    _list.add(datatest == null ? [] : datatest!.values.toList());
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

  late List<SpendData> data = filterlist
      .map((e) =>
          SpendData(e["id"].toString(), double.parse(e["amount"].toString())))
      .toList();

  late double remainingAmount = int.parse(targetamount) -
      filterlist.fold(0, (t, e) => t + int.parse(e["amount"]));

  late List<SpendData> data2 = [
    SpendData('Remaing', remainingAmount < 0 ? 0 : remainingAmount),
    SpendData(
        'Spend', filterlist.fold(0, (t, e) => t + int.parse(e["amount"]))),
  ];

  double percent() {
    var per = (filterlist.fold(0, (t, e) => t + int.parse(e["amount"])) /
            int.parse(targetamount)) *
        100;
    if (per > 100) {
      return 100;
    } else {
      return per;
    }
  }

  @override
  Widget build(BuildContext context) {
    return filterlist.isEmpty
        ? Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25),
                vertical: getProportionateScreenHeight(25),
              ),
              child: Column(
                children: [
                  CustomCardWidget(
                    titleText: 'Target Amount',
                    valueText: 'Rs: $targetamount/-',
                    description:
                        'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole ',
                  ),
                  buildVerticleSpace(22),
                  CustomCardWidget(
                    titleText: 'Spend Amount',
                    valueText: filterlist
                        .fold(0, (t, e) => t + int.parse(e["amount"]))
                        .toString(),
                    child: SizedBox(
                      height: getProportionateScreenHeight(150),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: 1000,
                          interval: 10000,
                        ),
                        series: [
                          ColumnSeries(
                            color: ColorManager.primaryLight,
                            dataSource: data,
                            xValueMapper: (SpendData sales, _) => sales.day,
                            yValueMapper: (SpendData sales, _) => sales.amount,
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildVerticleSpace(22),
                  CustomCardWidget(
                    titleText:
                        remainingAmount < 0 ? "Target Archieved" : 'Remaining',
                    valueText:
                        'Rs: ${(int.parse(targetamount) - filterlist.fold(0, (t, e) => t + int.parse(e["amount"]))) < 0 ? "0" : int.parse(targetamount) - filterlist.fold(0, (t, e) => t + int.parse(e["amount"]))}',
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(130),
                          child: SfCircularChart(
                            palette: [
                              ColorManager.primaryLight,
                              ColorManager.error,
                            ],
                            series: [
                              DoughnutSeries<SpendData, String>(
                                radius: '50',
                                innerRadius: '40',
                                dataSource: data2,
                                xValueMapper: (SpendData data, _) => data.day,
                                yValueMapper: (SpendData data, _) =>
                                    data.amount,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: percent().truncate().toString(),
                                style: GoogleFonts.libreFranklin(
                                  fontSize: getProportionateScreenHeight(12),
                                  color: ColorManager.black,
                                ),
                              ),
                              TextSpan(
                                text: '/100%',
                                style: GoogleFonts.libreFranklin(
                                  fontSize: getProportionateScreenHeight(14),
                                  color: ColorManager.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildVerticleSpace(10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({
    Key? key,
    required this.titleText,
    required this.valueText,
    this.description,
    this.child,
  }) : super(key: key);

  final String titleText;
  final String valueText;
  final String? description;
  final Widget? child;

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
