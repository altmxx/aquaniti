import 'dart:developer';

import 'package:aquaniti/constants/global_variables.dart';
import 'package:aquaniti/features/auth/services/authProvider.dart';
import 'package:aquaniti/features/auth/services/signIn_provider.dart';
import 'package:aquaniti/features/camera/cameras.dart';
import 'package:aquaniti/features/home/screens/main_screen.dart';
import 'package:aquaniti/features/home/services/home_services.dart';
import 'package:aquaniti/features/insights/services/insightsProvider.dart';
import 'package:aquaniti/features/localization/locale_constants.dart';
import 'package:aquaniti/firebase_options.dart';
import 'package:aquaniti/router.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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
    ChangeNotifierProvider(create: (ctx) => AuthProvider()),
    ChangeNotifierProvider(create: (ctx) => CameraScanProvider()),
    ChangeNotifierProvider(create: (ctx) => InsightsProvider()),
    ChangeNotifierProvider(create: (ctx) => HomeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // static _MyAppState? of(BuildContext context) =>
  //     context.findAncestorStateOfType<_MyAppState>();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
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
    // var prefs = SharedPreferences.getInstance();
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      builder: ((context, child) {
        // log(_locale.toString());
        return MaterialApp(
          // supportedLocales: [],
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // localeListResolutionCallback: (locale,supportedLocales){
          //   for(var supportedLocale in supportedLocales){
          //     if(supportedLocale.languageCode == locale.)
          //   }
          // },

          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Poppins",
            colorScheme:
                ColorScheme.fromSeed(seedColor: GlobalVariables.primaryColor),
            useMaterial3: true,
          ),
          // home: StreamBuilder<User?>(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Scaffold(
          //         body: Center(
          //           child: Text('Adasd'),
          //         ),
          //       );
          //     } else if (snapshot.hasData) {
          //       WidgetsBinding.instance.addPostFrameCallback((_) {
          //         Navigator.of(context)
          //             .pushReplacementNamed(HomeScreen.routeName);
          //       });
          //       return const SizedBox(
          //         child: Text("Not Working"),
          //       );
          //     } else {
          //       return const SignInScreen();
          //     }
          //   },
          // ),
          home: const MainScreen(),
          onGenerateRoute: (settings) => generateRoute(settings),
        );
      }),
    );
  }
}