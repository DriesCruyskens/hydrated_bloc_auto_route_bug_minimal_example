import 'package:auto_route/annotations.dart';
import 'package:myapp/main.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      path: '/home',
      page: HomePage,
    ),
  ],
)
class $AppRouter {}
