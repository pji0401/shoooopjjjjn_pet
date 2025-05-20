import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/config.dart';

class MemoryEndpoint {
  static const String _memoryPath = '${Constants.baseUrl}/memories';

  static ApiRequest getMemory(int id) => ApiRequest(
        path: '$_memoryPath/:id',
        pathParams: {'id': id},
      );

  static ApiRequest getMemoryList(int id) => ApiRequest(
        path: '$_memoryPath/members/:id',
        pathParams: {'id': id},
      );
}