import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_match/model/profile_notifier.dart';
import 'package:skill_match/screens/home_screen.dart';
import 'package:skill_match/screens/login_screen.dart';
import 'package:skill_match/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileNotifier()),
        // Add other providers if needed
      ],
      child: MyApp(token: prefs.getString('token')),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if token is null and handle accordingly
    if (token == null) {
      return MaterialApp(
        title: 'Your App Title',
        theme: ThemeData(
          // Your theme configuration
        ),
        home: SignInPage(),
      );
    }

    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        // Your theme configuration
      ),
      home: JwtDecoder.isExpired(token!) == false
          ? HomeScreen(token: token)
          : SignInPage(),
    );
  }
}
