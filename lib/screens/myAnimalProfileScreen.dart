import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAnimalProfileScreen extends BaseRoute {
  MyAnimalProfileScreen({a, o}) : super(a: a, o: o, r: 'MyAnimalProfileScreen');
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends BaseRouteState {
  int _currentIndex = 0;
  TabController _tabController;
  _MyProfileScreenState() : super();

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
            appBar: _appBarWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width*.8,
                      width: MediaQuery.of(context).size.width*.75,
                      child: Container(
                        child: Image.asset(
                          'assets/images/animal.jpg',
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(19, 1, 51, 1),
                        ),
                      ),
                    ),
                    Container(
                      color: g.isDarkModeEnable ? Color(0xFF130032) : Colors.white,
                      
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, bottom: 4),
                            child: Icon(
                              Icons.favorite_outline,
                              color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColorLight,
                              size: 24,
                            ),
                          ),
                          Divider(
                            color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          ),
                          Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 18,
                                  child: Icon(
                                    Icons.message,
                                    size: 22,
                                    color: Color(0xFF230f4E),
                                  ),
                                ),
                          ),
                          
                          Divider(
                            color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 18,
                                    child: Icon(
                                      Icons.report_problem_rounded,
                                      size: 22,
                                      color: Color.fromARGB(255, 247, 149, 3),
                                    ),
                                  ),
                            ),
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * 0.75,
                      color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      color: Color(0xFFAD45B3),
                      width: MediaQuery.of(context).size.width / 2 - 35,
                      height: 15,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Text(
                                'Rocky',
                                style: Theme.of(context).primaryTextTheme.headline1,
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20, right: 30),
                            //   child: CircleAvatar(
                            //     backgroundColor: Color.fromARGB(200, 52, 9, 245),
                            //     radius: 30,
                            //     child: CircleAvatar(
                            //       backgroundColor: Color.fromARGB(249, 255, 255, 255),
                            //       radius: 28,
                            //       child: Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Icon(Icons.phone),
                            //           Text('Contact',style: Theme.of(context).primaryTextTheme.bodyText2),
                            //           // Text('Owner',style: Theme.of(context).primaryTextTheme.bodyText2)
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20) : const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Type:',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Dog',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Breed:',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Golden Retriever',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Gender:',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Male',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Vaccinated:',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Yes',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 10) : const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            AppLocalizations.of(context).lbl_short_bio,
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 10) : const EdgeInsets.only(left: 20, top: 5),
                          child: Text(
                            'Funny, loves to play, loves sleeping, and so cute!',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        // Documents
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Documents',
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 10) : const EdgeInsets.only(left: 20, top: 5),
                          child: Text(
                            'No available documents for now...',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        // Additional info
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Additional Information',
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 10) : const EdgeInsets.only(left: 20, top: 5, bottom: 10),
                          child: Text(
                            'No additional information available.',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20),
                        //   child: TabBar(
                        //     controller: _tabController,
                        //     indicatorColor: Theme.of(context).iconTheme.color,
                        //     onTap: (int index) async {
                        //       _currentIndex = index;
                        //       setState(() {});
                        //     },
                        //     tabs: [
                        //       _tabController.index == 0
                        //           ? Tab(
                        //               child: ShaderMask(
                        //                 blendMode: BlendMode.srcIn,
                        //                 shaderCallback: (Rect bounds) {
                        //                   return LinearGradient(
                        //                     colors: g.gradientColors,
                        //                     begin: Alignment.centerLeft,
                        //                     end: Alignment.centerRight,
                        //                   ).createShader(bounds);
                        //                 },
                        //                 child: Text(
                        //                   AppLocalizations.of(context).lbl_tab_pictures,
                        //                   style: TextStyle(fontSize: 16),
                        //                 ),
                        //               ),
                        //             )
                        //           : Text(
                        //               AppLocalizations.of(context).lbl_tab_pictures,
                        //               style: TextStyle(fontSize: 16),
                        //             ),
                        //       _tabController.index == 1
                        //           ? Tab(
                        //               child: ShaderMask(
                        //                 blendMode: BlendMode.srcIn,
                        //                 shaderCallback: (Rect bounds) {
                        //                   return LinearGradient(
                        //                     colors: g.gradientColors,
                        //                     begin: Alignment.centerLeft,
                        //                     end: Alignment.centerRight,
                        //                   ).createShader(bounds);
                        //                 },
                        //                 child: Text(
                        //                   AppLocalizations.of(context).lbl_tab_videos,
                        //                   style: TextStyle(fontSize: 16),
                        //                 ),
                        //               ),
                        //             )
                        //           : Text(
                        //               AppLocalizations.of(context).lbl_tab_videos,
                        //               style: TextStyle(fontSize: 16),
                        //             ),
                        //       _tabController.index == 2
                        //           ? Tab(
                        //               child: ShaderMask(
                        //                 blendMode: BlendMode.srcIn,
                        //                 shaderCallback: (Rect bounds) {
                        //                   return LinearGradient(
                        //                     colors: g.gradientColors,
                        //                     begin: Alignment.centerLeft,
                        //                     end: Alignment.centerRight,
                        //                   ).createShader(bounds);
                        //                 },
                        //                 child: Text(
                        //                   AppLocalizations.of(context).lbl_tab_mybio,
                        //                   style: TextStyle(fontSize: 16),
                        //                 ),
                        //               ),
                        //             )
                        //           : Text(
                        //               AppLocalizations.of(context).lbl_tab_mybio,
                        //               style: TextStyle(fontSize: 16),
                        //             ),
                        //       _tabController.index == 3
                        //           ? Tab(
                        //               child: ShaderMask(
                        //                 blendMode: BlendMode.srcIn,
                        //                 shaderCallback: (Rect bounds) {
                        //                   return LinearGradient(
                        //                     colors: g.gradientColors,
                        //                     begin: Alignment.centerLeft,
                        //                     end: Alignment.centerRight,
                        //                   ).createShader(bounds);
                        //                 },
                        //                 child: Text(
                        //                   AppLocalizations.of(context).lbl_tab_more,
                        //                   style: TextStyle(fontSize: 16),
                        //                 ),
                        //               ),
                        //             )
                        //           : Text(
                        //               AppLocalizations.of(context).lbl_tab_more,
                        //               style: TextStyle(fontSize: 16),
                        //             ),
                        //     ],
                        //   ),
                        // ),
                        
                        
                        // Padding(
                        //     padding: const EdgeInsets.only(bottom: 20),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Expanded(
                        //           child: Padding(
                        //             padding: g.isRTL ? EdgeInsets.only(right: 20, top: 20) : EdgeInsets.only(left: 20, top: 20),
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Icon(
                        //                   MdiIcons.music,
                        //                   color: Color(0xFFB783EB),
                        //                   size: 20,
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.only(left: 4),
                        //                   child: Text(
                        //                     'Music',
                        //                     style: Theme.of(context).accentTextTheme.subtitle2,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: EdgeInsets.only(top: 20),
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Icon(
                        //                   MdiIcons.cookie,
                        //                   color: Color(0xFFB783EB),
                        //                   size: 20,
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.only(left: 4),
                        //                   child: Text(
                        //                     'Cooking',
                        //                     style: Theme.of(context).accentTextTheme.subtitle2,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: EdgeInsets.only(top: 20),
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Icon(
                        //                   MdiIcons.swim,
                        //                   color: Color(0xFFB783EB),
                        //                   size: 20,
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.only(left: 4),
                        //                   child: Text(
                        //                     'Swimming',
                        //                     style: Theme.of(context).accentTextTheme.subtitle2,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: EdgeInsets.only(top: 20),
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Icon(
                        //                   Icons.travel_explore,
                        //                   color: Color(0xFFB783EB),
                        //                   size: 20,
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.only(left: 4),
                        //                   child: Text(
                        //                     'Travelling',
                        //                     style: Theme.of(context).accentTextTheme.subtitle2,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: g.isRTL ? Alignment.centerLeft : Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingScreen(
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFDC3664),
            width: MediaQuery.of(context).size.width / 2 - 35,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
