import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/addStoryScreen.dart';
import 'package:datingapp/screens/verifyOtpScreen.dart';
import 'package:datingapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';

class LoginScreen extends BaseRoute {
  LoginScreen({a, o}) : super(a: a, o: o, r: 'LoginScreen');
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseRouteState {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String login_err;
  String login_btn_text = "Submit";

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
                    onPressed: () async {
                      print('trying to login...');
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          login_btn_text = 'Loading..';
                        });
                        String device_name =
                            Platform.isAndroid ? "android" : "ios";
                        Map creds = {
                          'email': _emailController.text,
                          'password': _passwordController.text,
                          'device_name': device_name,
                        };

                        dynamic canLogin =
                            await Provider.of<Auth>(context, listen: false)
                                .login(creds);
                        // adb reverse tcp:8000 tcp:8000
                        
                        if (canLogin == true) {
                          setState(() {
                            login_btn_text = 'Submit';
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddStoryScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        } else if (canLogin is Map) {
                          setState(() {
                            login_err = canLogin['message'];
                            login_btn_text = 'Submit';
                          });
                          if (login_err ==
                              'Please check your email for the OTP code.') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(login_err),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VerifyOtpScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          } else if (login_err ==
                              'The provided credentials are incorrect.') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(login_err),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(login_err),
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
                    },
                    child: Text(
                      login_btn_text,
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
