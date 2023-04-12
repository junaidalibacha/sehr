import '../../app/index.dart';
import '../src/index.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.controller,
    this.maxlines,
    this.keyboardType,
    this.focusNode,
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.obscureText = false,
    this.fillColor,
    this.blurRadius,
    this.onChange,
    this.onFieldSubmit,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final int? maxlines;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool obscureText;
  final Color? fillColor;
  final double? blurRadius;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onChange;
  final void Function(String? value)? onFieldSubmit;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getProportionateScreenHeight(60),
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
        focusNode: focusNode,
        readOnly: readOnly!,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyleManager.regularTextStyle(
          fontSize: getProportionateScreenHeight(14),
          letterSpacing: getProportionateScreenHeight(0.5),
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          errorStyle: TextStyleManager.regularTextStyle(
            fontSize: getProportionateScreenHeight(12),
            color: ColorManager.error,
          ),
          // errorText: null,
          filled: true,
          fillColor: fillColor ?? ColorManager.white,
          hintText: hintText,
          hintStyle: TextStyleManager.regularTextStyle(
            fontSize: getProportionateScreenHeight(14),
            color: ColorManager.textGrey.withOpacity(0.3),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
              getProportionateScreenHeight(15),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          // errorBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: ColorManager.error,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     getProportionateScreenHeight(15),
          //   ),
          // ),
          // constraints: BoxConstraints(
          //   maxHeight: getProportionateScreenHeight(60),
          // ),
        ),
        validator: validator,
        onChanged: onChange,
        onFieldSubmitted: onFieldSubmit,
      ),
    );
  }
}
