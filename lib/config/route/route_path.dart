enum RoutePath {
  // Auth
  login,
  signup_user,
  signup_profile,
  signup_pet,
  signup_welcome,

  // Home
  root,
  home,

  // Mission
  mission,
  // WIP: mission_today,
  mission_weekly,
  mission_write,
  mission_complete,

  // Memory
  memory,

  // Community
  community,
  community_write,
  community_search,
  community_profile,
  // WIP: community_detail,

  // Care
  care,
  careDetail,

  // Etc
  chat,
  my,
  schedule,
  schedule_write,
  notification,
}

extension RoutePathExtension on RoutePath {
  String get value {
    switch (this) {
    // Auth
      case RoutePath.login:
        return '/login';
      case RoutePath.signup_user:
        return '/signup/user';
      case RoutePath.signup_profile:
        return '/signup/profile';
      case RoutePath.signup_pet:
        return '/signup/pet';
      case RoutePath.signup_welcome:
        return '/signup/welcome';

    // Home
      case RoutePath.root:
        return '/';
      case RoutePath.home:
        return '/home';

    // Mission
      case RoutePath.mission:
        return '/mission';
      // WIP: case RoutePath.mission_today: return '/mission_today';
      case RoutePath.mission_weekly:
        return '/mission/weekly';
      case RoutePath.mission_write:
        return '/mission/write';
      case RoutePath.mission_complete:
        return '/mission/complete';

    // Memory
      case RoutePath.memory:
        return '/memory';

    // Community
      case RoutePath.community:
        return '/community';
      case RoutePath.community_write:
        return '/community/write';
      case RoutePath.community_search:
        return '/community/search';
      case RoutePath.community_profile:
        return '/community/profile';
      // WIP: case RoutePath.community_detail: return '/community/detail';

    // Care
      case RoutePath.care:
        return '/care';
      case RoutePath.careDetail:
        return '/care/detail';

    // Etc
      case RoutePath.chat:
        return '/chat';
      case RoutePath.my:
        return '/my';
      case RoutePath.schedule:
        return '/schedule';
      case RoutePath.schedule_write:
        return '/schedule/write';
      case RoutePath.notification:
        return '/notification';
    }
  }
}