import 'package:sehr/app/index.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../src/index.dart';

class SpendData {
  SpendData(this.day, this.amount);

  final String day;
  final double amount;
}

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    List<SpendData> data = [
      SpendData('Jan', 20000),
      SpendData('Feb', 15000),
      SpendData('Mar', 25000),
      SpendData('Apr', 10000),
      SpendData('May', 12332),
      SpendData('Jun', 21312),
      SpendData('Jul', 23111),
      SpendData('Aug', 12312),
      SpendData('Sep', 32131),
      SpendData('Oct', 16133),
      SpendData('Nov', 27863),
      SpendData('Dec', 34667),
    ];

    double totalAmount = 40000;
    double spendAmount = 25000;
    double remainingAmount = totalAmount - spendAmount;

    List<SpendData> data2 = [
      SpendData('Remaing', spendAmount),
      SpendData('Spend', remainingAmount),
    ];

    double percent() {
      var per = (spendAmount / totalAmount) * 100;
      return per;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(25),
          vertical: getProportionateScreenHeight(25),
        ),
        child: Column(
          children: [
            const CustomCardWidget(
              titleText: 'Target Amount',
              valueText: 'Rs: 2400000/-',
              description:
                  'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole ',
            ),
            buildVerticleSpace(22),
            CustomCardWidget(
              titleText: 'Spend Amount',
              valueText: 'Rs: 1400000/-',
              child: SizedBox(
                height: getProportionateScreenHeight(150),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 40000,
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
              titleText: 'Remaining',
              valueText: 'Rs: 1000000/-',
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
                          yValueMapper: (SpendData data, _) => data.amount,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: percent().toString(),
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
                  overFlow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
        ],
      ),
    );
  }
}
