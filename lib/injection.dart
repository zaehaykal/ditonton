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
import 'package:ditonton/folder_movie/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/watchlist_movie_notifier.dart';
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
import 'package:ditonton/folder_tv/presentation/provider/tv_now_playing_notifie.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_popular_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_top_rated_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_watchlist_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

void init() {
  // provider movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  //provider tv
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchlistTvStatus: locator(),
      tvSaveWatchlist: locator(),
      tvRemoveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchListNotifier(
      getWatchlistTv: locator(),
    ),
  );

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
  locator.registerLazySingleton(() => TvNowPlayingNotifier(locator()));

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
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => IOClient());
}
