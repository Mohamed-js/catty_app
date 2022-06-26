import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/chatScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class StartConversionScreen extends StatefulWidget {
  final Map animal;
  const StartConversionScreen(this.animal);
  @override
  State<StartConversionScreen> createState() => _StartConversionScreenState();
}

class _StartConversionScreenState extends State<StartConversionScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _StartConversionScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, child) {
      return SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: g.scaffoldBackgroundGradientColors,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      g.isDarkModeEnable
                          ? 'assets/images/startdatingimg.png'
                          : 'assets/images/startdatingimg.png',
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Text(AppLocalizations.of(context).lbl_congrats,
                        style: Theme.of(context).primaryTextTheme.headline1),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        AppLocalizations.of(context).lbl_its_match,
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                          "${widget.animal['user']['first_name'][0].toUpperCase()}${widget.animal['user']['first_name'].substring(1).toLowerCase()} and You both Liked each other's animals",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.subtitle2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${auth.current_user['animals'][0]['avatars'][0]['url']}'),
                            radius: 32,
                          ),
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Transform.rotate(
                                      angle: 20 * math.pi / 180,
                                      child: Icon(
                                        Icons.favorite,
                                        color: Color.fromARGB(253, 218, 42, 10),
                                      ))),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Transform.rotate(
                                      angle: -20 * math.pi / 180,
                                      child: Icon(
                                        Icons.favorite,
                                        color: Color.fromARGB(253, 218, 42, 10),
                                      ))),
                            ],
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${widget.animal['avatars'][0]['url']}'),
                            radius: 32,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: IconButton(
                              iconSize: 30,
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                MdiIcons.messageReplyTextOutline,
                                color: Color.fromARGB(510, 46, 49, 146),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationWidgetLight(
                                              currentIndex: 2,
                                            )),
                                    ModalRoute.withName('/'));
                              },
                              child: Text(
                                'Start conversation now!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20, bottom: 20, right: 10),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Keep Matching',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    appState.getChats();
    appState.getNotifications();
  }
}
