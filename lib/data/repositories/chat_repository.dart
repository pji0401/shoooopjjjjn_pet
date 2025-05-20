import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pawprints/config/index.dart';

class ChatRepository {
  final dio = Dio(); // FIXME: BaseOptions

  Stream<String> streamChatCompletion({
    required String userMessage,
  }) async* {
    final url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";

    final headers = {
      "Authorization": "Bearer ${Constants.apiKey}",
      "Content-Type": "application/json",
      "accept": "text/event-stream",
    };

    final body = {
      "model": "gemini-2.0-flash",
      // TODO: prompt 수정 필요
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": userMessage}
      ],
      "temperature": 0.7,
      "max_tokens": 150,
      "stream": true,
    };

    final response = await dio.post<ResponseBody>(
      url,
      data: body,
      options: Options(
        responseType: ResponseType.stream,
        headers: headers,
      ),
    );

    final stream = response.data!.stream
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .transform(const LineSplitter());

    await for (final line in stream) {
      if (line.isEmpty || line == 'data: [DONE]') continue;
      if (line.startsWith('data: ')) {
        final jsonPart = line.substring(6).trim();
        try {
          final decoded = jsonDecode(utf8.decode(utf8.encode(jsonPart)));
          final content = decoded['choices'][0]['delta']['content'];
          if (content != null) {
            print("content: $content");
            yield content;
          }
        } catch (_) {
          continue;
        }
      }
    }
  }
}