import 'package:PetsMating/services/app_state.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

Socket socketInit({userId, receiver: false, context}) {
  final appState = Provider.of<AppState>(context, listen: false);
  Socket socket;
  print('TRYYYYYYING TO Connect ==================================');
  socket = io("http://i-pet.herokuapp.com:3000/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  socket.connect();

  socket.on('connect', (data) {
    print("socket.connected");
    // Send I'm online
  });

  socket.on('message', (data) {
    print('Emitted message ====');
    print(data);
    print('Emitted message ====');
  });

  if (receiver) {
    socket.on('message_$userId', (data) {
      print('==== Coming message ====');
      print(data);
      print('==== Coming message ====');
      appState.insertComingMessage(data);
    });
  }

  socket.on('disconnect', (data) {
    print('disconnect');
  });

  socket.on('error', (data) {
    print('error');
  });

  print('END TRYYYYYYING TO Connect ==============================');
  return socket;
}
