import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/views/customer_views/home/home_view_model.dart';

import '../../../common/custom_chip_widget.dart';
import '../../../common/shop_tile_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(23),
              vertical: getProportionateScreenHeight(13),
            ),
            child: Column(
              children: [
                // Row(
                //   children: [
                //     _buildSearchField(),
                //     const Spacer(),
                //     _buildFilterButton(),
                //   ],
                // ),
                const SearchRow(),
                buildVerticleSpace(12),
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
                child: Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) => ShopTileWidget(
                    // name: viewModel.shops[index].shopName,
                    // category: viewModel.shops[index].shopCategory,
                    // distance: '8km away',
                    // onFavourite: () => viewModel.toggleFav(index),
                    // onDetail: () {},
                    // isFavourite: viewModel.shops[index].isFavourite,
                    items: viewModel.shops,
                  ),
                ),
              ),
            ),
          ),
        ],
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

class SearchRow extends StatelessWidget {
  const SearchRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSearchField(),
        const Spacer(),
        _buildFilterButton(context),
      ],
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return Container(
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
      child: IconButton(
        splashColor: ColorManager.transparent,
        splashRadius: getProportionateScreenHeight(30),
        padding: EdgeInsets.zero,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Consumer<HomeViewModel>(
              builder: (context, viewModel, child) => AlertDialog(
                content: Column(
                  children: viewModel.filterList
                      .map(
                        (filter) => RadioListTile(
                          value: filter,
                          groupValue:
                              viewModel.selectedFilters.contains(filter),
                          onChanged: (value) => viewModel.selectFilter(
                            value.toString(),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
        icon: Image.asset(
          AppIcons.filterIcon,
        ),
      ),
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
}
