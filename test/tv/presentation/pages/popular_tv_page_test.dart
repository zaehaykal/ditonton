import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_popular_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helper.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late PopularTvBlocHelper popularTvBlocHelper;

  setUp(() {
    popularTvBlocHelper = PopularTvBlocHelper();
    registerFallbackValue(PopularTvStateHelper());
    registerFallbackValue(PopularTvEventHelper());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => popularTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvPopularPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvLoading());
    when(() => popularTvBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TvPopularPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state)
        .thenReturn(const TvHasError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvPopularPage()));

    expect(textFinder, findsOneWidget);
  });
}
