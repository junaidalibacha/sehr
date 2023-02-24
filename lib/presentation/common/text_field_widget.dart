import '../../app/index.dart';
import '../index.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.obscureText = false,
    this.fillColor,
    this.blurRadius,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool obscureText;
  final Color? fillColor;
  final double? blurRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(15),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: blurRadius ?? getProportionateScreenHeight(15),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyleManager.regularTextStyle(
          fontSize: getProportionateScreenHeight(14),
          letterSpacing: getProportionateScreenHeight(0.5),
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? ColorManager.white,
          hintText: hintText,
          hintStyle: TextStyleManager.regularTextStyle(
            fontSize: getProportionateScreenHeight(14),
            color: ColorManager.textGrey.withOpacity(0.3),
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(16),
                    top: getProportionateScreenWidth(16),
                    bottom: getProportionateScreenWidth(16),
                  ),
                  child: prefixIcon,
                )
              : null,
          suffixIcon: sufixIcon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(16),
                  ),
                  child: sufixIcon,
                )
              : null,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
              getProportionateScreenHeight(15),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: getProportionateScreenHeight(60),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(28),
          ),
        ),
      ),
    );
  }
}
