import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:myapp/profile_cubit.dart';
import 'package:myapp/router.gr.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();

    // Works for both `flutter run` and `flutter test`
    // return const MaterialApp(home: HomePage(),);

    // Works for both `flutter run` and `flutter test`
    // return MaterialApp(initialRoute: '/', routes: {
    //   '/': (context) => const HomePage(),
    // });

    // Custom InformationParser and RouterDelegate works for both `flutter run` and `flutter test`
    // return MaterialApp.router(
    //   routeInformationParser: HomeRouteInformationParser(),
    //   routerDelegate: HomeRouterDelegate(),
    // );

    // auto_route works for `flutter run` but not for `flutter test`
    return MaterialApp.router(
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(router),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        ProfileCubit().fetchProfile();

        return const Center(
          child: Text("test"),
        );
      }),
    );
  }
}

// Below are simple custom Navigator 2.0 classes to demonstrate it works with those.

class HomeRoutePath {
  HomeRoutePath.home();
}

class HomeRouterDelegate extends RouterDelegate<HomeRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<HomeRoutePath> {
  final GlobalKey<NavigatorState> _navigatorKey;

  HomeRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: const [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: HomePage(),
        ),
      ],
      onPopPage: (route, result) {
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(HomeRoutePath configuration) async {}
}

class HomeRouteInformationParser extends RouteInformationParser<HomeRoutePath> {
  @override
  Future<HomeRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    return HomeRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(HomeRoutePath path) {
      return const RouteInformation(location: '/');
  }
}
