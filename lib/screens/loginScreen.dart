import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/LocationScreen.dart';
import 'package:PetsMating/screens/addStoryScreen1.dart';
import 'package:PetsMating/screens/profileDetailScreen.dart';
import 'package:PetsMating/screens/verifyOtpScreen.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginScreen extends BaseRoute {
  LoginScreen({a, o}) : super(a: a, o: o, r: 'LoginScreen');
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseRouteState {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String loginErr;
  String loginBtnText = "Submit";

  bool btnIsDisabled = false;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  _LoginScreenState() : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    AppLocalizations.of(context).lbl_login,
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                ),
                Text(
                  AppLocalizations.of(context).lbl_login_subtitle1,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
                Text(
                  AppLocalizations.of(context).lbl_login_subtitle2,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          padding: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable
                                  ? Colors.black
                                  : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 60,
                            child: TextFormField(
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                              controller: _emailController,
                              validator: (value) => value.isEmpty ||
                                      !value.contains('@') ||
                                      !value.contains('.')
                                  ? "Please enter valid email"
                                  : null,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 10.0,
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Color.fromARGB(141, 42, 6, 110)),
                                contentPadding:
                                    EdgeInsets.only(left: 60, top: 20),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Image.asset(
                                      //     'assets/images/flag1.png',
                                      //     fit: BoxFit.fitWidth,
                                      //     height: 15,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   '(+01)',
                                      //   style: Theme.of(context).primaryTextTheme.subtitle2,
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.email,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: VerticalDivider(
                                          thickness: 2,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SECOND INPUTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable
                                  ? Colors.black
                                  : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 60,
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                              controller: _passwordController,
                              validator: (value) => value.length < 6
                                  ? "Password is too short!"
                                  : null,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 10.0,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Color.fromARGB(141, 42, 6, 110)),
                                contentPadding:
                                    EdgeInsets.only(left: 60, top: 20),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.password,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: VerticalDivider(
                                          thickness: 2,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: g.gradientColors,
                    ),
                  ),
                  child: TextButton(
                    onPressed: btnIsDisabled
                        ? null
                        : () async {
                            setState(() {
                              btnIsDisabled = true;
                            });
                            print('trying to login...');
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loginBtnText = 'Loading..';
                              });
                              String device_name =
                                  Platform.isAndroid ? "android" : "ios";
                              Map creds = {
                                'email': _emailController.text,
                                'password': _passwordController.text,
                                'device_name': device_name,
                              };

                              dynamic canLogin = await Provider.of<Auth>(
                                      context,
                                      listen: false)
                                  .login(creds);
                              print(canLogin);
                              // adb reverse tcp:8000 tcp:8000

                              if (canLogin.isNotEmpty &&
                                  canLogin['message'] == null) {
                                setState(() {
                                  loginBtnText = 'Submit';
                                });
                                print('canLogin');
                                print(canLogin);
                                print('canLogin');
                                if (canLogin['verified'] == false) {
                                  print('redirect to OTPPPPPPPPPPPP');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VerifyOtpScreen()));
                                } else if (canLogin['first_name'] == null) {
                                  print('redirect to PROFILEEEEEEEEE ADD');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileDetailScreen()));
                                } else if (canLogin['longitude'] == null) {
                                  print('redirect to ADD LOCATIONNNNNN');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LocationScreen()));
                                } else {
                                  print('redirect to PROFILEEEEEEEEE');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationWidgetLight(
                                            currentIndex: 0,
                                          )));
                                }
                              } else if (canLogin is Map) {
                                setState(() {
                                  loginErr = canLogin['message'];
                                  loginBtnText = 'Submit';
                                });
                                if (loginErr ==
                                    'Please check your email for the OTP code.') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(loginErr),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VerifyOtpScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                } else if (loginErr ==
                                    'The provided credentials are incorrect.') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(loginErr),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(loginErr),
                                      backgroundColor: Colors.teal,
                                    ),
                                  );
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VerifyOtpScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                }
                              }
                            }
                            setState(() {
                              btnIsDisabled = false;
                            });
                          },
                    child: btnIsDisabled
                        ? LoadingIndicator(
                            indicatorType: Indicator.ballPulse,

                            /// Required, The loading type of the widget
                            colors: const [Colors.white],

                            /// Optional, The color collections
                            strokeWidth: 2,

                            /// Optional, The stroke of the line, only applicable to widget which contains line
                            backgroundColor: Colors.transparent,

                            /// Optional, Background of the widget
                            pathBackgroundColor: Colors.black

                            /// Optional, the stroke backgroundColor
                            )
                        : Text(
                            loginBtnText,
                            style: Theme.of(context)
                                .textButtonTheme
                                .style
                                .textStyle
                                .resolve({
                              MaterialState.pressed,
                            }),
                          ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 25, bottom: 20),
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       Container(
                //         margin: EdgeInsets.all(15),
                //         height: 0.5,
                //         decoration: BoxDecoration(
                //           gradient: LinearGradient(
                //             begin: Alignment.topLeft,
                //             end: Alignment.bottomRight,
                //             colors: g.gradientColors,
                //           ),
                //         ),
                //         child: Divider(),
                //       ),
                //       Container(
                //           margin: EdgeInsets.all(15),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(25),
                //             border: Border.all(
                //               color: Color(0xFF3F1444),
                //             ),
                //           ),
                //           child: g.isDarkModeEnable
                //               ? CircleAvatar(
                //                   radius: 24,
                //                   backgroundColor: Colors.black,
                //                   child: Text(
                //                     AppLocalizations.of(context).lbl_or,
                //                     style: Theme.of(context).primaryTextTheme.subtitle2,
                //                   ),
                //                 )
                //               : CircleAvatar(
                //                   radius: 24,
                //                   backgroundColor: Colors.white,
                //                   child: Text(
                //                     AppLocalizations.of(context).lbl_or,
                //                     style: Theme.of(context).primaryTextTheme.subtitle2,
                //                   ),
                //                 ))
                //     ],
                //   ),
                // ),
                // Text(
                //   AppLocalizations.of(context).lbl_login_using,
                //   style: Theme.of(context).primaryTextTheme.headline3,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 25),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       CircleAvatar(
                //         radius: 25,
                //         backgroundColor: Color(0xFF2942C7),
                //         child: Text(
                //           'f',
                //           style: Theme.of(context).accentTextTheme.headline2,
                //         ),
                //       ),
                //       Padding(
                //         padding: g.isRTL ? const EdgeInsets.only(right: 15) : const EdgeInsets.only(left: 15),
                //         child: CircleAvatar(
                //           radius: 25,
                //           backgroundColor: Color(0xFFDF4D5F),
                //           child: Text(
                //             'G',
                //             style: Theme.of(context).accentTextTheme.headline2,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
