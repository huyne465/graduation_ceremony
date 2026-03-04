import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_ceremony/main.dart';

void main() {
  testWidgets('App structural test', (WidgetTester tester) async {
    await tester.pumpWidget(const GraduationApp());
    expect(find.text('GRADUATION'), findsWidgets);
  });
}
