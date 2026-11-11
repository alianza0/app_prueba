import 'package:flutter_test/flutter_test.dart';

import 'package:app_prueba/main.dart';

void main() {
  testWidgets('La app abre en la pantalla de login', (tester) async {
    await tester.pumpWidget(const SmartHomeApp());
    expect(find.text('Smart Home'), findsOneWidget);
  });
}
