import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen();

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  bool vibrationStatus = false;
  bool soundStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Notifications Settings",
                  style: Theme.of(context).primaryTextTheme.headline1,
                ),
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.vibration,
                    color: Color(0xFF33196B),
                  ),
                  title: Text(
                    'Vibration',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33196B),
                    ),
                  ),
                  trailing: SizedBox(
                    width: 50.0,
                    height: 25.0,
                    child: FlutterSwitch(
                      width: 50.0,
                      height: 25.0,
                      valueFontSize: 10.0,
                      toggleSize: 15.0,
                      value: vibrationStatus,
                      borderRadius: 30.0,
                      padding: 4.0,
                      onToggle: (val) async {
                        setState(() {
                          vibrationStatus = val;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('i-pet-kk-vibration', val);
                      },
                      activeColor: Color(0xFF33196B),
                      inactiveColor: Color.fromARGB(85, 51, 25, 107),
                    ),
                  ),
                ),
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.music_note,
                    color: Color(0xFF33196B),
                  ),
                  title: Text(
                    'Sound Alert',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33196B),
                    ),
                  ),
                  trailing: SizedBox(
                    width: 50.0,
                    height: 25.0,
                    child: FlutterSwitch(
                      width: 50.0,
                      height: 25.0,
                      valueFontSize: 10.0,
                      toggleSize: 15.0,
                      value: soundStatus,
                      borderRadius: 30.0,
                      padding: 4.0,
                      onToggle: (val) async {
                        setState(() {
                          soundStatus = val;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('i-pet-kk-sound', val);
                      },
                      activeColor: Color(0xFF33196B),
                      inactiveColor: Color.fromARGB(85, 51, 25, 107),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    void getPrefs() async {
      final prefs = await SharedPreferences.getInstance();
      bool sound = prefs.getBool('i-pet-kk-sound');
      bool vibration = prefs.getBool('i-pet-kk-vibration');

      setState(() {
        if (sound != null) {
          soundStatus = sound;
        }
        if (vibration != null) {
          vibrationStatus = vibration;
        }
      });
    }

    getPrefs();
    super.initState();
  }
}
