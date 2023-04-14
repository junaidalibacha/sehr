import 'package:sehr/app/index.dart';

class NotificationController extends GetxController {
  var notificationlist = <dynamic>[].obs;
  var postloading = true.obs;
  bool dontshowfirsttime = false;
  callNotifications(List datalist, BuildContext context) async {
    try {
      postloading.value = true;
      var streamLength = await listData(datalist);
      // print(dontshowfirsttime);
      if (streamLength == notificationlist.length ||
          streamLength < notificationlist.length) {
      } else {
        if (dontshowfirsttime == true) {
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("New Order"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 60,
                      )
                    ],
                  ),
                );
              });
        }
      }
      dontshowfirsttime = true;
      notificationlist.assignAll(datalist);
    } finally {
      postloading.value = false;
    }

    update();
  }

  listData(List datalist) {
    return datalist.length;
  }

  shownotification() {}
}
