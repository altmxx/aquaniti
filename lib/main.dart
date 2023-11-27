import 'dart:developer';

import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/auth/screens/signIn_screen.dart';
import 'package:aquaniti/features/auth/services/authProvider.dart';
import 'package:aquaniti/features/auth/services/signIn_provider.dart';
import 'package:aquaniti/features/camera/cameras.dart';
import 'package:aquaniti/features/home/screens/main_screen.dart';
import 'package:aquaniti/features/home/services/home_services.dart';
import 'package:aquaniti/features/insights/services/insightsProvider.dart';
import 'package:aquaniti/features/localization/locale_constants.dart';
import 'package:aquaniti/features/marketplace/services/marketplace_service.dart';
import 'package:aquaniti/firebase_options.dart';
import 'package:aquaniti/router.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/dashboard/services/dashboard_provider.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // log(cameras.toString());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => SignInProvider()),
    ChangeNotifierProvider(create: (ctx) => AuthenticationProvider()),
    ChangeNotifierProvider(create: (ctx) => CameraScanProvider()),
    ChangeNotifierProvider(
        create: (ctx) =>
            InsightsProvider(FirebaseAuth.instance.currentUser?.uid)),
    ChangeNotifierProvider(create: (ctx) => HomeProvider()),
    ChangeNotifierProvider(create: (ctx) => DashboardProvider()),
    ChangeNotifierProvider(create: (ctx) => MarketplaceProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  bool isAuth = false;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance()
        .then((value) => isAuth = value.getBool("isAuthenticated") ?? false);
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      builder: ((context, child) {
        return MaterialApp(
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Poppins",
            colorScheme:
                ColorScheme.fromSeed(seedColor: GlobalVariables.primaryColor),
            useMaterial3: true,
          ),
          home: isAuth ? const MainScreen() : const SignInScreen(),
          onGenerateRoute: (settings) => generateRoute(settings),
        );
      }),
    );
  }
}
