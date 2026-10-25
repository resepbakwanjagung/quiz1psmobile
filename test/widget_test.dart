import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_kita/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KatalogKitaApp());
    expect(find.text('KatalogKita'), findsNothing);
  });
}
