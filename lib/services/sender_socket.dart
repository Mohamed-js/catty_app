import 'package:PetsMating/services/app_state.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

Socket senderSocketInit(
    {userId, receiver: false, context, chat: 0, refreshChat: 0}) {
  final appState = Provider.of<AppState>(context, listen: false);
  Socket socket;

  socket = io("https://chatty-sockett.herokuapp.com/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  socket.on('connect', (data) {
    print("***SENDER socket.connected***");
  });

  socket.on('message_$userId', (data) {
    print('I will add it to all states ==================');

    refreshChat();
  });

  socket.on('disconnect', (data) {
    print("***Sender socket.disssconnected***");
  });

  socket.on('error', (data) {
    print(data);
  });

  socket.connect();
  return socket;
}
