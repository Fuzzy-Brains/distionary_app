import 'dart:async';
import 'dart:convert';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dictionary_app/constants.dart';
import 'package:dictionary_app/screens/dashboard_view.dart';
import 'package:dictionary_app/screens/dictionary_view.dart';
import 'package:dictionary_app/screens/notification_view.dart';
import 'package:dictionary_app/screens/profile_view.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_remix_icons/flutter_remix_icons.dart';
import 'package:dictionary_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int _bottomNavIndex = 0;
  List<IconData> icons = [
    RemixIcons.home2Fill,
    RemixIcons.bookOpenFill,
    RemixIcons.notificationFill,
    RemixIcons.group2Fill
  ];

  StreamController? _streamController;
  Stream? _stream;

  final String _url = 'https://owlbot.info/api/v4/dictionary/';
  final String _token = '485c8dde628df764c6d8ceecd3deb1c553a58257';

  @override
  initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController!.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.menu),
        onPressed: (){

        },
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeIndex: _bottomNavIndex,
        icons: icons,
        backgroundColor: primaryColor,
        activeColor: Colors.white,
        inactiveColor: Color.fromRGBO(154, 154, 154, 1),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index){
          setState(() {
            _bottomNavIndex = index;
          });
          pageController.jumpToPage(_bottomNavIndex);
        },
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        // leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text(
          'Dictionary App',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (val){
          setState(() => _bottomNavIndex = val);
        },
        children: [
          DashboardView(),
          DictionaryView(),
          NotificationView(),
          ProfileView()
        ],
      ),
    );
  }
}
