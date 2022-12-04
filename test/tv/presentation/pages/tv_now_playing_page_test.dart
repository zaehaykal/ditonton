import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_now_playing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/test_helper.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late NowPlayingTvBlocHelper nowPlayingMoviesBlocHelper;

  setUp(() {
    nowPlayingMoviesBlocHelper = NowPlayingTvBlocHelper();
    registerFallbackValue(NowPlayingTvBlocHelper());
    registerFallbackValue(NowPlayingTvStateHelper());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvBloc>(
      create: (_) => nowPlayingMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => nowPlayingMoviesBlocHelper.state).thenReturn(TvLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvNowPlayingPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => nowPlayingMoviesBlocHelper.state)
        .thenAnswer((invocation) => TvLoading());
    when(() => nowPlayingMoviesBlocHelper.state)
        .thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TvNowPlayingPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => nowPlayingMoviesBlocHelper.state)
        .thenReturn(const TvHasError('Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvNowPlayingPage()));

    expect(textFinder, findsOneWidget);
  });
}
