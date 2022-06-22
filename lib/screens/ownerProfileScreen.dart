import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/myAnimalProfileScreen.dart';
import 'package:PetsMating/screens/newAnimalScreen.dart';
import 'package:PetsMating/screens/settingScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:PetsMating/services/dio.dart';

import 'package:dio/dio.dart' as Dio;

class OwnerProfileScreen extends StatefulWidget {
  final int profileId;
  const OwnerProfileScreen(this.profileId);

  @override
  State<OwnerProfileScreen> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfileScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController;
  Map _profile;

  _OwnerProfileState() : super();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final appState = Provider.of<AppState>(context, listen: false);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigationWidgetLight(
                        currentIndex: 0,
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
          child: Scaffold(
            appBar: _appBarWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _profile == null
                ? Center(
                    child: Container(
                      height: 50,
                      child: LoadingIndicator(
                          indicatorType: Indicator.lineScalePulseOut,

                          /// Required, The loading type of the widget
                          colors: const [Color.fromARGB(255, 214, 27, 27)],

                          /// Optional, The color collections
                          strokeWidth: 2,

                          /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.transparent,

                          /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black

                          /// Optional, the stroke backgroundColor
                          ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(alignment: Alignment.center, children: [
                            Container(
                              height: MediaQuery.of(context).size.width * .8,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                child: Image.network(
                                  "${_profile['avatar']}",
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(19, 1, 51, 1),
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                      Divider(
                        color: Colors.deepPurple[100],
                        height: 15,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    _profile['first_name'].toUpperCase() +
                                        " " +
                                        _profile['last_name'].toUpperCase(),
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: g.isRTL
                                    ? const EdgeInsets.only(right: 20)
                                    : const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mail,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            size: 16,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            child: Text(
                                              _profile['email'],
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: g.isRTL
                                    ? const EdgeInsets.only(right: 20)
                                    : const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Pets",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline3,
                                ),
                              ),
                              _profile['animals'].isNotEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.12),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: [
                                            GridView.builder(
                                              scrollDirection: Axis.horizontal,
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                mainAxisSpacing: 2.0,
                                                crossAxisSpacing: 2.0,
                                              ),
                                              itemCount:
                                                  _profile['animals'].length,
                                              itemBuilder: (ctx, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  23)),
                                                      border: Border.all(
                                                          width: 5,
                                                          color: Color(
                                                              0xFFEEFCFF))),
                                                  child: PopupMenuButton(
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        MyAnimalProfileScreen(_profile['animals'][index]
                                                                            [
                                                                            'id'])));
                                                          },
                                                          child: Text(
                                                            "View animal",
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle2,
                                                          ),
                                                        ),
                                                        onTap: () => {},
                                                      ),
                                                    ],
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        color:
                                                            g.isDarkModeEnable
                                                                ? Color(
                                                                    0xFF1D0529)
                                                                : Colors
                                                                    .white54,
                                                      ),
                                                      child: GridTile(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: _profile['animals']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'avatars']
                                                                      .length >
                                                                  0
                                                              ? Image.network(
                                                                  '${_profile['animals'][index]['avatars'][0]['url']}',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 100,
                                                                )
                                                              : Image.asset(
                                                                  'assets/images/animal.jpg',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            Container(),
                                            Container(),
                                            Container()
                                          ],
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: g.isRTL
                                          ? const EdgeInsets.only(right: 20)
                                          : const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "No pets to show...",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                    ),
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
    // final auth = Provider.of<Auth>(context, listen: false);

    _tabController =
        new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
    // final appState = Provider.of<AppState>(context, listen: false);
    // appState.getSubscription();
    // appState.getQuota();
    // auth.tryLogin(true);
    getProfile(profileId) async {
      try {
        Dio.Response response = await dio().get('/user/$profileId');
        setState(() {
          _profile = response.data;
        });
        print(_profile);
      } catch (e) {
        print(e);
      }
    }

    getProfile(widget.profileId);
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
            color: g.isDarkModeEnable
                ? Color(0xFF130032)
                : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingScreen()));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFDC3664),
            width: 70,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationWidgetLight(
                              currentIndex: 0,
                            )),
                    ModalRoute.withName('/'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
