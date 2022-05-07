import 'dart:io';
import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/addStoryScreen.dart';
import 'package:datingapp/screens/likes&IntrestScreen.dart';
import 'package:datingapp/screens/myAnimalProfileScreen.dart';
import 'package:datingapp/screens/myProfileDetailScreen.dart';
import 'package:datingapp/services/auth.dart';
import 'package:datingapp/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:datingapp/services/dio.dart';

class NewAnimalScreen extends BaseRoute {
  NewAnimalScreen({a, o}) : super(a: a, o: o, r: 'NewAnimalScreen');
  @override
  _NewAnimalScreenState createState() => _NewAnimalScreenState();
}

class _NewAnimalScreenState extends BaseRouteState {
  TextEditingController _cFirstName = new TextEditingController();
  TextEditingController _cInfo = new TextEditingController();
  String _gender = 'Select Gender';
  String _currentImage = '';
  int breedId;

  String _type = 'Select Type';
  String _breed = 'Select Breed';
  List<dynamic> typeBreed;
  List<String> types = [];
  List<String> breeds = [];

  List<dynamic> selectedBreeds;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _NewAnimalScreenState() : super();

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
                      "Pet Details",
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
                                  ? AssetImage(
                                      'assets/images/dog_placeholder.png')
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

                    // TYPE
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
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Theme.of(context).primaryColorLight,
                          icon: Padding(
                            padding: g.isRTL
                                ? EdgeInsets.only(left: 20)
                                : EdgeInsets.only(right: 20),
                            child: Icon(Icons.expand_more,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          value: _type,
                          items: ['Select Type', ...types]
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
                            child: Text(_type.isEmpty ? "Type" : _type),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _type = value;
                              selectedBreeds =
                                  typeBreed[types.indexOf(value)]['breeds'];
                              if (_type != 'Select Type') {
                                typeBreed[types.indexOf(value)]['breeds']
                                    .forEach((element) {
                                  breeds.add(element['name'].toUpperCase());
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ),

                    // BREEEEEEEEEEEED
                    _type == 'Select Type'
                        ? SizedBox(width: 10)
                        : renderBreeds(),

                    // GENDER ================================================
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

                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              'name': _cFirstName.text,
                              'info': _cInfo.text,
                              'gender': _gender,
                              'avatar': _currentImage,
                              'breed_id': breedId,
                            };
                            print(data);
                            dynamic res =
                                await Provider.of<Auth>(context, listen: false)
                                    .addAnimal(data);
                            if (res != 'failed') {
                              final auth =
                                  Provider.of<Auth>(context, listen: false);
                              await auth.tryLogin(true);

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationWidgetLight(
                                            currentIndex: 0,
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )),
                                  ModalRoute.withName('/'));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter valid values.'),
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
    void getTypes() async {
      Dio.Response response = await dio().get('/animals/create');
      setState(() {
        typeBreed = response.data;
        typeBreed.forEach((element) {
          types.add(element['name'].toUpperCase());
        });
      });
    }

    getTypes();
  }

  renderBreeds() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          value: _breed,
          items: ['Select Breed', ...breeds]
              .map((label) => DropdownMenuItem(
                    child: Padding(
                      padding: g.isRTL
                          ? EdgeInsets.only(right: 20)
                          : EdgeInsets.only(left: 20),
                      child: Text(
                        label.toString(),
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                    value: label,
                  ))
              .toList(),
          hint: Padding(
            padding: g.isRTL
                ? EdgeInsets.only(right: 20)
                : EdgeInsets.only(left: 20),
            child: Text(_breed.isEmpty ? "Breed" : _breed),
          ),
          onChanged: (value) {
            setState(() {
              _breed = value;
              List x = selectedBreeds
                  .where((breed) => breed['name'].toUpperCase() == value)
                  .toList();

              breedId = x[0]['id'];
            });
          },
        ),
      ),
    );
  }
}
