import 'package:sehr/app/index.dart';

import '../../../common/app_button_widget.dart';
import '../../../common/custom_card_widget.dart';
import '../../../src/index.dart';
import '../../../view_models/customer_view_models/home_view_model.dart';
import '../shop/shop_details_view.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

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
            child: Row(
              children: [
                _buildSearchField(),
                const Spacer(),
                _buildFilterButton(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(40),
                vertical: getProportionateScreenHeight(10),
              ),
              child: kTextBentonSansReg(
                'Favorite',
                fontSize: getProportionateScreenHeight(15),
              ),
            ),
          ),
          // buildVerticleSpace(10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24),
                ),
                child: Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) => ListView.separated(
                    shrinkWrap: true,
                    itemCount: viewModel.favItems.length,
                    separatorBuilder: (context, index) =>
                        buildVerticleSpace(10),
                    padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(100),
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CustomListTileWidget(
                      leading: Image.asset(viewModel.favItems[index].shopImage),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          kTextBentonSansMed(
                            viewModel.favItems[index].shopName,
                            fontSize: getProportionateScreenHeight(15),
                          ),
                          // buildVerticleSpace(3),
                          kTextBentonSansReg(
                            viewModel.favItems[index].shopCategory,
                            color: ColorManager.textGrey.withOpacity(0.8),
                            letterSpacing: getProportionateScreenWidth(0.5),
                          ),
                          // buildVerticleSpace(3),
                          kTextBentonSansReg(
                            '8km away',
                            color: ColorManager.textGrey.withOpacity(0.8),
                            fontSize: getProportionateScreenHeight(10),
                            letterSpacing: getProportionateScreenWidth(0.5),
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          InkWell(
                            // onTap: () => viewModel.toggleFav(index),
                            splashColor: ColorManager.transparent,
                            borderRadius: BorderRadius.circular(40),
                            child: Icon(
                              Icons.favorite_rounded,
                              size: getProportionateScreenHeight(20),
                              color: ColorManager.error,
                            ),
                          ),
                          const Spacer(),
                          AppButtonWidget(
                            ontap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: ColorManager.transparent,
                                builder: (ctx) => Container(),
                              );
                            },
                            height: getProportionateScreenHeight(26),
                            width: getProportionateScreenWidth(72),
                            borderRadius: getProportionateScreenHeight(18),
                            text: 'dsdsdsd',
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
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
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
        onPressed: () {},
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
