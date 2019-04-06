import 'package:flutter/material.dart';
import '../icons/bottom_nav_icon.dart';
import 'package:bmnav/bmnav.dart';
import 'scan_page.dart';
import 'plan_page.dart';
import 'community_page.dart';
import 'history_page.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int index = 0;
  List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UserAccountsDrawerHeader(accountName: null, accountEmail: null),
              GestureDetector(
                onTap: null,
                child: ListTile(
                  leading: Icon(BottomNavIcon.plan),
                  title: Text(
                    "Plan",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: null,
                child: ListTile(
                  leading: Icon(BottomNavIcon.scan),
                  title: Text(
                    "Scan",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: null,
                child: ListTile(
                  leading: Icon(BottomNavIcon.guide),
                  title: Text(
                    "Guide",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: null,
                child: ListTile(
                  leading: Icon(BottomNavIcon.home),
                  title: Text(
                    "History",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(fontSize: 18.0),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 109, 179, 100),
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
              label: "HOME",
            ),
            BottomNavItem(BottomNavIcon.guide, label: "GUIDE"),
            BottomNavItem(BottomNavIcon.scan, label: "SCAN"),
            BottomNavItem(BottomNavIcon.plan, label: "PLAN"),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    pages = List();
    pages.add(PlanPage());
    pages.add(CommunityPage());
    pages.add(ScanPage());
    pages.add(HistoryPage());
  }
}
