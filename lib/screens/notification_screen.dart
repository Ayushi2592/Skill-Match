import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_match/model/profile_notifier.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();

    // Access the ProfileNotifier using Provider and listen to the stream
    final profileNotifier = Provider.of<ProfileNotifier>(context, listen: false);
    _subscription = profileNotifier.profileAddedStream.listen(() {
      print('Notification received in NotificationScreen');
    } as void Function(void event)?);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notification content goes here'),
      ),
    );
  }
}