import 'package:flutter_test/flutter_test.dart';
import 'package:usedev_uninassau/main.dart';

void main() {
  testWidgets('App inicia na tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Promos Especiais'), findsOneWidget);
  });
}
