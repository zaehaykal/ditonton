import 'package:ditonton/common/sslpinning.dart';
import 'package:ditonton/folder_movie/data/datasources/db/database_helper.dart';
import 'package:ditonton/folder_movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/folder_movie/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/folder_movie/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/folder_movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/folder_movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/folder_movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/folder_movie/domain/usecases/search_movies.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_np_bloc.dart';
import 'package:ditonton/folder_movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:ditonton/folder_tv/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/folder_tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/folder_tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/folder_tv/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/folder_tv/domain/repositories/tv_repository.dart';
import 'package:ditonton/folder_tv/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/folder_tv/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/folder_tv/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/folder_tv/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/folder_tv/domain/usecases/get_tv_recommendation.dart';
import 'package:ditonton/folder_tv/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/folder_tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/folder_tv/domain/usecases/search_tv.dart';
import 'package:ditonton/folder_tv/domain/usecases/tv_remove_watchlist.dart';
import 'package:ditonton/folder_tv/domain/usecases/tv_save_watchlist.dart';
import 'package:ditonton/folder_tv/presentation/bloc/search/tv_search_bloc.dart';
import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

void init() {
  //bloc movie

  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMovieBloc(
      locator(),
    ),
  );
  // locator.registerFactory(
  //   () => NowPlayingMoviesBloc(
  //     locator(),
  //   ),
  // );
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );

  // bloc Tv
  locator.registerFactory(
    () => NowPlayingTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );

  // provider movie

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(locator()));
  locator.registerLazySingleton(() => TvSaveWatchlist(locator()));
  locator.registerLazySingleton(() => TvRemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDatabaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => IOClient());
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
