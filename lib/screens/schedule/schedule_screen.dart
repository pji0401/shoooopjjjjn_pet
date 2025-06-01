import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/core/network/index.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  final String title = '일정';

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedDayIndex = 0;
  late int currentPage;
  late PageController _pageController;

  late final DateTime baseDate;
  late final int initialPage;
  late final int totalPages;

  List<Map<String, dynamic>> generateWeek(DateTime weekStart) {
    return List.generate(7, (dayIndex) {
      final day = weekStart.add(Duration(days: dayIndex));
      const labels = ['일', '월', '화', '수', '목', '금', '토'];
      return {
        'label': labels[dayIndex],
        'date': day.day,
        'fullDate': day,
      };
    });
  }

  void fetchPlansForSelectedDate(DateTime selectedDate) {
    final provider = Provider.of<PlanProvider>(context, listen: false);
    provider.getPlanList(request: PlanListRequest(memberId: SharedPreferencesHelper().memberId, date: DateFormat('yyyy-MM-dd').format(selectedDate))).then((_) {
      if (provider.planList.uiState == UIState.COMPLETED) {
        AppLogger.d('✅ fetchPlanList: ${provider.planList.data?.plans.toString()}');
      } else {
        AppLogger.d('⚠️ data is null or wrong type');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final yearStart = DateTime(now.year, 1, 1);
    baseDate = yearStart.subtract(Duration(days: yearStart.weekday % 7));

    final yearEnd = DateTime(now.year, 12, 31);
    final totalDays = yearEnd.difference(baseDate).inDays;
    totalPages = (totalDays ~/ 7) + 1;

    initialPage = now.difference(baseDate).inDays ~/ 7;
    currentPage = initialPage;

    _pageController = PageController(initialPage: initialPage);
    selectedDayIndex = now.weekday % 7;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchPlansForSelectedDate(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanProvider>(context);

    final weekStart = baseDate.add(Duration(days: currentPage * 7));
    final currentWeek = generateWeek(weekStart);
    final selectedDay = currentWeek[selectedDayIndex];
    final selectedDateTime = selectedDay['fullDate'] as DateTime;

    return BaseScaffold(
      title: widget.title,
      leadingItem: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        onPressed: () => context.pop(),
      ),
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
                colors: [Color(0xFFEFF8EA), Color(0xFFE1E9FD)],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 27),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    '${selectedDateTime.month}월 ${selectedDateTime.day}일 ${selectedDay['label']}요일',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF070707),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 64,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                          selectedDayIndex = 0;
                          fetchPlansForSelectedDate(generateWeek(baseDate.add(Duration(days: index * 7)))[0]['fullDate'] as DateTime,);
                        });
                      },
                      itemCount: totalPages,
                      itemBuilder: (context, index) {
                        final weekStartForIndex = baseDate.add(Duration(days: index * 7));
                        final week = generateWeek(weekStartForIndex);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(7, (dayIndex) {
                            final isSelected = (index == currentPage) &&
                                (dayIndex == selectedDayIndex);
                            final day = week[dayIndex];
                            final label = day['label'] as String;

                            Color labelColor;
                            if (label == '일') {
                              labelColor = Colors.red;
                            } else if (label == '토') {
                              labelColor = Colors.blue;
                            } else {
                              labelColor = const Color(0xFF070707);
                            }

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentPage = index;
                                  selectedDayIndex = dayIndex;
                                });
                                fetchPlansForSelectedDate(generateWeek(baseDate.add(Duration(days: index * 7)))[selectedDayIndex]['fullDate'] as DateTime,);
                              },
                              child: Container(
                                width: 43,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xff4A9BF6) : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      label,
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: isSelected ? Colors.white : labelColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${day['date']}',
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: isSelected ? Colors.white : const Color(0xFF070707),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          '오늘의 일정',
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xFF070707),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(provider.planList.data?.plans.length ?? 0, (idx) {
                        return GestureDetector(
                          onTap: () {
                            provider.check(provider.planList.data?.plans[idx].id ?? 0).then((_) {
                              if (provider.isCheck.uiState == UIState.COMPLETED) {
                                AppLogger.d('✅ checkingPlan: ${provider.isCheck.data?.id}');
                              } else {
                                AppLogger.d('⚠️ data is null or wrong type');
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                            decoration: BoxDecoration(
                              color: provider.planList.data?.plans[idx].isChecked ?? false ? const Color(0xffe9f3ff) : Colors.white,
                              border: Border.all(
                                color: provider.planList.data?.plans[idx].isChecked ?? false ? const Color(0xff4A9BF6) : const Color(0xffD9D9D9),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 16, right: 12),
                                  child: Icon(
                                    Icons.check_box,
                                    color: provider.planList.data?.plans[idx].isChecked ?? false ? const Color(0xff4A9BF6) : const Color(0xffD9D9D9),
                                    size: 28,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.planList.data?.plans[idx].title ?? '',
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Color(0xFF070707),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          provider.planList.data?.plans[idx].date ?? '',
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Color(0xFF070707),
                                          ),
                                        ),
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
              onTap: () => {
                // TODO: context.push(RoutePath.schedule_write.value)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('일정 작성 기능은 준비 중입니다. (DB에 직접 일정 등록 필요)')),
                )
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xff4A9BF6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 30, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}