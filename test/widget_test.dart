import 'package:flutter_test/flutter_test.dart';

import 'package:triary_app/main.dart';

void main() {
  testWidgets('Main screen renders offline and online buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Offline usage'), findsOneWidget);
    expect(find.text('Online usage'), findsOneWidget);
  });
}
