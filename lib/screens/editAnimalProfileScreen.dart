import 'dart:io';
import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/addStoryScreen1.dart';
import 'package:PetsMating/screens/likes&IntrestScreen.dart';
import 'package:PetsMating/screens/myAnimalProfileScreen.dart';
import 'package:PetsMating/screens/myProfileDetailScreen.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:PetsMating/services/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAnimalProfileScreen extends StatefulWidget {
  final int animal_id;
  const EditAnimalProfileScreen(this.animal_id);
  @override
  _EditAnimalProfileScreenState createState() =>
      _EditAnimalProfileScreenState();
}

class _EditAnimalProfileScreenState extends State<EditAnimalProfileScreen> {
  Map<String, dynamic> _animal = {'empty': true};
  TextEditingController _cFirstName = new TextEditingController();
  TextEditingController _cInfo = new TextEditingController();

  String _vaccination = 'No';

  bool btnIsDisabled = false;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _EditAnimalProfileScreenState() : super();

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
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update",
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                    Text(
                      "Pet Details",
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                    Divider(
                      height: 20,
                    ),

                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 55,
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
                        child: TextFormField(
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                          controller: _cFirstName,
                          decoration: InputDecoration(
                            labelText: 'Pet Name',
                            labelStyle:
                                Theme.of(context).primaryTextTheme.subtitle2,
                            contentPadding: g.isRTL
                                ? EdgeInsets.only(right: 20)
                                : EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //   padding: EdgeInsets.all(1.5),
                    //   height: 55,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: g.gradientColors,
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //     borderRadius: BorderRadius.circular(35),
                    //   ),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: g.isDarkModeEnable
                    //           ? Colors.black
                    //           : Theme.of(context).scaffoldBackgroundColor,
                    //       borderRadius: BorderRadius.circular(35),
                    //     ),
                    //     height: 55,
                    //     child: TextFormField(
                    //       style: Theme.of(context).primaryTextTheme.subtitle2,
                    //       controller: _cBDate,
                    //       decoration: InputDecoration(
                    //           labelText:
                    //               AppLocalizations.of(context).lbl_dob_hint,
                    //           labelStyle: Theme.of(context)
                    //               .primaryTextTheme
                    //               .subtitle2,
                    //           contentPadding: g.isRTL
                    //               ? EdgeInsets.only(right: 20)
                    //               : EdgeInsets.only(left: 20),
                    //           suffixIcon: Padding(
                    //             padding: g.isRTL
                    //                 ? const EdgeInsets.only(left: 4)
                    //                 : const EdgeInsets.only(right: 4),
                    //             child: Icon(
                    //               Icons.calendar_today,
                    //               color: Theme.of(context).iconTheme.color,
                    //               size: 20,
                    //             ),
                    //           )),
                    //     ),
                    //   ),
                    // ),

                    // Vaccination ================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.vaccines),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Is it vaccinated ?',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Icon(Icons.vaccines),
                      ],
                    ),
                    _vaccination.isEmpty
                        ? Text("")
                        : Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: EdgeInsets.all(1.5),
                            height: 55,
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
                              child: DropdownButtonFormField<String>(
                                dropdownColor:
                                    Theme.of(context).primaryColorLight,
                                icon: Padding(
                                  padding: g.isRTL
                                      ? EdgeInsets.only(left: 20)
                                      : EdgeInsets.only(right: 20),
                                  child: Icon(Icons.expand_more,
                                      color: Theme.of(context).iconTheme.color),
                                ),
                                value: _vaccination,
                                items: ['No', 'Yes']
                                    .map((label) => DropdownMenuItem(
                                          child: Padding(
                                            padding: g.isRTL
                                                ? EdgeInsets.only(right: 20)
                                                : EdgeInsets.only(left: 20),
                                            child: Text(
                                              label.toString(),
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .subtitle2,
                                            ),
                                          ),
                                          value: label,
                                        ))
                                    .toList(),
                                hint: Padding(
                                  padding: g.isRTL
                                      ? EdgeInsets.only(right: 20)
                                      : EdgeInsets.only(left: 20),
                                  child: Text(_vaccination.isEmpty
                                      ? "..."
                                      : _vaccination),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _vaccination = value;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _vaccination = value;
                                  });
                                },
                              ),
                            ),
                          ),

                    // ABOUTTTTTTTTTTTTTTTTTTTT
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: g.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable
                              ? Colors.black
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                          controller: _cInfo,
                          decoration: InputDecoration(
                            labelText: 'About',
                            labelStyle:
                                Theme.of(context).primaryTextTheme.subtitle2,
                            contentPadding: g.isRTL
                                ? EdgeInsets.only(right: 20)
                                : EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
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
                                    if (_cFirstName.text.isEmpty ||
                                        _cInfo.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Please enter valid data!'),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                      setState(() {
                                        btnIsDisabled = false;
                                      });
                                      return;
                                    }
                                    Map data = {
                                      'name': _cFirstName.text,
                                      'info': _cInfo.text,
                                      'vaccinated': _vaccination,
                                      'id': widget.animal_id
                                    };
                                    print(data);
                                    dynamic res = await Provider.of<Auth>(
                                            context,
                                            listen: false)
                                        .updateAnimal(data);
                                    print(res);
                                    if (res != 'failed') {
                                      final auth = Provider.of<Auth>(context,
                                          listen: false);
                                      await auth.tryLogin(true);

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationWidgetLight(
                                                    currentIndex: 3,
                                                  )),
                                          ModalRoute.withName('/'));
                                    } else {
                                      setState(() {
                                        btnIsDisabled = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please enter valid values.'),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
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
                    )
                  ],
                ),
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

    void getAnimal() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('i-pet-kk');
        if (token != null) {
          Dio.Response response = await dio().get('/animal/${widget.animal_id}',
              options:
                  Dio.Options(headers: {'Authorization': 'Bearer $token'}));

          setState(() {
            _animal = response.data;
            _vaccination = response.data['vaccinated'] == 'Yes' ? 'Yes' : 'No';
          });

          _cFirstName.text = response.data['name'];
          _cInfo.text = response.data['info'];
        }
      } catch (e) {
        print(e);
      }
    }

    getAnimal();
  }
}
