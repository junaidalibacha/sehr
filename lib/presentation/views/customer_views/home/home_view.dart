import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/customer_view_models/home_view_model.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/custom_chip_widget.dart';
import '../../../common/custom_card_widget.dart';
import '../../../src/index.dart';
import '../shop/shop_details_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) => Column(
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
                      _buildSearchField(),
                      const Spacer(),
                      _buildFilterButton(context, viewModel),
                    ],
                  ),
                  buildVerticleSpace(12),
                  Row(
                    children: viewModel.selectedFilters
                        .map(
                          (filter) => Padding(
                            padding: EdgeInsets.only(
                              right: getProportionateScreenWidth(10),
                            ),
                            child: Chip(
                              backgroundColor:
                                  ColorManager.secondaryLight.withOpacity(0.15),
                              deleteIconColor: ColorManager.icon,
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(20),
                              ),
                              labelPadding: EdgeInsets.zero,
                              label: kTextBentonSansMed(
                                filter,
                                fontSize: getProportionateScreenHeight(12),
                                color: ColorManager.icon,
                              ),
                              deleteIcon: Icon(
                                Icons.close,
                                size: getProportionateScreenHeight(16),
                              ),
                              onDeleted: () {
                                viewModel.selectFilter(filter);
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomChipWidget(text: 'Popular'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(24),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: viewModel.business!.length,
                    separatorBuilder: (context, index) =>
                        buildVerticleSpace(10),
                    padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(100),
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CustomListTileWidget(
                      leading: Image.asset(viewModel.shops[index].shopImage),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          kTextBentonSansMed(
                            "${viewModel.business?[index].businessName}",
                            fontSize: getProportionateScreenHeight(15),
                            overFlow: TextOverflow.fade,
                          ),
                          // buildVerticleSpace(3),
                          kTextBentonSansReg(
                            viewModel.business?[index].category?.title ??
                                "Candy",
                            color: ColorManager.textGrey.withOpacity(0.8),
                            letterSpacing: getProportionateScreenWidth(0.5),
                          ),
                          // buildVerticleSpace(3),
                          kTextBentonSansReg(
                            '${double.parse("${viewModel.business?[index].distance}").toStringAsFixed(2)}km away',
                            color: ColorManager.textGrey.withOpacity(0.8),
                            fontSize: getProportionateScreenHeight(10),
                            letterSpacing: getProportionateScreenWidth(0.5),
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          InkWell(
                            onTap: () => viewModel.toggleFav(index),
                            splashColor: ColorManager.transparent,
                            borderRadius: BorderRadius.circular(40),
                            child: Icon(
                              viewModel.business![index].isFavourite!
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: getProportionateScreenHeight(20),
                              color: viewModel.shops[index].isFavourite
                                  ? ColorManager.error
                                  : null,
                            ),
                          ),
                          const Spacer(),
                          AppButtonWidget(
                            ontap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: ColorManager.transparent,
                                builder: (ctx) => ShopDetailsView(
                                    businessModel: viewModel.business![index]),
                              );
                            },
                            height: getProportionateScreenHeight(26),
                            width: getProportionateScreenWidth(72),
                            borderRadius: getProportionateScreenHeight(18),
                            text: 'Detail',
                            textSize: getProportionateScreenHeight(12),
                            letterSpacing: getProportionateScreenWidth(0.5),
                          ),
                          buildVerticleSpace(5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildSearchField() {
    return TextFormField(
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

  // Widget _buildFilterButton() {
  //   return Container(
  //     height: getProportionateScreenHeight(50),
  //     width: getProportionateScreenHeight(50),
  //     padding: EdgeInsets.all(
  //       getProportionateScreenHeight(13),
  //     ),
  //     decoration: BoxDecoration(
  //       color: ColorManager.secondaryLight.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(
  //         getProportionateScreenHeight(15),
  //       ),
  //     ),
  //     child: IconButton(
  //       splashColor: ColorManager.transparent,
  //       splashRadius: getProportionateScreenHeight(30),
  //       padding: EdgeInsets.zero,
  //       onPressed: () {},
  //       icon: Image.asset(
  //         AppIcons.filterIcon,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSearchField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       filled: true,
  //       fillColor: ColorManager.secondaryLight.withOpacity(0.1),
  //       constraints: BoxConstraints(
  //         maxHeight: getProportionateScreenHeight(50),
  //         maxWidth: getProportionateScreenWidth(280),
  //       ),
  //       contentPadding: EdgeInsets.zero,
  //       border: OutlineInputBorder(
  //         borderSide: BorderSide.none,
  //         borderRadius: BorderRadius.circular(
  //           getProportionateScreenHeight(15),
  //         ),
  //       ),
  //       prefixIcon: Padding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: getProportionateScreenWidth(18),
  //           vertical: getProportionateScreenHeight(13),
  //         ),
  //         child: Image.asset(AppIcons.searchIcon),
  //       ),
  //       hintText: 'What do you want to order?',
  //       hintStyle: TextStyleManager.regularTextStyle(
  //         color: ColorManager.icon.withOpacity(0.4),
  //         fontSize: getProportionateScreenHeight(12),
  //       ),
  //     ),
  //   );
  // }
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
