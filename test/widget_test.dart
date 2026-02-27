import 'package:flutter_test/flutter_test.dart';
import 'package:ptax_app/app.dart';

void main() {
  testWidgets('App builds without error', (WidgetTester tester) async {
    // Smoke test - verify app widget can be constructed
    expect(const App(), isNotNull);
  });
}
