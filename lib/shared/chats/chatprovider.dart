import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages =
      []; //<<<< list holds all the chat messages >>>>
  final TextEditingController messageController =
      TextEditingController(); //<<<<  controller manages the input field text.>>>

  List<ChatMessage> get messages =>
      _messages; //<<<<Provides read-only access to _messages from outside (like the UI).>>>

  void sendMessage(String text, bool isUser) {
    if (text.trim().isEmpty) return;
    _messages.add(ChatMessage(message: text, isUser: isUser));
    messageController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String message;
  final bool isUser;

  ChatMessage({required this.message, required this.isUser});
}
