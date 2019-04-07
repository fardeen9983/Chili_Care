import 'package:flutter/material.dart';
import '../application.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  SharedPreferences prefs;
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2]
  };

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) => this.prefs = prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select language",
        ),
      ),
      body: _buildLanguagesList(),
    );
  }

  _buildLanguagesList() {
    return ListView.builder(
      itemCount: languagesList.length,
      itemBuilder: (context, index) {
        return _buildLanguageItem(languagesList[index]);
      },
    );
  }

  _buildLanguageItem(String language) {
    return InkWell(
      onTap: () {
        prefs.setString("locale", languagesMap[language]);
        application.onLocaleChanged(Locale(languagesMap[language]));
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            language,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
