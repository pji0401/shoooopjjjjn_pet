import 'package:flutter/material.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/config/index.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  final String title = '일정';

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedDayIndex = 4;

  int currentMonth = 4;

  final List<Map<String, dynamic>> days = [
    {'label': '일', 'date': 13},
    {'label': '월', 'date': 14},
    {'label': '화', 'date': 15},
    {'label': '수', 'date': 16},
    {'label': '목', 'date': 17},
    {'label': '금', 'date': 18},
    {'label': '토', 'date': 19},
  ];

  final Map<int, List<Map<String, dynamic>>> schedulesByDate = {
    13: [
      {'title': '일정 없음', 'subtitle': '', 'done': false},
    ],
    14: [
      {'title': '월요일 일정', 'subtitle': '오전 9시', 'done': false},
    ],
    17: [
      {'title': '세온 동물병원 검진', 'subtitle': '오전 11시', 'done': true},
      {'title': '사료랑 간식 구매', 'subtitle': '병원갔다 펫마트 들르기', 'done': false},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final selectedDay = days[selectedDayIndex];
    final selectedDate = selectedDay['date'] as int;
    final selectedWeekday = selectedDay['label'] as String;
    final schedules = schedulesByDate[selectedDate] ?? [];

    return BaseScaffold(
      title: widget.title,
      leadingItem: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () {
            context.pop();
          }),
      body: Stack(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFEFF8EA),
                  Color(0xFFE1E9FD),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 34,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 27),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                            '$currentMonth월 $selectedDate일 $selectedWeekday요일',
                            style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color(0xFF070707))),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 64,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: days.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, idx) {
                            final isSelected = idx == selectedDayIndex;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDayIndex = idx;
                                });
                              },
                              child: Container(
                                width: 43,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xff4A9BF6)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(days[idx]['label'],
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: isSelected
                                                ? Color(0xFFFFFFFF)
                                                : Color(0xFF070707))),
                                    const SizedBox(height: 4),
                                    Text('${days[idx]['date']}',
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: isSelected
                                                ? Color(0xFFFFFFFF)
                                                : Color(0xFF070707))),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text('오늘의 일정',
                            style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color(0xFF070707))),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(schedules.length, (idx) {
                        final s = schedules[idx];
                        final isDone = s['done'] as bool;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              schedules[idx]['done'] = !isDone;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 12),
                            decoration: BoxDecoration(
                              color: isDone
                                  ? const Color(0xffe9f3ff)
                                  : Color(0xffffffff),
                              border: Border.all(
                                  color: isDone
                                      ? const Color(0xff4A9BF6)
                                      : const Color(0xffD9D9D9),
                                  width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 12),
                                  child: Icon(
                                    Icons.check_box,
                                    color: isDone
                                        ? const Color(0xff4A9BF6)
                                        : const Color(0xffD9D9D9),
                                    size: 28,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(s['title'],
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Color(0xFF070707))),
                                        const SizedBox(height: 4),
                                        Text(s['subtitle'],
                                            style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Color(0xFF070707))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 24,
            bottom: MediaQuery.of(context).padding.bottom + 30,
            child: GestureDetector(
              onTap: () {
                context.push(RoutePath.schedule_write.value);
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xff4A9BF6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
