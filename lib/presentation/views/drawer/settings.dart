import 'package:flutter/material.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/src/assets_manager.dart';
import 'package:sehr/presentation/src/colors_manager.dart';

class settingsPage extends StatelessWidget {
  const settingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.pattern2,
            color: ColorManager.primary.withOpacity(0.1),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const TopBackButtonWidget(),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: const [
                      Text(
                        "Générale",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9CA4AB)),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: listtilecustom("Notification", Icons.notifications),
                ),
                const Divider(
                  thickness: 1,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const LanguagesPage()),
                    // );
                  },
                  child: listtilecustom("languages", Icons.language),
                ),
                const Divider(
                  thickness: 1,
                ),
                listtilecustom("Preference", Icons.message),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: const [
                      Text(
                        "Security",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9CA4AB)),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.biotech),
                  trailing: Switch(
                    onChanged: (s) {},
                    value: true,
                    activeColor: const Color(0xffEFEFEF),
                    activeTrackColor: const Color(0xff4698B4),
                  ),
                  title: const Text(
                    "bio",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                listtilecustom("Change Password", Icons.password),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

listtilecustom(String title, IconData iconData) {
  return ListTile(
    dense: true,
    leading: Icon(iconData),
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );
}

listtilecustoms(String title, IconData iconData) {
  return ListTile(
    dense: true,
    leading: Icon(iconData),
    trailing: const Icon(Icons.message),
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );
}
