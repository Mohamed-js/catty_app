import 'package:datingapp/screens/addMessageScreen.dart';
import 'package:datingapp/screens/addStoryScreen.dart';
import 'package:datingapp/screens/myProfileDetailScreen.dart';
import 'package:datingapp/screens/notificationListScreen.dart';
import 'package:flutter/material.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class BottomNavigationWidgetLight extends StatefulWidget {
  final int currentIndex;
  const BottomNavigationWidgetLight({this.currentIndex});
  @override
  State<BottomNavigationWidgetLight> createState() =>
      new _BottomNavigationWidgetLightState(this.currentIndex);
}

class _BottomNavigationWidgetLightState
    extends State<BottomNavigationWidgetLight> with TickerProviderStateMixin {
  int currentIndex;
  int _currentIndex = 0;
  TabController _tabController;
  _BottomNavigationWidgetLightState(this.currentIndex) : super();

  @override
  void dispose() {
    super.dispose();
  }

  Channel _channel;
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(color: Colors.white),
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                indicatorColor: Theme.of(context).primaryColorLight,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 65),
                onTap: (int index) async {
                  _currentIndex = index;
                  setState(() {});
                },
                tabs: [
                  _tabController.index != 0
                      ? Tab(
                          icon: Icon(MdiIcons.cards, color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Icon(MdiIcons.cards)),
                        ),
                  _tabController.index != 1
                      ? Tab(
                          icon: Icon(Icons.notifications_rounded,
                              color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            Icons.notifications_rounded,
                          ),
                        )),
                  _tabController.index != 2
                      ? Tab(
                          icon: Icon(MdiIcons.messageReplyTextOutline,
                              color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(MdiIcons.messageReplyTextOutline),
                        )),
                  _tabController.index != 3
                      ? Tab(
                          icon: Icon(MdiIcons.account, color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Icon(MdiIcons.account)),
                        ),
                ],
              ),
            ),
          ),
          body: _screens().elementAt(_currentIndex),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // START CONNECTION WITH CHANNELS
    // START CONNECTION WITH CHANNELS

    Future<void> _initPusher() async {
      try {
        print(Pusher.init(
            '222333Aa',
            PusherOptions(
                cluster: 'mt1',
                host: 'localhost/',
                port: 6001,
                encrypted: false)));
      } catch (e) {
        print(e);
      }

      await Pusher.connect(onConnectionStateChange: (val) {
        print('result===========');
        print(val.currentState);
        print('result===========');
      }, onError: (e) {
        print('error===========');
        print(e.message);
        print('error===========');
      });

      // _channel = await Pusher.subscribe('home');

      // _channel.bind('new_message', (onEvent) {
      //   print(onEvent.data);
      // });
    }

    // _initPusher();

    // END
    // END
    if (currentIndex != null) {
      setState(() {
        _currentIndex = currentIndex;
      });
    }
    _tabController =
        new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  List<Widget> _screens() => [
        AddStoryScreen(),
        NotificationListScreen(),
        AddMessageScreen(),
        MyProfileScreen(),
      ];
}
