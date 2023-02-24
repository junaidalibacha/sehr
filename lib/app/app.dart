import 'package:flutter/services.dart';
import 'package:sehr/presentation/views/auth/auth_view_model.dart';

import '../presentation/index.dart';
import 'index.dart';

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp._internal();
  static const MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    // WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthViewModel()),
        // ChangeNotifierProvider(create: (ctx) => ShopDataModel()),
      ],
      child: GetMaterialApp(
        builder: (context, child) {
          SizeConfig().init(context);
          return Theme(data: ThemeData(), child: child!);
        },
        debugShowCheckedModeBanner: false,
        // theme: getAppTheme(context),
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        // initialRoute: Routes.bottomNavigationRoute,
      ),
    );
  }
}
