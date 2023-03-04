// import 'package:sehr/app/index.dart';
// import 'package:sehr/presentation/index.dart';

// extension BuildSize on num {
//   SizedBox get sh => SizedBox(height: getProportionateScreenHeight(inputHeight));

//   SizedBox get sw => SizedBox(width: toDouble());
// }
extension Toggle on bool {
  bool toggle() => !this;
}
