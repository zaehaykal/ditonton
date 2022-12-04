import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/folder_movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/test_helper.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late MovieDetailBlocHelper movieDetailBlocHelper;
  late RecommendationsMovieBlocHelper recommendationsMovieBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUp(() {
    movieDetailBlocHelper = MovieDetailBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());

    recommendationsMovieBlocHelper = RecommendationsMovieBlocHelper();
    registerFallbackValue(RecommendationsMovieEventHelper());
    registerFallbackValue(RecommendationsMovieStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (_) => movieDetailBlocHelper),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => watchlistMovieBlocHelper,
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (_) => recommendationsMovieBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}
