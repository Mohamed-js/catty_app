import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/notifications.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

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

  socket.on('message_$userId', (data) {
    print('I will add it to general state only-----------');
    appState.insertComingMessage(data, false);
    FlutterRingtonePlayer.play(fromAsset: "assets/bird.mp3");
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
