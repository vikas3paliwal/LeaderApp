// import 'package:Leader/localization/app_localization.dart';
import 'package:Leader/models/business.dart';
import 'package:Leader/providers/budget_provider.dart';
import 'package:Leader/providers/customers.dart';
import 'package:Leader/providers/labels.dart';
import 'package:Leader/providers/tasks.dart';
import 'package:Leader/screens/OnBoarding/on_boarding.dart';
import 'package:Leader/screens/add_business_screen.dart';
// import 'package:Leader/screens/Signup/signup_screen.dart';
import 'package:Leader/screens/home_screen.dart';
// import 'package:Leader/screens/leads_screen.dart';
import 'package:Leader/screens/splashScreen.dart';
import 'package:Leader/utilities/api-response.dart';
// import 'package:Leader/screens/login_screen.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translation',
      supportedLocales: [
        Locale('en', 'US'),
        Locale('hi', 'IND'),
      ],
      saveLocale: true,
      startLocale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Labels(),
        ),
        ChangeNotifierProvider(
          create: (context) => Customers(),
        ),
        ChangeNotifierProvider(create: (context) => Tasks()),
        ChangeNotifierProvider(create: (context) => Business()),
        ChangeNotifierProvider(
          create: (context) => BudgetProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          buttonColor: Color.fromRGBO(242, 138, 48, 1),
          primaryColor: Color.fromRGBO(89, 87, 117, 1.0),
          accentColor: Color.fromRGBO(84, 103, 143, 1),
          fontFamily: 'Poppins',
          // Color.fromRGBO(171, 166, 191, 1.0),
          canvasColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            button: TextStyle(color: Color(0xFF252525)),
            headline5: TextStyle(
              fontSize: 20.0,
            ),
            headline4: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            headline2: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            headline1: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
            ),
            subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
            headline6: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            bodyText1: TextStyle(
              fontSize: 12.0,
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            caption: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        routes: {
          MyHomePage.routeName: (ctx) => MyHomePage(),
        },
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        home: FutureBuilder(
            future: ApiHelper().isLoggedIn(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return SplashScreen();
              else {
                if (snapshot.data == true) {
                  ApiResponse response;
                  return FutureBuilder(
                      future:
                          Future.delayed(Duration.zero).whenComplete(() async {
                        try {
                          response = await ApiHelper()
                              .getRequest(endpoint: 'leadgrow/business/');
                        } catch (e) {
                          
                          print(e);
                        }
                      }),
                      builder: (ctx, snap) =>
                          snap.connectionState == ConnectionState.waiting
                              ? SplashScreen()
                              : (response.data.length != 0
                                  ? MyHomePage()
                                  : AddBusinessDetailsScreen()));
                } else
                  return OnBoardingScreen();
              }
            }),
      ),
    );
  }
}
