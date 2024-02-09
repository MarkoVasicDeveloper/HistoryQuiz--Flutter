import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istorija_srbije/core/global/audio_player.dart';
import 'package:istorija_srbije/core/shared/widget/background_wrapper.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/provider/user/user_service.dart';
import 'package:istorija_srbije/screens/home/home_screen.dart';
import 'package:istorija_srbije/screens/multiplayer/multiplayer_screen.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';
import 'package:istorija_srbije/screens/multiplayer_intro/multiplayer_intro_screen.dart';
import 'package:istorija_srbije/screens/question/question_screen.dart';
import 'package:istorija_srbije/screens/wheel/wheel_screen.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
    await Future.delayed(const Duration(seconds: 1));
    SystemChrome.restoreSystemUIOverlays();
  });
  Wakelock.enable();

  final userService = UserService();
  final userProvider = UserProvider(userService);

  await userProvider.initializeUserData();
  AudioPlayerSingleton().setVolumeFromUserProvider(
      userProvider.userModel.settings.volume / 100.0);
  runApp(MyApp(userProvider));
}

class MyApp extends StatelessWidget {
  final UserProvider userProvider;

  const MyApp(this.userProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userProvider),
      ],
      child: BackgroundWrapper(
        colorFilter: ColorFilter.mode(
            Colors.black54.withOpacity(0.9), BlendMode.multiply),
        child: MaterialApp(
          title: 'Istorija Srbije',
          initialRoute: '/home',
          routes: {
            '/home': (context) => HomeScreen(
                  userProvider: userProvider,
                ),
            '/wheel': (context) => WheelScreen(
                  userProvider: userProvider,
                ),
            '/questions': (context) =>
                QuestionScreen(userProvider: userProvider),
            '/multiplayer': (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              final socketService = args['socketService'] as SocketService;
              return Multiplayer(
                userProvider: userProvider,
                socketService: socketService,
              );
            },
            '/multiplayer_intro': (context) =>
                MultiplayerIntroScreen(userProvider: userProvider)
          },
        ),
      ),
    );
  }
}
