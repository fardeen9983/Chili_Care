import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/dashboard.dart';
import 'pages/login_page.dart';
import 'pages/setting_page.dart';
import 'localization/app_translation_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'application.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) => this.prefs = prefs);
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: application.supportedLocales(),
      localizationsDelegates: [
        _newLocaleDelegate,
        const AppTranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      title: 'Flutter Demo',
      home: LoginPage(),
      routes: {
        "/dashboard": (context) => DashBoard(),
        "/settings": (context) => SettingsPage()
      },
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
//      if (prefs != null)
//        prefs.setString("locale", locale.languageCode);
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
