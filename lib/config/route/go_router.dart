import 'package:go_router/go_router.dart';
import 'package:pawprints/screens/auth/signup_profile_screen.dart';
import 'package:pawprints/screens/auth/signup_user_screen.dart';
import 'package:pawprints/screens/index.dart';  
import 'package:pawprints/config/index.dart';

final router = GoRouter(
  initialLocation: RoutePath.login.value,
  routes: [
    // Auth
    GoRoute(path: RoutePath.login.value, builder: (context, state) => const LoginScreen()),
    GoRoute(path: RoutePath.signup_user.value, builder: (context, state) => const SignUpUserScreen()),
    GoRoute(path: RoutePath.signup_profile.value, builder: (context, state) => const SignUpProfileScreen()),
    GoRoute(path: RoutePath.signup_pet.value, builder: (context, state) => const SignUpPetScreen()),
    GoRoute(path: RoutePath.signup_welcome.value, builder: (context, state) => const SignUpWelcomeScreen()),

    // Home
    GoRoute(path: RoutePath.root.value, builder: (context, state) => const RootScreen()),
    GoRoute(path: RoutePath.home.value, builder: (context, state) => const HomeScreen()),

    // Mission
    GoRoute(path: RoutePath.mission.value, builder: (context, state) => const MissionScreen()),
    // WIP: GoRoute(path: RoutePath.mission_today.value, builder: (context, state) => const MissionTodayScreen()),
    // GoRoute(path: RoutePath.mission_weekly.value, builder: (context, state) => const MissionWeeklyScreen()),
    GoRoute(path: RoutePath.mission_write.value, builder: (context, state) => const MissionWriteScreen()),
    GoRoute(path: RoutePath.mission_complete.value, builder: (context, state) => MissionCompleteScreen(memoryId: state.extra as int)),

    // Memory
    GoRoute(path: RoutePath.memory.value, builder: (context, state) => const MemoryScreen()),

    // Community
    GoRoute(path: RoutePath.community.value, builder: (context, state) => const CommunityScreen()),
    GoRoute(path: RoutePath.community_write.value, builder: (context, state) => const WritePostScreen()),
    // GoRoute(path: RoutePath.community_search.value, builder: (context, state) => const CommunitySearchScreen()),
    GoRoute(path: RoutePath.community_profile.value, builder: (context, state) => const CommunityProfileScreen()),
    // WIP: GoRoute(path: RoutePath.community_detail.value, builder: (context, state) => const CommunityDetailScreen()),

    // Care
    GoRoute(path: RoutePath.care.value, builder: (context, state) => const CareScreen()),
    // GoRoute(path: RoutePath.careDetail.value, builder: (context, state) => const CareDetailScreen()),

    // Etc
    GoRoute(path: RoutePath.chat.value, builder: (context, state) => const ChatScreen()),
    GoRoute(path: RoutePath.my.value, builder: (context, state) => const MyScreen()),
    GoRoute(path: RoutePath.schedule.value, builder: (context, state) => const ScheduleScreen()),
    // GoRoute(path: RoutePath.schedule_write.value, builder: (context, state) => const ScheduleWriteScreen()),
    GoRoute(path: RoutePath.notification.value, builder: (context, state) => const NotificationScreen()),
  ],
);