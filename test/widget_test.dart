
import 'package:flutter_test/flutter_test.dart';

import 'package:potato_disease_detection_system/main.dart';

void main() {
  testWidgets('App loads and displays select image text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PotatoDiseaseApp());

    // Verify that our app displays 'Select a potato image'.
    expect(find.text('Select a potato image'), findsOneWidget);
    expect(find.text('Detect Disease'), findsOneWidget);
  });
}
