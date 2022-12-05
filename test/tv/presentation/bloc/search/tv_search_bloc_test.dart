import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/folder_tv/domain/entities/tv.dart';
import 'package:ditonton/folder_tv/presentation/bloc/search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([TvSearchBloc])
void main() {
  late TvSearchBloc searchTvShowBloc;
  late MockSearchTv mockSearchTvShows;

  setUp(() {
    mockSearchTvShows = MockSearchTv();
    searchTvShowBloc = TvSearchBloc(mockSearchTvShows);
  });

  final tTvModel = Tv(
    backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
    firstAirDate: '2022-08-21',
    genreIds: const [10765, 18, 10759],
    id: 94997,
    name: 'House of the Dragon',
    originCountry: const ["US"],
    originalLanguage: 'en',
    originalName: 'House of the Dragon',
    overview:
        'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
    popularity: 7222.052,
    posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
    voteAverage: 8.6,
    voteCount: 1564,
  );
  final tTvList = <Tv>[tTvModel];
  const tQuery = 'dragon';

  group('Search Tv', () {
    test('Initial state should be empty', () {
      expect(searchTvShowBloc.state, TvSearchEmpty());
    });

    blocTest<TvSearchBloc, TvSearchState>(
      'Should emit [SearchLoading, TvSearchLoading] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSearchLoading(),
        TvSearchHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQuery));
      },
    );

    blocTest<TvSearchBloc, TvSearchState>(
      'Should emit [TvSearchLoading, TvSearchHasData[], TvSearchEmpty] when data is empty',
      build: () {
        when(mockSearchTvShows.execute(tQuery))
            .thenAnswer((_) async => const Right(<Tv>[]));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSearchLoading(),
        TvSearchHasData(<Tv>[]),
        TvSearchEmpty(),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQuery));
      },
    );

    blocTest<TvSearchBloc, TvSearchState>(
      'Should emit [TvSearchLoading, TvSearchError] when data is unsuccessful',
      build: () {
        when(mockSearchTvShows.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSearchLoading(),
        const TvSearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQuery));
      },
    );
  });
}
