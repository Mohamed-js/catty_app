import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/startDatingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroScreen extends BaseRoute {
  IntroScreen({a, o}) : super(a: a, o: o, r: 'IntroScreen');
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _IntroScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 140),
                      child: Image.asset(
                        g.isDarkModeEnable
                            ? 'assets/images/dog.png'
                            : 'assets/images/dog.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StartDatingScreen(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20, bottom: 20, right: 5),
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: g.gradientColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          AppLocalizations.of(context).lbl_get_started,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.longArrowAltRight,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }
}
