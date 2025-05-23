import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/viewmodels/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MissionProvider>(context, listen: false)
        .getMission(19); // FIXME: Test
  }

  @override
  Widget build(BuildContext context) {
    final missionProvider =
        Provider.of<MissionProvider>(context); // FIXME: HomeProvider

    return BaseScaffold(
        // appbar
        leadingWidth: 100,
        leadingItem: SvgPicture.asset('assets/icons/pawprint.svg'),
        trailingItems: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/notification_on.svg'),
            onPressed: () => context.push(RoutePath.notification.value),
          ),
          IconButton(
            icon: SvgPicture.asset('assets/icons/schedule.svg',
                width: 24, height: 24),
            onPressed: () => context.push(RoutePath.schedule.value),
          ),
        ],

        // body
        body: Stack(
          children: [
            // Gradient background
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEFF8EB),
                      Color(0xFFE2EAFC),
                    ],
                    stops: [0.03, 0.56],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 34,
                bottom: 83,
              ),
              child: Container(
                color: Colors.white.withAlpha(51), // 0.2 opacity
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row with user info and paw icon
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 26.0,
                                        color: Colors.black,
                                        height: 1.5,
                                      ),
                                      children: [
                                        BlueColoredText.toTextSpan('호준',
                                            fontSize: 26.0),
                                        const TextSpan(text: '님, '),
                                        BlueColoredText.toTextSpan('봄이',
                                            fontSize: 26.0),
                                        const TextSpan(text: '와 함께\n'),
                                        BlueColoredText.toTextSpan('32',
                                            fontSize: 26.0),
                                        const TextSpan(text: '개의 추억을\n쌓았어요!'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // Memory button
                                  ElevatedButton(
                                    onPressed: () {
                                      context.push(RoutePath.memory.value);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.main,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 2.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text('함께한 추억 보러 가기',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        SizedBox(width: 2),
                                        Icon(Icons.chevron_right, size: 22),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Right paw icon
                            Transform.translate(
                              offset: const Offset(-10, 60),
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.main,
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      )
                                    ]),
                                child: OverflowBox(
                                  maxWidth: 220,
                                  maxHeight: 220,
                                  child: SvgPicture.asset(
                                    'assets/icons/paw_home.svg',
                                    width: 170,
                                    height: 170,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Space between sections
                      const SizedBox(height: 40),

                      // Today's Mission Section
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  // offset: Offset(0, -2),
                                )
                              ]),
                          padding: EdgeInsets.only(top: 25, bottom: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Section header with title and action buttonn
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        HomeSectionHeader('오늘의 미션'),
                                        InkWell(
                                            onTap: () {
                                              context.push(
                                                  RoutePath.mission.value,
                                                  extra: missionProvider
                                                      .mission.data?.id);
                                            },
                                            child: Row(children: [
                                              Text('미션 수행하기',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF135DB2),
                                                  )),
                                              Icon(
                                                Icons.chevron_right,
                                                size: 16,
                                                color: Color(0xFF135DB2),
                                              )
                                            ]))
                                      ])),

                              const SizedBox(height: 15),

                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Container(
                                              child: Image.asset(
                                            'assets/datas/envelop.png',
                                            width: 70,
                                            height: 70,
                                          )),

                                          // Add space between icon and text
                                          const SizedBox(width: 16),

                                          // Right side - text content
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${missionProvider.mission.data?.description ?? ""}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  '${missionProvider.mission.data?.title ?? ""}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))),

                              const SizedBox(height: 30),

                              // Weekly Mission Status Header
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('이번주 미션 현황',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        InkWell(
                                            onTap: () {
                                              context.push(RoutePath
                                                  .mission_weekly.value);
                                            },
                                            child: Row(children: const [
                                              Text('전체보기',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF135DB2),
                                                  )),
                                              Icon(
                                                Icons.chevron_right,
                                                size: 16,
                                                color: Color(0xFF135DB2),
                                              )
                                            ]))
                                      ])),

                              const SizedBox(height: 20),

                              // Days of week
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text('일', style: TextStyle(fontSize: 14)),
                                    Text('월', style: TextStyle(fontSize: 14)),
                                    Text('화', style: TextStyle(fontSize: 14)),
                                    Text('수', style: TextStyle(fontSize: 14)),
                                    Text('목', style: TextStyle(fontSize: 14)),
                                    Text('금', style: TextStyle(fontSize: 14)),
                                    Text('토', style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Paw icons
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildPawDayStatus(true),
                                    // 일 - completed
                                    _buildPawDayStatus(false),
                                    // 월 - not completed
                                    _buildPawDayStatus(true),
                                    // 화 - completed
                                    _buildPawDayStatus(true),
                                    // 수 - completed
                                    _buildPawDayStatus(false),
                                    // 목 - not completed
                                    _buildPawDayStatus(false),
                                    // 금 - not completed
                                    _buildPawDayStatus(false),
                                    // 토 - not completed
                                  ],
                                ),
                              ),
                            ],
                          )),

                      getSectionDivider(), // 05.23 - MEMO: section divider 대체 (작성자 정태영)

                      // Mission Feed Section

                      // fundamental container with setting
                      Container(
                          width: double.infinity,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                            )
                          ]),
                          padding: EdgeInsets.symmetric(vertical: 25),

                          // Main content
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // header section
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          HomeSectionHeader('미션 피드'),
                                          InkWell(
                                              onTap: () {
                                                context.push(
                                                    RoutePath.memory.value);
                                              },
                                              child: Row(children: const [
                                                Text('전체보기',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    )),
                                                Icon(
                                                  Icons.chevron_right,
                                                  size: 16,
                                                  color: Colors.black,
                                                )
                                              ]))
                                        ])),

                                const SizedBox(height: 20),

                                // Horizontal Scrollable mission cards
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 10),
                                    child: Row(
                                      children: [
                                        _buildMissionCard(
                                          'assets/images/dog_home_test.jpg',
                                          '최애 장난감으로\n하루종일 공놀이',
                                        ),
                                        const SizedBox(width: 12),
                                        _buildMissionCard(
                                          'assets/images/dog_home_test.jpg',
                                          '최애 장난감으로\n하루종일 공놀이',
                                        ),
                                        const SizedBox(width: 12),
                                        _buildMissionCard(
                                          'assets/images/dog_home_test.jpg',
                                          '최애 장난감으로\n하루종일 공놀이',
                                        ),
                                        const SizedBox(width: 12),
                                        _buildMissionCard(
                                          'assets/images/dog_home_test.jpg',
                                          '최애 장난감으로\n하루종일 공놀이',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ])),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildPawDayStatus(bool isCompleted) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/paw_weekly_home.svg',
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(
            isCompleted ? AppColors.main : Colors.grey[300]!,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isCompleted ? '완료' : '실패',
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? AppColors.main : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard(String imagePath, String title) {
    return Container(
      width: 138,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for better text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),

          // Text at the bottom
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
