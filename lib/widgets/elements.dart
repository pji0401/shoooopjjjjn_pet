import 'package:flutter/material.dart';

/// 섹션 구분선 위젯 생성.
///
/// 회색 배경의 가로 구분선 위젯을 반환. 전체 화면 너비를 차지하며 UI 섹션 분리에 사용.
///
/// Returns:
///
///     구분선 역할의 Container 위젯
Widget getSectionDivider() {
  return Container(
    width: double.infinity,
    height: 12.0,
    color: const Color(0xFFF5F5F9),
  );
}
