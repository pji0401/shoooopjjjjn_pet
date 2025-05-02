import 'package:flutter/material.dart';
import 'package:pawprints/screens/base_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  final String title = "AI 챗봇";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: '안녕하세요!', isSentByMe: false, time: '10:00 AM'),
    ChatMessage(
        text:
            '안녕하세요! 어떻게 도와드릴까요? 안녕하세요! 어떻게 도와드릴까요? 안녕하세요! 어떻게 도와드릴까요? 안녕하세요! 어떻게 도와드릴까요? 안녕하세요! 어떻게 도와드릴까요? 안녕하세요! 어떻게 도와드릴까요? 안녕하세요! 어떻게 도와드릴까요?',
        isSentByMe: true,
        time: '10:01 AM'),
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    String text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
            text: text, isSentByMe: true, time: _formatCurrentTime()));
      });
      _messageController.clear();
      // 로직 구현
    }
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "AI 챗봇",
      leadingItems: [
      ],
      trailingItems: [
      ],
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF), // 0%
              Color(0xFFEFF8EA), // 50%
              Color(0xFFE1E9FD), // 100%
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.isSentByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: message.isSentByMe
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),
                          bottomLeft: message.isSentByMe
                              ? const Radius.circular(10.0)
                              : Radius.zero,
                          bottomRight: message.isSentByMe
                              ? Radius.zero
                              : const Radius.circular(10.0),
                        ),
                      ),
                      // ),
                      child: Column(
                        crossAxisAlignment: message.isSentByMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
                            style: TextStyle(
                              color: message.isSentByMe
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            message.time,
                            style: TextStyle(
                              color: message.isSentByMe
                                  ? Colors.white70
                                  : Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // 전송 버튼
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFFFE7442)),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
  });
}
