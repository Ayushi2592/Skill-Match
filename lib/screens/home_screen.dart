import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_match/screens/make_profile_screen.dart';
import 'package:skill_match/screens/notification_screen.dart';
import 'package:skill_match/screens/profile_screen.dart';
import 'package:skill_match/model/profile_model.dart';
import 'package:skill_match/model/profile_notifier.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({@required this.token,Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late String email;
  @override
  void initState(){
    //TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
  }
  @override
  Widget build(BuildContext context) {
    final profileNotifier = Provider.of<ProfileNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE57734),
        leading: Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Navigate to NotificationScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            if (profileNotifier.notificationCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 8,
                  child: Text(
                    '${profileNotifier.notificationCount}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text('Profile Check'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 80, bottom: 40),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(
              "https://wallpaper.dog/large/10708056.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (profileNotifier.notificationCount > 0) {
                  // If there are notifications, view the profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        profile: Profile(
                          name: "John Doe",
                          contactNumber: '',
                          academicYear: '',
                          branch: '',
                          skills: '',
                          githubLink: '',
                          linkedinId: '',
                          // Add other profile details as needed
                        ),
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('No Profile Available'),
                        content: Text('You have not created a profile yet.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE57734),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text('View Profile', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MakeProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE57734),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text('Make Profile', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}