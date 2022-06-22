import 'package:PetsMating/Theme/nativeTheme.dart';
import 'package:PetsMating/l10n/l10n.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/provider/local_provider.dart';
import 'package:PetsMating/screens/splashScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:redis/redis.dart';

void main() {
  // IO.Socket socket = IO.io('http://localhost:3000/');

  // socket.onConnect((_) {
  //   print('connect');
  //   print(_);
  //   socket.emit('message', 'test');
  // });
  // socket.connect();

  // socket.onError((data) => print(data));

  // socket.on('connection', (data) => print('connected'));
  // socket.on('disconnect', (data) => print('connected'));
  // socket.on('message', (data) => print(data));

  // socket.connect();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Phoenix(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth()),
          ChangeNotifierProvider(create: (context) => AppState()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  dynamic analytics;
  dynamic observer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: nativeTheme(g.isDarkModeEnable),
          home: SplashScreen(a: analytics, o: observer),
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      });
}
