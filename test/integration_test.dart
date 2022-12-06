import 'package:ditonton/folder_movie/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/folder_tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:integration_test/integration_test.dart';

import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test: ', () {
    testWidgets('Tap on the watchlist action button Movie or TvShow then verify watchlist',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Click first item movie
      final Finder movieItem = find.byKey(Key('movieItem')).first;
      await tester.tap(movieItem);
      await tester.pumpAndSettle();

      // Click the watchlistButtonMovie and check "Icon Check"
      final Finder watchListButtonMovie = find.byKey(Key('watchlistButtonMovie'));
      await tester.tap(watchListButtonMovie);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Back to home screen
      final Finder iconBack = find.byIcon(Icons.arrow_back).first;
      await tester.tap(iconBack);
      await tester.pumpAndSettle();

      //open drawer
      final Finder drawerIcon = find.byIcon(Icons.menu).first;
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();

      //click on Tv Show menu
      final Finder tvShowIcon = find.byIcon(Icons.tv).first;
      await tester.tap(tvShowIcon);
      await tester.pumpAndSettle();

      // Click the first item Tv Show 
      final Finder tvItem = find.byKey(Key('tvItem')).first;
      await tester.tap(tvItem);
      await tester.pumpAndSettle();

      // Click the watchlistButtonTvShow and check "Icon Check"
      final Finder watchListButtonTvShow = find.byKey(Key('watchlistButtonTvShow'));
      await tester.tap(watchListButtonTvShow);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsOneWidget);

      //Back to Home
      await tester.tap(iconBack);
      await tester.pumpAndSettle();

      //open drawer and click watchlist menu
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();
      final Finder watchlistMenuIcon = find.byIcon(Icons.save_alt).first;
      await tester.tap(watchlistMenuIcon);
      await tester.pumpAndSettle();

      //find moviecard
      expect(find.byType(MovieCard), findsOneWidget);

      //click tab Tv Shows and check TvCard
      final Finder tvShowTab = find.text('Tv Shows');
      await tester.tap(tvShowTab);
      await tester.pumpAndSettle();
      expect(find.byType(TvCard), findsOneWidget);
    });
  });
}