import 'package:flutter/material.dart';
import 'package:pawprints/data/repositories/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/data/models/index.dart';

class ChatProvider extends ChangeNotifier {
  late final ChatRepository _repository;

  ChatProvider(this._repository);

  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    String aiMessage = '';
    final stream = _repository.streamChatCompletion(userMessage: userMessage);

    await for (final chunk in stream) {
      aiMessage += chunk;
      _messages[_messages.length - 1] = ChatMessage(text: aiMessage, isSentByMe: false, time: getCurrentTime());
      notifyListeners();
    }
    _isLoading = false;
  }
}