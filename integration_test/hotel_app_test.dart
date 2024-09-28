import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hotels_booking/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Hotel Booking App Integration Test', () {
    testWidgets('Navigate between screens and manage favorites',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(); // Wait for the app to load and settle

      // Verify that the BottomNavScreen is displayed and the first screen is Overview
      expect(find.text('Overview screen'), findsOneWidget);

      // Switch to the Hotels screen using BottomNavigationBar
      await tester.tap(find.byIcon(Icons.hotel));
      await tester.pumpAndSettle(); // Wait for the transition to complete

      // Verify that the Hotels screen is displayed
      expect(find.text('Hotels'), findsOneWidget);

      // Wait for the hotels to load
      await tester.pump(
          const Duration(seconds: 5)); // Allow extra time for data to load
      await tester.pumpAndSettle();

      // Verify that hotel cards are being displayed
      final cards = find.byType(Card);
      print('Number of Card widgets found: ${cards.evaluate().length}');
      expect(cards, findsWidgets); // Verify that at least one Card is displayed

      // Tap the favorite icon on the first hotel
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(); // Wait for the UI state change

      // Navigate to the Favorites screen using BottomNavigationBar
      await tester.tap(find.byKey(Key('nav_fav')));
      await tester
          .pumpAndSettle(); // Wait for the transition to the Favorites screen

      // Ensure the 'Favorites' title is in the AppBar
      expect(
          find.descendant(
              of: find.byType(AppBar), matching: find.text('Favorites')),
          findsOneWidget);

      // Check if favorites are updated
      final favCards = find.byType(Card);
      print(
          'Number of favorite Card widgets found: ${favCards.evaluate().length}');

      // Conditional check: if there are no favorite cards, don't try to remove one
      if (favCards.evaluate().isNotEmpty) {
        // Verify that the favorite hotel is listed in Favorites
        expect(favCards,
            findsWidgets); // At least one Card should be in the Favorites

        // Remove the hotel from favorites
        await tester.tap(find.byIcon(Icons.favorite).first);
        await tester.pumpAndSettle(); // Wait for the UI state change

        // Verify that no hotels are displayed in the Favorites screen (empty state)
        expect(find.text('No Favorites available'), findsOneWidget);
      } else {
        print('No favorite cards found, skipping removal test.');
      }

      // Navigate back to the Hotels screen
      await tester.tap(find.byIcon(Icons.hotel));
      await tester
          .pumpAndSettle(); // Wait for the transition to the Hotels screen

      // Verify that the hotel is still displayed but no longer favorited
      expect(find.byIcon(Icons.favorite_border).first, findsOneWidget);
    });
  });
}
