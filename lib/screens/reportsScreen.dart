import 'dart:io';
import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/addStoryScreen1.dart';
import 'package:PetsMating/screens/likes&IntrestScreen.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatefulWidget {
  final int userId;
  const ReportsScreen(this.userId);
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  TextEditingController _cReport = new TextEditingController();
  TextEditingController _cReportedUserId = new TextEditingController();

  String _currentImage = '';

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _ReportsScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigationWidgetLight(
                        currentIndex: 2,
                      )),
              ModalRoute.withName('/'));
        },
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: g.scaffoldBackgroundGradientColors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Consumer<Auth>(builder: (context, auth, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                key: _scaffoldKey,
                body: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Report User',
                            style: Theme.of(context).primaryTextTheme.headline1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              AppLocalizations.of(context)
                                  .lbl_profile_details_subtitle,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(1.5),
                            height: 150,
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
                              height: 150,
                              child: TextFormField(
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                                controller: _cReport,
                                decoration: InputDecoration(
                                  labelText: 'What is your problem...?',
                                  labelStyle: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                  contentPadding: g.isRTL
                                      ? EdgeInsets.only(right: 20)
                                      : EdgeInsets.only(left: 20),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: _currentImage.isEmpty
                                ? TextButton(
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
                                          Icons.attach_file,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 200,
                                    margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.file(
                                      File(_currentImage),
                                      fit: BoxFit.cover,
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
                                  if (_cReport.text.isNotEmpty) {
                                    Map data = {
                                      'user_id': auth.current_user['id'],
                                      'reported_id': _cReportedUserId.text,
                                      'report': _cReport.text,
                                      'img': _currentImage,
                                      'reported_type': "user"
                                    };
                                    dynamic res = await Provider.of<Auth>(
                                            context,
                                            listen: false)
                                        .reportUser(data);
                                    if (res == 'Reported successfully.') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Reported successfully.'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationWidgetLight(
                                                    currentIndex: 2,
                                                  )));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Error happened...'),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Please enter some data...'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Report',
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
              );
            })),
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
    _cReportedUserId.text = widget.userId.toString();
  }
}
