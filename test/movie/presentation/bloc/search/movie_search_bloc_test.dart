import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/folder_movie/domain/entities/movie.dart';
import 'package:ditonton/folder_movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([MovieSearchBloc])
void main() {
  late MovieSearchBloc searchMoviesShowBloc;
  late MockSearchMovie mockSearchMoviesShows;

  setUp(() {
    mockSearchMoviesShows = MockSearchMovie();
    searchMoviesShowBloc = MovieSearchBloc(mockSearchMoviesShows);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'Spider';

  group('Search Movies', () {
    test('Initial state should be empty', () {
      expect(searchMoviesShowBloc.state, SearchEmpty());
    });

    blocTest<MovieSearchBloc, SearchState>(
      'Should emit [SearchLoading, SearchLoading] when data is gotten successfully',
      build: () {
        when(mockSearchMoviesShows.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchMoviesShowBloc;
      },
      act: (bloc) => bloc.add(const OnMovieQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMoviesShows.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, SearchState>(
      'Should emit [SearchLoading, SearchMovieHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchMoviesShows.execute(tQuery))
            .thenAnswer((_) async => const Right(<Movie>[]));
        return searchMoviesShowBloc;
      },
      act: (bloc) => bloc.add(const OnMovieQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchMovieHasData(<Movie>[]),
        SearchEmpty(),
      ],
      verify: (bloc) {
        verify(mockSearchMoviesShows.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, SearchState>(
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchMoviesShows.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchMoviesShowBloc;
      },
      act: (bloc) => bloc.add(const OnMovieQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMoviesShows.execute(tQuery));
      },
    );
  });
}
