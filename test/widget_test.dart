import 'package:flutter_test/flutter_test.dart';

import 'package:feedshift/main.dart';

void main() {
  testWidgets('Home page renders information terrain', (tester) async {
    await tester.pumpWidget(const FeedShiftApp());
    await tester.pump();
    expect(find.text('FeedShift'), findsOneWidget);
    expect(find.text('最近的信息地形'), findsWidgets);
    expect(find.text('先等一片地形长出来'), findsOneWidget);
  });
}
