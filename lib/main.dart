import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/widget/background_wrapper.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/provider/user/user_service.dart';
import 'package:istorija_srbije/screens/home/home_screen.dart';
import 'package:istorija_srbije/screens/wheel/wheel_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userService = UserService();
  final userProvider = UserProvider(userService);

  await userProvider.initializeUserData();
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
                )
          },
        ),
      ),
    );
  }
}
