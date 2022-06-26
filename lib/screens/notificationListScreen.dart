import 'package:PetsMating/models/addNewNotification.dart';
import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/ownerProfileScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/notifications.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:PetsMating/services/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class NotificationListScreen extends BaseRoute {
  NotificationListScreen({a, o})
      : super(a: a, o: o, r: 'NotificationListScreen');
  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _NotificationListScreenState() : super();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
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
              key: _scaffoldKey,
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text(
                    AppLocalizations.of(context).lbl_notifications,
                    style: Theme.of(context).primaryTextTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  automaticallyImplyLeading: false),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: loading
                  ? Center(
                      child: Text('loading...',
                          style: Theme.of(context).primaryTextTheme.bodyText1))
                  : appState.notificationList.isEmpty
                      ? Center(
                          child: Text('No current notifications...',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1))
                      : Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 20),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .lbl_notifications_subtitle,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: appState.notificationList.length,
                                  itemBuilder: (ctx, index) {
                                    print(appState.notificationList[index]);
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => appState
                                                                    .notificationList[
                                                                index][
                                                            'redirect_to_id'] ==
                                                        null
                                                    ? BottomNavigationWidgetLight(
                                                        currentIndex: 2)
                                                    : OwnerProfileScreen(appState
                                                                .notificationList[
                                                            index]
                                                        ['redirect_to_id'])));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                appState.notificationList[index]
                                                            ['img'] !=
                                                        null
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 31,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            '${appState.notificationList[index]['img']}',
                                                          ),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          radius: 30,
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 31,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                            'assets/images/card_img_2.png',
                                                          ),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          radius: 30,
                                                        ),
                                                      ),
                                                Flexible(
                                                  child: Padding(
                                                    padding: g.isRTL
                                                        ? const EdgeInsets.only(
                                                            right: 12)
                                                        : const EdgeInsets.only(
                                                            left: 12),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          appState.notificationList[
                                                              index]['title'],
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .subtitle1,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: Text(
                                                              appState.notificationList[
                                                                      index]
                                                                  ['body'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .bodyText1,
                                                            )),
                                                        Text(
                                                          DateFormat.yMMMEd().format(
                                                              DateTime.parse(
                                                                  appState.notificationList[
                                                                          index]
                                                                      [
                                                                      'updated_at'])),
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .subtitle2,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 12, bottom: 12),
                                          height: 1.5,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: g.gradientColors,
                                            ),
                                          ),
                                          child: Divider(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    final appState = Provider.of<AppState>(context, listen: false);
    appState.getNotifications();
  }
}
