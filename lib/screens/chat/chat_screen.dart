import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/data/models/index.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  final String title = 'AI 챗봇';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  static const TextStyle chatBubbleTextStyle = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: -0.24,
  );

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final _messages = chatProvider.messages;
    return BaseScaffold(
      title: widget.title,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        fontFamily: 'Pretendard',
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 34,
              bottom: 83,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFEFF8EA),
                  Color(0xFFE1E9FD),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Column(
              children: [
                SingleChildScrollView(child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 600), // FIXME: - MediaQuery.of(context).viewInsets.bottom * 0.5
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Align(
                        alignment: message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (!message.isSentByMe) ...[
                                Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(18.0),
                                        topRight: Radius.circular(18.0),
                                        bottomRight: Radius.circular(18.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      message.text,
                                      style: chatBubbleTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  message.time,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                              if (message.isSentByMe) ...[
                                Text(
                                  message.time,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF5CA8FF),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18.0),
                                        topRight: Radius.circular(18.0),
                                        bottomLeft: Radius.circular(18.0),
                                      ),
                                    ),
                                    child: Text(
                                      message.text,
                                      style: chatBubbleTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 134 + MediaQuery.of(context).viewInsets.bottom * 0.7,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: const Color(0xFF5CA8FF),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: '메시지를 입력하세요.',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                            color: Color(0xff8D8D8D),
                            height: 40 / 13,
                            letterSpacing: -0.24,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                        ),
                        style: const TextStyle(fontSize: 16),
                        minLines: 1,
                        maxLines: 3,
                      ),
                    ),
                    IconButton(
                        icon: SvgPicture.asset('assets/icons/send.svg'),
                        onPressed: () async {
                          final text = _messageController.text.trim();
                          if (text.isEmpty) return;
                          setState(() {
                            _messages.add(ChatMessage(
                                text: text,
                                isSentByMe: true,
                                time: getCurrentTime()
                            ));
                          });
                          _messageController.clear();
                          setState(() {
                            _messages.add(ChatMessage(
                                text: '',
                                isSentByMe: false,
                                time: getCurrentTime()
                            ));
                          });
                          await chatProvider.sendMessage(text);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}