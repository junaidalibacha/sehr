import 'dart:convert' as convert;

import 'package:sehr/app/index.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/views/drawer/rewardAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/index.dart';
import '../customer_views/progress/customer_progress_view.dart';

class RewardView extends StatefulWidget {
  const RewardView({super.key});

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  var getxcontroller = Get.put(AppController());
  final Rewardapi _apicall = Rewardapi();
  Map<String, dynamic>? datatest;
  final List<dynamic> _list = [];
  List<dynamic> filterlist = [];
  // ignore: prefer_typing_uninitialized_variables
  var activatedReward;
  bool nodata = false;

  bool isactivated = false;

  Future apicall() async {
    datatest = null;
    filterlist.clear();
    _list.clear();
    if (mounted) {
      setState(() {});
    }
    var responseofdata = await _apicall.fetchMyorders();

    datatest = convert.jsonDecode(responseofdata.body);

    _list.add(datatest == null ? [] : datatest!.values.toList());
    _list[0][0].forEach((element) {
      filterlist.add(element);
    });

    return datatest;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Obx(() {
        return getxcontroller.postloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : filterlist.isEmpty
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
                      activatedReward.length != 0
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionateScreenHeight(10),
                                          horizontal:
                                              getProportionateScreenWidth(30)),
                                      child: kTextBentonSansBold(
                                          "Activated Reward",
                                          fontSize:
                                              getProportionateScreenHeight(20)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: GestureDetector(
                                    onTap: () {
                                      print(filterlist.length);
                                    },
                                    child: CustomCardWidget(
                                      titleText: activatedReward[0]["title"],
                                      valueText: 'Activated',
                                      description: activatedReward[0]
                                          ["description"],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(10),
                            horizontal: getProportionateScreenWidth(30)),
                        child: kTextBentonSansBold("Others Rewards",
                            fontSize: getProportionateScreenHeight(20)),
                      ),
                      Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(25)),
                            shrinkWrap: true,
                            itemCount: filterlist.length,
                            separatorBuilder: (context, index) =>
                                buildVerticleSpace(15),
                            itemBuilder: (context, index) {
                              // if (activatedReward[0]["id"] ==
                              //     filterlist[index]["id"]) {
                              //   return null;
                              // } else {

                              // }
                              return activatedReward[0]["id"] ==
                                      filterlist[index]["id"]
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Sure"),
                                                content: Text(
                                                    "sure to activate ${filterlist[index]["title"]}"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        prefs.setString(
                                                            "RewardsTarget",
                                                            filterlist[index][
                                                                    "salesTarget"]
                                                                .toString());
                                                        prefs.setString(
                                                            "RewardsTitle",
                                                            filterlist[index]
                                                                    ["title"]
                                                                .toString());
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Ok"))
                                                ],
                                              );
                                            });
                                      },
                                      child: CustomCardWidget(
                                        titleText: filterlist[index]["title"],
                                        valueText: 'Activate',
                                        description: filterlist[index]
                                            ["description"],
                                      ),
                                    );
                            }),
                      )
                    ],
                  );
      })),
    );
  }

  fetchorders() async {
    await apicall();
    if (filterlist.isEmpty) {
      nodata = true;
    } else {
      activatedReward = filterlist
          .where((element) =>
              element["id"].toString().trim() ==
              getxcontroller.rewardslist[0][0]["id"].toString().trim())
          .toList();
    }

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
