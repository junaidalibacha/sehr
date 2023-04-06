import 'dart:async';

import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/business_model.dart';
import 'package:sehr/getXcontroller/userpagecontroller.dart';
import 'package:sehr/presentation/view_models/customer_view_models/home_view_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';
import '../../../common/custom_card_widget.dart';
import '../../../src/index.dart';
import '../shop/shop_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  List<BusinessModel>? filterbussinessshops = [];
  List<String> searchlist = ["1"];
  var getxcontroller = Get.put(AppController());
  bool setdata = false;
  @override
  void initState() {
    timerchecking();
    // TODO: implement initState
    super.initState();
  }

  late bool isloaded = getxcontroller.business.isEmpty ? false : true;

  timerchecking() {
    Timer.periodic(const Duration(microseconds: 1), (timer) async {
      if (getxcontroller.business.isEmpty) {
      } else {
        filterbussinessshops = getxcontroller.business;
        setState(() {
          isloaded = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    getxcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return getxcontroller.postloading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isloaded == true
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(23),
                        vertical: getProportionateScreenHeight(13),
                      ),
                      child: Column(
                        children: [
                          // const SearchRow(),
                          Row(
                            children: [
                              _buildSearchField(_controller, (a) {
                                setState(() {
                                  filterbussinessshops = getxcontroller.business
                                      .where((element) => (element.businessName
                                          .toString()
                                          .toLowerCase()
                                          .trim()
                                          .contains(_controller.text
                                              .toString()
                                              .toLowerCase()
                                              .trim())))
                                      .toList();
                                  if (filterbussinessshops!.isEmpty) {
                                    searchlist.clear();
                                  } else {
                                    searchlist.add("1");
                                  }
                                });
                              }),
                              const Spacer(),
                              // _buildFilterButton(context, viewModel),
                            ],
                          ),
                          buildVerticleSpace(12),
                          // Row(
                          //   children: viewModel.selectedFilters
                          //       .map(
                          //         (filter) => Padding(
                          //           padding: EdgeInsets.only(
                          //             right: getProportionateScreenWidth(10),
                          //           ),
                          //           child: Chip(
                          //             backgroundColor: ColorManager.secondaryLight
                          //                 .withOpacity(0.15),
                          //             deleteIconColor: ColorManager.icon,
                          //             padding: EdgeInsets.only(
                          //               left: getProportionateScreenWidth(20),
                          //             ),
                          //             labelPadding: EdgeInsets.zero,
                          //             label: kTextBentonSansMed(
                          //               filter,
                          //               fontSize: getProportionateScreenHeight(12),
                          //               color: ColorManager.icon,
                          //             ),
                          //             deleteIcon: Icon(
                          //               Icons.close,
                          //               size: getProportionateScreenHeight(16),
                          //             ),
                          //             onDeleted: () {
                          //               viewModel.selectFilter(filter);
                          //             },
                          //           ),
                          //         ),
                          //       )
                          //       .toList(),
                          // ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomChipWidget(text: 'Popular'),
                          ),
                        ],
                      ),
                    ),
                    searchlist.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height - 600,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Center(
                                  child: Text(
                                    "No Shop Nearby Found",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(24),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: filterbussinessshops!.length,
                                  separatorBuilder: (context, index) =>
                                      buildVerticleSpace(10),
                                  padding: EdgeInsets.only(
                                    bottom: getProportionateScreenHeight(100),
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      CustomListTileWidget(
                                    leading: Image.asset(AppImages.menu),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        kTextBentonSansMed(
                                          "${filterbussinessshops![index].businessName}",
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          overFlow: TextOverflow.ellipsis,
                                        ),
                                        // buildVerticleSpace(3),
                                        kTextBentonSansReg(
                                          filterbussinessshops![index]
                                                  .category
                                                  ?.title ??
                                              "Candy",
                                          color: ColorManager.textGrey
                                              .withOpacity(0.8),
                                          letterSpacing:
                                              getProportionateScreenWidth(0.5),
                                        ),
                                        // buildVerticleSpace(3),
                                        kTextBentonSansReg(
                                          '${double.parse("${filterbussinessshops![index].distance}").toStringAsFixed(2)}km away',
                                          color: ColorManager.textGrey
                                              .withOpacity(0.8),
                                          fontSize:
                                              getProportionateScreenHeight(10),
                                          letterSpacing:
                                              getProportionateScreenWidth(0.5),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            filterbussinessshops![index]
                                                        .isFavourite !=
                                                    true
                                                ? getxcontroller.addToFavourite(
                                                    filterbussinessshops![index]
                                                        .id)
                                                : getxcontroller
                                                    .deleteFromFavourite(
                                                        filterbussinessshops![
                                                                index]
                                                            .id);
                                            var bools =
                                                filterbussinessshops![index]
                                                            .isFavourite ==
                                                        true
                                                    ? false
                                                    : true;
                                            // getxcontroller.toggleFav(
                                            //     filterbussinessshops![index].id
                                            //         as int,
                                            //     filterbussinessshops![index]
                                            //         .isFavourite as bool);
                                            filterbussinessshops![index]
                                                .isFavourite = bools;
                                            setState(() {});
                                          },
                                          splashColor: ColorManager.transparent,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Icon(
                                              filterbussinessshops![index]
                                                      .isFavourite!
                                                  ? Icons.favorite_rounded
                                                  : Icons
                                                      .favorite_border_rounded,
                                              size:
                                                  getProportionateScreenHeight(
                                                      20),
                                              color: ColorManager.error),
                                        ),
                                        const Spacer(),
                                        AppButtonWidget(
                                          ontap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  ColorManager.transparent,
                                              builder: (ctx) => ShopDetailsView(
                                                  businessModel:
                                                      filterbussinessshops![
                                                          index]),
                                            );
                                          },
                                          height:
                                              getProportionateScreenHeight(26),
                                          width:
                                              getProportionateScreenWidth(72),
                                          borderRadius:
                                              getProportionateScreenHeight(9),
                                          text: 'Detail',
                                          textSize:
                                              getProportionateScreenHeight(10),
                                          letterSpacing:
                                              getProportionateScreenWidth(0.5),
                                        ),
                                        buildVerticleSpace(0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              : Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
    });
  }

  Widget _buildFilterButton(BuildContext context, HomeViewModel viewModel) {
    return PopupMenuButton(
      offset: Offset(
        getProportionateScreenWidth(0),
        getProportionateScreenHeight(50),
      ),
      padding: EdgeInsets.zero,
      icon: Container(
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
        child: Image.asset(
          AppIcons.filterIcon,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      itemBuilder: (context) {
        return viewModel.filterList
            .map(
              (e) => PopupMenuItem(
                child: Text(e),
                onTap: () => viewModel.selectFilter(e),
              ),
            )
            .toList();
      },
    );
  }

  Widget _buildSearchField(TextEditingController controller, function(e)) {
    return TextFormField(
      onChanged: function,
      controller: controller,
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

// class SearchRow extends StatelessWidget {
//   const SearchRow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _buildSearchField(),
//         const Spacer(),
//         _buildFilterButton(context),
//       ],
//     );
//   }

// }
