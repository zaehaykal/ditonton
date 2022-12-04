import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/test_helper.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late TvDetailBlocHelper tvDetailBlocHelper;
  late RecommendationsTvBlocHelper recommendationsTvBlocHelper;
  late WatchlistTvBlocHelper watchlistTvBlocHelper;

  setUp(() {
    tvDetailBlocHelper = TvDetailBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    watchlistTvBlocHelper = WatchlistTvBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());

    recommendationsTvBlocHelper = RecommendationsTvBlocHelper();
    registerFallbackValue(RecommendationsTvEventHelper());
    registerFallbackValue(RecommendationsTvStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(create: (_) => tvDetailBlocHelper),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => watchlistTvBlocHelper,
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (_) => recommendationsTvBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when Tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => tvDetailBlocHelper.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => recommendationsTvBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(LoadTvWatchlistData(false));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => tvDetailBlocHelper.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => recommendationsTvBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(LoadTvWatchlistData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => tvDetailBlocHelper.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => recommendationsTvBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(LoadTvWatchlistData(false));

    final watchlistButton = find.byType(ElevatedButton);
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}
