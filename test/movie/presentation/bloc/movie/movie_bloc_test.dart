import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/folder_movie/domain/entities/genre.dart';
import 'package:ditonton/folder_movie/domain/entities/movie.dart';
import 'package:ditonton/folder_movie/domain/entities/movie_detail.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_np_bloc.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/folder_movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/folder_movie/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
])
void main() {
  late MockGetNowPlayingMovie mockGetNowPlayingMovie;
  late MockGetPopularMovie mockGetPopularMovie;
  late MockGetTopRatedMovie mockGetTopRatedMovies;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchlistMovie mockGetWatchlistMovie;
  late MockGetMovieWatchlistStatus mockGetMovieWatchlistStatus;
  late MockMovieRemoveWatchlist mockMovieRemoveWatchlist;
  late MockMovieSaveWatchlist mockMovieSaveWatchlist;

  late NowPlayingMoviesBloc nowPlayingMovieBloc;
  late PopularMoviesBloc popularMovieBloc;
  late TopRatedMoviesBloc topRatedMovieBloc;
  late MovieDetailBloc detailMovieBloc;
  late RecommendationMovieBloc recommendationMovieBloc;
  late WatchlistMovieBloc watchListMovieBloc;

  setUp(() {
    mockGetNowPlayingMovie = MockGetNowPlayingMovie();
    mockGetPopularMovie = MockGetPopularMovie();
    mockGetTopRatedMovies = MockGetTopRatedMovie();
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistMovie = MockGetWatchlistMovie();
    mockGetMovieWatchlistStatus = MockGetMovieWatchlistStatus();
    mockMovieRemoveWatchlist = MockMovieRemoveWatchlist();
    mockMovieSaveWatchlist = MockMovieSaveWatchlist();

    nowPlayingMovieBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovie);
    popularMovieBloc = PopularMoviesBloc(mockGetPopularMovie);
    topRatedMovieBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
    detailMovieBloc = MovieDetailBloc(mockGetMovieDetail);
    watchListMovieBloc = WatchlistMovieBloc(
        mockGetWatchlistMovie,
        mockGetMovieWatchlistStatus,
        mockMovieSaveWatchlist,
        mockMovieRemoveWatchlist);
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

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    genres: [Genre(id: 1, name: 'name')],
  );
  const tId = 1;

  group('Get now playing Movies', () {
    test('initial state must be empty', () {
      expect(nowPlayingMovieBloc.state, MoviesEmpty());
    });

    blocTest<NowPlayingMoviesBloc, MovieBlocState>(
      'should emit[loading, MoviesHasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingMovie.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovie.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, MovieBlocState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovie.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMovieBloc;
      },
      act: (NowPlayingMoviesBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovie.execute());
      },
    );
  });

  group('Get Popular Movies', () {
    test('initial state must be empty', () {
      expect(popularMovieBloc.state, MoviesEmpty());
    });

    blocTest<PopularMoviesBloc, MovieBlocState>(
      'should emit[loading, MoviesHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularMovie.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMovieBloc;
      },
      act: (PopularMoviesBloc bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovie.execute());
      },
    );

    blocTest<PopularMoviesBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetPopularMovie.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularMovieBloc;
      },
      act: (PopularMoviesBloc bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovie.execute());
      },
    );
  });

  group('Get Top Rated Movies', () {
    test('initial state must be empty', () {
      expect(topRatedMovieBloc.state, MoviesEmpty());
    });

    blocTest<TopRatedMoviesBloc, MovieBlocState>(
      'should emit[loading, MoviesHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMovieBloc;
      },
      act: (TopRatedMoviesBloc bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedMovieBloc;
      },
      act: (TopRatedMoviesBloc bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('Get Recommended Movies', () {
    test('initial state must be empty', () {
      expect(recommendationMovieBloc.state, MoviesEmpty());
    });

    blocTest<RecommendationMovieBloc, MovieBlocState>(
      'should emit[loading, MoviesHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationMovieBloc;
      },
      act: (RecommendationMovieBloc bloc) =>
          bloc.add(const FetchMovieRecommendations(tId)),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<RecommendationMovieBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return recommendationMovieBloc;
      },
      act: (RecommendationMovieBloc bloc) =>
          bloc.add(const FetchMovieRecommendations(tId)),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Get Details Movies', () {
    test('initial state must be empty', () {
      expect(detailMovieBloc.state, MoviesEmpty());
    });

    blocTest<MovieDetailBloc, MovieBlocState>(
      'should emit[loading, MoviesHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        return detailMovieBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MoviesLoading(),
        MovieDetailHasData(tMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Get watchlist Movies', () {
    test('initial state must be empty', () {
      expect(watchListMovieBloc.state, MoviesEmpty());
    });

    test('initial state should be empty', () {
      expect(watchListMovieBloc.state, MoviesEmpty());
    });

    group('Fetch', () {
      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovie.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          WatchlistMovieHasData(tMovieList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovie.execute());
        },
      );

      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockGetWatchlistMovie.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const MoviesHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovie.execute());
        },
      );
    });

    group('load watchlist', () {
      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) =>
            bloc.add(const LoadWatchlistMovieStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const LoadWatchlistData(true),
        ],
        verify: (bloc) {
          verify(mockGetMovieWatchlistStatus.execute(tId));
        },
      );

      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockGetMovieWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) =>
            bloc.add(const LoadWatchlistMovieStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const LoadWatchlistData(false),
        ],
        verify: (bloc) {
          verify(mockGetMovieWatchlistStatus.execute(tId));
        },
      );
    });

    group('add watchlist', () {
      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockMovieSaveWatchlist.execute(tMovieDetail)).thenAnswer(
              (_) async =>
                  const Right(WatchlistMovieBloc.watchlistAddSuccessMessage));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) =>
            bloc.add(AddWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const WatchlistMoviesMessage(
              WatchlistMovieBloc.watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockMovieSaveWatchlist.execute(tMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockMovieSaveWatchlist.execute(tMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) =>
            bloc.add(AddWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const MoviesHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockMovieSaveWatchlist.execute(tMovieDetail));
        },
      );
    });

    group('remove watchlist', () {
      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockMovieRemoveWatchlist.execute(tMovieDetail)).thenAnswer(
              (_) async =>
                  const Right(WatchlistMovieBloc.watchlistAddSuccessMessage));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) =>
            bloc.add(RemoveWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const WatchlistMoviesMessage(
              WatchlistMovieBloc.watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockMovieRemoveWatchlist.execute(tMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockMovieRemoveWatchlist.execute(tMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) =>
            bloc.add(RemoveWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const MoviesHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockMovieRemoveWatchlist.execute(tMovieDetail));
        },
      );
    });
  });
}
