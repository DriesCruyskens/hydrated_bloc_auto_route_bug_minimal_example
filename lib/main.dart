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

    // Only works for `flutter run`, not for `flutter test`
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

        return const Center(child: Text("test"),);
      }),
    );
  }
}
