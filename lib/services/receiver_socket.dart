import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';

Socket receiverSocketInit({userId, receiver: false, context, chat: 0}) {
  final appState = Provider.of<AppState>(context, listen: false);
  Socket socket;

  socket = io("https://chatty-sockett.herokuapp.com/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  socket.on('connect', (data) {
    print("***RECEIVER socket.connected***");
    // Send I'm online
  });

  socket.on('message_$userId', (data) async {
    print('I will add it to general state only-----------');
    appState.insertComingMessage(data, false);
    // *************************
    final prefs = await SharedPreferences.getInstance();
    bool sound = prefs.getBool('i-pet-kk-sound');
    if (sound == null || sound) {
      FlutterRingtonePlayer.play(fromAsset: "assets/bird.mp3");
    }
    bool vibration = prefs.getBool('i-pet-kk-vibration');
    if (vibration == null || vibration) {
      if (await Vibration.hasVibrator()) {
        if (await Vibration.hasCustomVibrationsSupport()) {
          Vibration.vibrate(duration: 1000);
        } else {
          Vibration.vibrate();
          await Future.delayed(Duration(milliseconds: 500));
          Vibration.vibrate();
        }
      }
    }
    // *************************
    createMessageNotification();
  });

  socket.on('disconnect', (data) {
    print("***Receiver socket.disssconnected***");
  });

  socket.on('error', (data) {
    print(data);
  });

  socket.connect();
  return socket;
}
