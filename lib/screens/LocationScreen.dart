import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends BaseRoute {
  LocationScreen({a, o}) : super(a: a, o: o, r: 'LocationScreen');
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _cLongitude = new TextEditingController();
  TextEditingController _cLatitude = new TextEditingController();
  _LocationScreenState() : super();
  TextEditingController _cCountry = new TextEditingController();
  TextEditingController _cCity = new TextEditingController();

  bool btnIsDisabled = false;

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: SizedBox()),
                  Text(AppLocalizations.of(context).lbl_location,
                      style: Theme.of(context).primaryTextTheme.headline1),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      AppLocalizations.of(context).lbl_location_subtitle1,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                  Text(AppLocalizations.of(context).lbl_location_subtitle2,
                      style: Theme.of(context).primaryTextTheme.subtitle2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        AppLocalizations.of(context).lbl_current_location,
                        style: Theme.of(context).accentTextTheme.headline5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.all(1.2),
                    height: 60,
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
                            TextStyle(color: Color.fromARGB(255, 42, 6, 110)),
                        cursorColor: Color.fromARGB(255, 235, 65, 65),
                        textAlign: TextAlign.start,
                        controller: _cCountry,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: g.isRTL
                                ? const EdgeInsets.only(left: 20)
                                : const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.my_location,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          contentPadding: g.isRTL
                              ? EdgeInsets.only(right: 20, top: 15)
                              : EdgeInsets.only(left: 20, top: 15),
                          hintStyle:
                              Theme.of(context).primaryTextTheme.subtitle2,
                          hintText: 'Country',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(1.2),
                    height: 60,
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
                            TextStyle(color: Color.fromARGB(255, 42, 6, 110)),
                        cursorColor: Color.fromARGB(255, 235, 65, 65),
                        textAlign: TextAlign.start,
                        controller: _cCity,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: g.isRTL
                                ? const EdgeInsets.only(left: 20)
                                : const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          contentPadding: g.isRTL
                              ? EdgeInsets.only(right: 20, top: 15)
                              : EdgeInsets.only(left: 20, top: 15),
                          hintStyle:
                              Theme.of(context).primaryTextTheme.subtitle2,
                          hintText: 'City',
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 50,
                      width: 180,
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

                                bool isLocationServiceEnabled =
                                    await Geolocator.isLocationServiceEnabled();
                                if (isLocationServiceEnabled) {
                                  LocationPermission permission =
                                      await Geolocator.checkPermission();
                                  if (permission == LocationPermission.always ||
                                      permission ==
                                          LocationPermission.whileInUse) {
                                    Position location =
                                        await Geolocator.getCurrentPosition(
                                            desiredAccuracy:
                                                LocationAccuracy.high,
                                            forceAndroidLocationManager: true);
                                    // _cLatitude.text = location.Latitude;
                                    print('location');
                                    _cLatitude.text =
                                        location.latitude.toString();
                                    _cLongitude.text =
                                        location.longitude.toString();
                                    print('location');
                                  } else {
                                    if (permission ==
                                        LocationPermission.denied) {
                                      LocationPermission permission =
                                          await Geolocator.requestPermission();
                                      if (permission ==
                                              LocationPermission.always ||
                                          permission ==
                                              LocationPermission.whileInUse) {
                                        dynamic location =
                                            await Geolocator.getCurrentPosition(
                                                desiredAccuracy:
                                                    LocationAccuracy.high,
                                                forceAndroidLocationManager:
                                                    true);
                                        print('location');
                                        _cLatitude.text =
                                            location.latitude.toString();
                                        _cLongitude.text =
                                            location.longitude.toString();
                                        print('location');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Sorry, we cannot access your location!'),
                                            backgroundColor: Colors.redAccent,
                                          ),
                                        );
                                        setState(() {
                                          btnIsDisabled = false;
                                        });
                                      }
                                    } else {
                                      // PLEASE GRANT PERMISSION FROM SETTINGS
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Location permission is denied forever, please enable it from app settings.'),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                      setState(() {
                                        btnIsDisabled = false;
                                      });
                                    }
                                  }
                                } else {
                                  // PLEASE ENABLE LOCATION
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Make sure location service is enabled on your device.'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  setState(() {
                                    btnIsDisabled = false;
                                  });
                                }
                                if (_cCountry.text.isEmpty ||
                                    _cCity.text.isEmpty ||
                                    _cLongitude.text.isEmpty ||
                                    _cLatitude.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Cannot get your position correctly!'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  setState(() {
                                    btnIsDisabled = false;
                                  });
                                  return;
                                } else {
                                  Map data = {
                                    'country': _cCountry.text,
                                    'city': _cCity.text,
                                    'longitude': _cLongitude.text,
                                    'latitude': _cLatitude.text
                                  };
                                  dynamic res = await Provider.of<Auth>(context,
                                          listen: false)
                                      .addLocation(data);

                                  if (res.toString() ==
                                      'Updated successfully.') {
                                    final auth = Provider.of<Auth>(context,
                                        listen: false);
                                    await auth.tryLogin(false);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigationWidgetLight(
                                                  currentIndex: 0,
                                                )));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Error happened getting your location!'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                  setState(() {
                                    btnIsDisabled = false;
                                  });
                                }
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
                                'Save',
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
                  ),
                  Expanded(child: SizedBox()),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 40),
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           AppLocalizations.of(context).lbl_powered_by,
                  //           style: Theme.of(context).primaryTextTheme.subtitle2,
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.only(left: 4, top: 4),
                  //           child: Image.asset(
                  //             'assets/images/google_back.png',
                  //             height: 25,
                  //             width: 70,
                  //           ),
                  //         )
                  //       ],
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
