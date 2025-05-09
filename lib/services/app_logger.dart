import 'package:logger/logger.dart';

/// 애플리케이션 전반 로깅 유틸리티.
///
/// `logger` 패키지를 기반으로 하며, 다양한 로그 레벨에 대한 정적 메서드를 제공.
/// 초기화 시 `PrettyPrinter`를 사용하여 콘솔에 보기 좋은 형태로 로그 출력.
/// 시간 정보는 기본적으로 출력하지 않음 (`DateTimeFormat.none`).
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
    ),
  );

  /// 디버그 레벨 로그 기록.
  ///
  /// 개발 중 변수 값 확인 등 상세 정보 로깅에 사용.
  ///
  /// Args:
  ///
  ///   message:     로그 메시지. (동적 타입)
  ///   error:       (선택) 연관 오류 객체.
  ///   stackTrace:  (선택) 연관 스택 트레이스.
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// 정보 레벨 로그 기록.
  ///
  /// 일반적 정보성 메시지, 주요 작업 진행 상황 등 로깅.
  ///
  /// Args:
  ///
  ///   message:     로그 메시지. (동적 타입)
  ///   error:       (선택) 연관 오류 객체.
  ///   stackTrace:  (선택) 연관 스택 트레이스.
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// 경고 레벨 로그 기록.
  ///
  /// 잠재적 문제나 예상치 못한 상황이지만, 아직 오류는 아닌 경우 사용.
  ///
  /// Args:
  ///
  ///   message:     로그 메시지. (동적 타입)
  ///   error:       (선택) 연관 오류 객체.
  ///   stackTrace:  (선택) 연관 스택 트레이스.
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// 오류 레벨 로그 기록.
  ///
  /// 명확한 오류 상황, 예외 발생 등 로깅.
  ///
  /// Args:
  ///
  ///   message:     로그 메시지. (동적 타입)
  ///   error:       (선택) 연관 오류 객체.
  ///   stackTrace:  (선택) 연관 스택 트레이스.
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// 치명적 오류(Fatal/WTF) 레벨 로그 기록.
  ///
  /// 매우 심각하고, 발생해서는 안 되는 치명적 오류 상황 로깅.
  ///
  /// Args:
  ///
  ///   message:     로그 메시지. (동적 타입)
  ///   error:       (선택) 연관 오류 객체.
  ///   stackTrace:  (선택) 연관 스택 트레이스.
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
