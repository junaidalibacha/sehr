import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';

class ApproveDriver extends StatelessWidget {
  const ApproveDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.blue,
                            shape: BoxShape.circle),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                              child: const Center(
                                child: Icon(
                                  Icons.done,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Order Placed",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff2F2E2E)),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20),
              child: Text(
                "Order Placed Successfully, check out the status of order",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff746F6F),
                    fontSize: 17,
                    fontFamily: "Montserrat"),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            MaterialButton(
              onPressed: () {
                Get.offAll(() => const DrawerView());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff4698B4),
                    borderRadius: BorderRadius.circular(10)),
                width: 353,
                height: 52,
                child: const Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
