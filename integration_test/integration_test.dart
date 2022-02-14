import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapp/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('test', () {
    testWidgets('test', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });
}
