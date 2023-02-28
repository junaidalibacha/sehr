import 'package:sehr/app/index.dart';

import '../../../src/index.dart';

class PaymentWidget<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const PaymentWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        height: getProportionateScreenHeight(73),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.white : ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(22),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              label,
              height: getProportionateScreenHeight(23),
              width: getProportionateScreenWidth(110),
            ),
            const Spacer(),
            kTextBentonSansReg(text),
          ],
        ),
      ),
    );
  }
}
