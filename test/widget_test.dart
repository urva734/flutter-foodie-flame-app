import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_flame/main.dart';

void main() {
  testWidgets('Foodie Flame loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FoodieFlameApp());

    // Verify that Foodie Flame text shows up.
    expect(find.text('Foodie Flame 🔥'), findsOneWidget);
  });
}