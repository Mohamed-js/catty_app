import 'package:PetsMating/services/app_state.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

Socket socketInit({userId, receiver: false, context, chat: 0, refreshChat: 0}) {
  final appState = Provider.of<AppState>(context, listen: false);
  Socket socket;
  print('TRYYYYYYING TO Connect ==================================');
  socket = io("https://chatty-sockett.herokuapp.com/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  socket.connect();

  socket.on('connect', (data) {
    print("socket.connected");
    // Send I'm online
  });

  socket.on('message_$userId', (data) {
    print('I will decide what to do with the message..');
    // if no current opened chat, send notificationto tha chatsssss cstate
    if (receiver) {
      print('I will add it to general state only-----------');
      appState.insertComingMessage(data);
      FlutterRingtonePlayer.play(fromAsset: "assets/bird.mp3");
    }
    // if there is current chat it means that the socket is listenning from the chat itself and there is _chat to add the messae to ++ add to the general state
    else {
      print('I will add it to all statse only==============');
      appState.insertComingMessage(data);
      refreshChat();
    }
  });

  socket.on('disconnect', (data) {
    print('disconnect');
  });

  socket.on('error', (data) {
    print('error');
  });

  print('END TRYYYYYYING TO Connect ==============================');
  return socket;
}
