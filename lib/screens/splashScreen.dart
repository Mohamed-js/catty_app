import 'dart:async';
import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/provider/local_provider.dart';
import 'package:datingapp/screens/addStoryScreen.dart';
import 'package:datingapp/screens/introScreen.dart';
import 'package:datingapp/screens/profileDetailScreen.dart';
import 'package:datingapp/screens/startDatingScreen.dart';
import 'package:datingapp/services/auth.dart';
import 'package:datingapp/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends BaseRoute {
  SplashScreen({a, o}) : super(a: a, o: o, r: 'SplashScreen');
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _SplashScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Colors.red[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                g.isDarkModeEnable
                    ? 'assets/images/splashydog.png'
                    : 'assets/images/splashydog.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * .5),
            SizedBox(height: 20),
            Image.asset('assets/images/pets_logo2.png',
                width: MediaQuery.of(context).size.width * .5),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final auth = Provider.of<Auth>(context, listen: false);
      await auth.tryLogin(false);
      startTime(auth.authenticated);
    });
  }

  startTime(loggedIn) {
    try {
      var _duration = new Duration(seconds: 3);
      return new Timer(_duration, () {
        if (loggedIn) {
          Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationWidgetLight(
                                            currentIndex: 0,
                            
                                          )),
                                  ModalRoute.withName('/'));
        } else {
          Navigator.pushAndRemoveUntil(
            context,
              MaterialPageRoute(builder: (context) => StartDatingScreen()), ModalRoute.withName('/'));
        }
      });
    } catch (e) {
      print('Exception SplashScreen.dart - startTime() ' + e.toString());
    }
  }

  _init() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        if (g.languageCode == null) {
          var locale = provider.locale ?? Locale('en');
          g.languageCode = locale.languageCode;
        } else {
          provider.setLocale(Locale(g.languageCode));
        }
        if (g.rtlLanguageCodeLList.contains(g.languageCode)) {
          g.isRTL = true;
        } else {
          g.isRTL = false;
        }
      });
    } catch (e) {
      print('Exception SplashScreen.dart - _init() ' + e.toString());
    }
  }
}
