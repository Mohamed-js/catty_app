import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/addStoryScreen1.dart';
import 'package:PetsMating/screens/profileDetailScreen.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends BaseRoute {
  VerifyOtpScreen({a, o}) : super(a: a, o: o, r: 'VerifyOtpScreen');
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode _fNum2 = FocusNode();
  FocusNode _fNum3 = FocusNode();
  FocusNode _fNum4 = FocusNode();

  String num1;
  String num2;
  String num3;
  String num4;

  bool btnIsDisabled = false;

  _VerifyOtpScreenState() : super();

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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
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
                      AppLocalizations.of(context).lbl_verify,
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).lbl_4_digit_entre,
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                  Text(
                    AppLocalizations.of(context).lbl_sent_to_num,
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 10, bottom: 10),
                          padding: EdgeInsets.all(1.2),
                          height: 55,
                          width: 55,
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
                            height: 55,
                            width: 55,
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5)),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                              onChanged: (v) {
                                FocusScope.of(context).requestFocus(_fNum2);
                                num1 = v;
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 10, bottom: 10),
                          padding: EdgeInsets.all(1.2),
                          height: 55,
                          width: 55,
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
                            height: 55,
                            width: 55,
                            child: TextFormField(
                              focusNode: _fNum2,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5)),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                              onChanged: (v) {
                                FocusScope.of(context).requestFocus(_fNum3);
                                num2 = v;
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 10, bottom: 10),
                          padding: EdgeInsets.all(1.2),
                          height: 55,
                          width: 55,
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
                            height: 55,
                            width: 55,
                            child: TextFormField(
                              focusNode: _fNum3,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5)),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                              onChanged: (v) {
                                FocusScope.of(context).requestFocus(_fNum4);
                                num3 = v;
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 10, left: 10, bottom: 10),
                          padding: EdgeInsets.all(1.2),
                          height: 55,
                          width: 55,
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
                            height: 55,
                            width: 55,
                            child: TextFormField(
                              focusNode: _fNum4,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5)),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                              onChanged: (v) {
                                num4 = v;
                              },
                            ),
                          ),
                        ),
                      ],
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
                              String otp = "$num1$num2$num3$num4";
                              dynamic isVerified = await Provider.of<Auth>(
                                      context,
                                      listen: false)
                                  .verifyUser(otp);
                              print('hey');
                              print(isVerified);

                              if (isVerified == true) {
                                final auth = await Provider.of<Auth>(context,
                                    listen: false);
                                String name = auth.current_user['first_name'];
                                if (name == null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileDetailScreen()));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationWidgetLight(
                                            currentIndex: 0,
                                          )));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("OTP is incorrect..."),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                              setState(() {
                                btnIsDisabled = false;
                              });
                            },
                      child: Text(
                        AppLocalizations.of(context).btn_submit,
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
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: ShaderMask(
                  //     blendMode: BlendMode.srcIn,
                  //     shaderCallback: (Rect bounds) {
                  //       return LinearGradient(
                  //         colors: g.gradientColors,
                  //         begin: Alignment.centerLeft,
                  //         end: Alignment.centerRight,
                  //       ).createShader(bounds);
                  //     },
                  //     child: Text(
                  //       AppLocalizations.of(context).lbl_resend_otp,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold, fontSize: 17),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
