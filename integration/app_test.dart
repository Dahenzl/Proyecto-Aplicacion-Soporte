import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:proyecto_aplicacion_soporte/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end test', () {
    testWidgets('Login, navigate through coordinator pages, and logout', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login page
      expect(find.text('Login with email'), findsOneWidget);
      await tester.enterText(find.bySemanticsLabel('Email address'), 'a@a.com');
      await tester.enterText(find.bySemanticsLabel('Password'), '123456');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Coordinator main page
      expect(find.text('Welcome Back Coordinator A!'), findsOneWidget);
      await tester.tap(find.text('Clients List'));
      await tester.pumpAndSettle();

      // Clients list page
      expect(find.text('Clients List'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Create client page
      expect(find.text('New User'), findsOneWidget);
      await tester.enterText(find.bySemanticsLabel('First Name'), 'John');
      await tester.enterText(find.bySemanticsLabel('Last Name'), 'Doe');
      await tester.enterText(find.bySemanticsLabel('Email'), 'john@doe.com');
      await tester.tap(find.text('Save'));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Back to clients list, check if new client is there
      expect(find.text('John Doe'), findsOneWidget);
      //await tester.pump(const Duration(seconds: 4));
      await tester.tap(find.text('John Doe'));
      await tester.pumpAndSettle();

      // Edit client page
      expect(find.text('John Doe'), findsOneWidget);
      await tester.enterText(find.bySemanticsLabel('First Name'), 'Jane');
      await tester.tap(find.text('Update'));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Back to clients list, check if client was updated
      expect(find.text('Jane Doe'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Go to support list
      await tester.tap(find.text('Support List'));
      await tester.pumpAndSettle();

      // Support list page
      expect(find.text('Support List'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Create support page
      expect(find.text('New User'), findsOneWidget);
      await tester.enterText(find.bySemanticsLabel('First Name'), 'Alex');
      await tester.enterText(find.bySemanticsLabel('Last Name'), 'Support');
      await tester.enterText(find.bySemanticsLabel('Email'), 'alex@support.com');
      await tester.enterText(find.bySemanticsLabel('Password'), '123456');
      await tester.tap(find.text('Save'));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Back to support list, check if new support is there
      expect(find.text('Alex Support'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Go to report list
      await tester.tap(find.text('Report List'));
      await tester.pumpAndSettle();

      // Report list page
      expect(find.text('Reports List'), findsOneWidget);
      await tester.tap(find.byType(Card).first);
      await tester.pumpAndSettle();

      // Back to coordinator main
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Logout
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // Back to login page
      expect(find.text('Login with email'), findsOneWidget);
    });

    testWidgets('Login as support, report work, view my reports, and logout', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login page
      expect(find.text('Login with email'), findsOneWidget);
      await tester.enterText(find.bySemanticsLabel('Email address'), 'alex@support.com');
      await tester.enterText(find.bySemanticsLabel('Password'), '123456');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Support main page
      expect(find.text('Welcome Back Support Support!'), findsOneWidget);
      await tester.tap(find.text('Report Work'));
      await tester.pumpAndSettle();

      // Send report page
      expect(find.text('Send Report'), findsOneWidget);
      await tester.tap(find.text('Select a client'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Jane Doe').first);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      await tester.enterText(find.bySemanticsLabel('Enter the title'), 'Test Report');
      await tester.enterText(find.bySemanticsLabel('Enter the description'), 'This is a test report');
      await tester.tap(find.text('Select date and time'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.enterText(find.bySemanticsLabel('Enter the duration (minutes)'), '30');
      await tester.tap(find.text('Send'));
      await tester.pumpAndSettle();

      // Success snackbar
      expect(find.text('Report sent successfully!'), findsOneWidget);

      // Back to support main
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Go to my reports
      await tester.tap(find.text('My reports'));
      await tester.pumpAndSettle();

      // My reports page
      expect(find.text('Reports List'), findsOneWidget);
      await tester.tap(find.byType(Card).first);
      await tester.pumpAndSettle();

      // View my report page
      expect(find.text('Description:'), findsOneWidget);
      expect(find.byType(RatingBar), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Back to support main
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Logout
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();

      // Back to login page
      expect(find.text('Login with email'), findsOneWidget);
    });
  });
}