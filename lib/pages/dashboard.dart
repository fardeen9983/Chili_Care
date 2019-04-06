import 'package:flutter/material.dart';
import '../icons/bottom_nav_icon.dart';
import 'package:bmnav/bmnav.dart';
import 'scan_page.dart';
import 'plan_page.dart';
import 'community_page.dart';
import 'history_page.dart';
import '../localization/app_translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int index = 0;
  List<Widget> pages;
  AppTranslations translations;
  SharedPreferences prefs;
  String locale = "en";
  bool loaded = false;
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) =>
        loaded
            ? Scaffold(
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                      accountName: null, accountEmail: null),
                  GestureDetector(
                    onTap: null,
                    child: ListTile(
                      leading: Icon(BottomNavIcon.plan),
                      title: Text(
                        translations.text("plan"),
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: null,
                    child: ListTile(
                      leading: Icon(BottomNavIcon.scan),
                      title: Text(
                        AppTranslations.of(context).text("scan"),
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: null,
                    child: ListTile(
                      leading: Icon(BottomNavIcon.guide),
                      title: Text(
                        AppTranslations.of(context).text("guide"),
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: null,
                    child: ListTile(
                      leading: Icon(BottomNavIcon.home),
                      title: Text(
                        AppTranslations.of(context).text("history"),
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text(
                translations.text("home"),
                style: TextStyle(fontSize: 18.0),
              ),
              centerTitle: true,
              backgroundColor: Color.fromRGBO(0, 109, 179, 100),
              actions: <Widget>[
                FlatButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/settings"),
                    child: Icon(Icons.settings))
              ],
            ),
            body: pages[index],
            bottomNavigationBar: BottomNav(
              index: index,
              onTap: (i) {
                index = i;
                setState(() {});
              },
              items: <BottomNavItem>[
                BottomNavItem(
                  BottomNavIcon.home,
                  label: "",
                ),
                BottomNavItem(
                  BottomNavIcon.guide,
                  label: "",
                ),
                BottomNavItem(
                  BottomNavIcon.scan,
                  label: "",
                ),
                BottomNavItem(
                  BottomNavIcon.plan,
                  label: "",
                ),
              ],
            ))
            : Container(
          child: Center(child: CircularProgressIndicator()),
        ));
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      this.prefs = prefs;
      locale = prefs.getString("locale");
      if (locale == null)
        locale = "en";
      translations = await AppTranslations.load(Locale(locale, ""));
      loaded = true;
      setState(() {});
    });
    pages = List();
    pages.add(PlanPage());
    pages.add(CommunityPage());
    pages.add(ScanPage());
    pages.add(HistoryPage());
  }
}
