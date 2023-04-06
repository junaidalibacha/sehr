import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/views/drawer/rewardAPI.dart';

import '../../src/index.dart';
import '../customer_views/progress/customer_progress_view.dart';
import 'dart:convert' as convert;

class RewardView extends StatefulWidget {
  const RewardView({super.key});

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  final Rewardapi _apicall = Rewardapi();
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

    var responseofdata = await _apicall.fetchMyorders();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: filterlist.isEmpty
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBackButtonWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(10),
                        horizontal: getProportionateScreenWidth(30)),
                    child: kTextBentonSansBold("SEHR Reward",
                        fontSize: getProportionateScreenHeight(31)),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(25)),
                      shrinkWrap: true,
                      itemCount: filterlist.length,
                      separatorBuilder: (context, index) =>
                          buildVerticleSpace(15),
                      itemBuilder: (context, index) => CustomCardWidget(
                        titleText: filterlist[index]["title"],
                        valueText: 'Activate',
                        description: filterlist[index]["description"],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
