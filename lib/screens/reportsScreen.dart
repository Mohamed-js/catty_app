import 'dart:io';
import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/addStoryScreen1.dart';
import 'package:datingapp/screens/likes&IntrestScreen.dart';
import 'package:datingapp/services/auth.dart';
import 'package:datingapp/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends BaseRoute {
  ReportsScreen({a, o}) : super(a: a, o: o, r: 'ReportsScreen');
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends BaseRouteState {
  TextEditingController _cReport = new TextEditingController();

  String _currentImage = '';

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _ReportsScreenState() : super();

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
                            controller: _cReport,
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
                                'report': _cReport.text,
                                'img': _currentImage
                              };
                              dynamic res = await Provider.of<Auth>(context,
                                      listen: false)
                                  .updateProfile(data);
                              if (res == 'Reported successfully.') {
                                final auth =
                                    Provider.of<Auth>(context, listen: false);
                                await auth.tryLogin(false);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationWidgetLight(
                                          currentIndex: 0,
                                        )));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Please choose a valid image.'),
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
