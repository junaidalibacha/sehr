import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/routes/routes.dart';
import 'package:sehr/presentation/src/colors_manager.dart';
import 'package:sehr/presentation/views/business_views/services.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/profile/add_bio/add_business_details_view.dart';
import 'package:sehr/presentation/views/profile/add_bio/business_verification/business_verification_processing_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckBussinessValidate extends StatefulWidget {
  const CheckBussinessValidate({super.key});

  @override
  State<CheckBussinessValidate> createState() => _CheckBussinessValidateState();
}

class _CheckBussinessValidateState extends State<CheckBussinessValidate> {
  Map<String, dynamic>? data;
  bool notapprove = true;

  bussinessvalidatechecker() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data = await getpaymentsdata();
    prefs.remove("sehrCode");
    prefs.remove("isverified");

    if (data != null) {
      if (data!["sehrCode"].toString() != "null") {
        String sehrcode = prefs.getString("sehrcode").toString();
        if (sehrcode == "null") {
          prefs.setString("sehrcode", data!["sehrCode"].toString());
        }
        prefs.remove("userRole");
        prefs.setString("userRole", "business");
        prefs.remove("isverified");
        prefs.setString("isverified", "true");

        prefs.remove("openbussiness");
        prefs.setString("openbussiness", "true");
        Get.offAll(() => const DrawerView());
      } else {
        Get.offAll(() => const BusinessVerificationProcessingView());
      }
    } else {
      Get.offAll(() => const AddBusinessDetailsView());
    }
  }

  @override
  void initState() {
    bussinessvalidatechecker();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: notapprove == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset("assets/images/process.png"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Your Request is under review , is not accepted yet, Please Wait",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.offAll(() => const DrawerView());
                      },
                      child: Container(
                        color: ColorManager.primary,
                        height: 40,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
