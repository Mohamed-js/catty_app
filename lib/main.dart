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
import 'package:PetsMating/services/socket.dart';
import 'package:flutter/services.dart';

void main() {
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
  dynamic socket;

  void initSock() async {
    final auth = Provider.of<Auth>(context, listen: false);

    await auth.tryLogin(false);
    if (auth.current_user != null) {
      socket = socketInit(
          userId: auth.current_user['id'], receiver: true, context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    initSock();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
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
}
