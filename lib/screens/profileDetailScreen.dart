import 'dart:io';
import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/addStoryScreen.dart';
import 'package:datingapp/screens/likes&IntrestScreen.dart';
import 'package:datingapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends BaseRoute {
  ProfileDetailScreen({a, o}) : super(a: a, o: o, r: 'ProfileDetailScreen');
  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends BaseRouteState {
  TextEditingController _cFirstName = new TextEditingController();
  TextEditingController _cLastName = new TextEditingController();

  String _gender = 'Select Gender';
  String _currentImage = '';

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _ProfileDetailScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return exitAppDialog();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: g.scaffoldBackgroundGradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).lbl_profile_details,
                        style: Theme.of(context).primaryTextTheme.headline1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          AppLocalizations.of(context)
                              .lbl_profile_details_subtitle,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundImage: _currentImage.isEmpty
                                    ? AssetImage('assets/images/holder.png')
                                    : FileImage(File(_currentImage)),
                                radius: 60,
                                backgroundColor: Color(0xFF33196B),
                              ),
                            ),
                            Positioned(
                              top: 75,
                              left: 75,
                              child: TextButton(
                                onPressed: () => getImage(),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: g.isDarkModeEnable
                                        ? Border.all(color: Colors.black)
                                        : null,
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 20,
                                    child: Icon(
                                      Icons.photo_camera,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
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
                              labelText: AppLocalizations.of(context)
                                  .lbl_first_name_hint,
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
                        margin: EdgeInsets.all(20),
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
                            controller: _cLastName,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .lbl_last_name_hint,
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
                      //   margin: EdgeInsets.all(20),
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
                      Container(
                        margin: EdgeInsets.all(20),
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
                            dropdownColor: Theme.of(context).primaryColorLight,
                            icon: Padding(
                              padding: g.isRTL
                                  ? EdgeInsets.only(left: 20)
                                  : EdgeInsets.only(right: 20),
                              child: Icon(Icons.expand_more,
                                  color: Theme.of(context).iconTheme.color),
                            ),
                            value: _gender,
                            items: ['Select Gender', 'Female', 'Male']
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
                              child: Text(_gender.isEmpty
                                  ? AppLocalizations.of(context).lbl_gender_hint
                                  : _gender),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
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
                            onPressed: () async {
                              Map data = {
                                'first_name': _cFirstName.text,
                                'last_name': _cLastName.text,
                                'gender': _gender,
                                'img': _currentImage
                              };
                              dynamic res = await Provider.of<Auth>(context,
                                      listen: false)
                                  .updateProfile(data);
                              if (res == 'Updated successfully.') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddStoryScreen(
                                          a: widget.analytics,
                                          o: widget.observer,
                                        )));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please choose a valid image.'),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                            },
                            child: Text(
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  XFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  void getImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxHeight: 500,
          maxWidth: 500);
      setState(() {
        _currentImage = image.path;
      });

      setState(() {
        _imageFile = image;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
