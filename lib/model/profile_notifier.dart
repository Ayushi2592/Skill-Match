import 'dart:async';
import 'package:flutter/material.dart';

class ProfileNotifier with ChangeNotifier {
  int _notificationCount = 0;
  final StreamController<void> _controller = StreamController<void>.broadcast();

  int get notificationCount => _notificationCount;
  Stream<void> get profileAddedStream => _controller.stream;

  void notifyProfileAdded() {
    _notificationCount++;
    _controller.add(null);
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}