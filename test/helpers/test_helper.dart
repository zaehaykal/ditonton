import 'package:ditonton/folder_movie/data/datasources/db/database_helper.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/folder_tv/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/folder_movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/folder_movie//data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/folder_tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/folder_movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/folder_tv/domain/repositories/tv_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TvRepository,
  TvLocalDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

class NowPlayingTvEventHelper extends Fake implements TvEvent {}

class NowPlayingTvStateHelper extends Fake implements TvState {}

class NowPlayingTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements NowPlayingTvBloc {}

class PopularTvEventHelper extends Fake implements TvEvent {}

class PopularTvStateHelper extends Fake implements TvState {}

class PopularTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements PopularTvBloc {}

class TopRatedTvEventHelper extends Fake implements TvEvent {}

class TopRatedTvStateHelper extends Fake implements TvState {}

class TopRatedTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements TopRatedTvBloc {}

class TvDetailEventHelper extends Fake implements TvEvent {}

class TvDetailStateHelper extends Fake implements TvState {}

class TvDetailBlocHelper extends MockBloc<TvEvent, TvState>
    implements TvDetailBloc {}

class RecommendationsTvEventHelper extends Fake implements TvEvent {}

class RecommendationsTvStateHelper extends Fake implements TvState {}

class RecommendationsTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements RecommendationTvBloc {}

class WatchlistTvEventHelper extends Fake implements TvEvent {}

class WatchlistTvStateHelper extends Fake implements TvState {}

class WatchlistTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements WatchlistTvBloc {}

class NowPlayingMoviesEventHelper extends Fake implements MovieBlocEvent {}

class NowPlayingMoviesStateHelper extends Fake implements MovieBlocState {}

// class NowPlayingMoviesBlocHelper
//     extends MockBloc<MovieBlocEvent, MovieBlocState>
//     implements NowPlayingMoviesBloc {}

class PopularMoviesEventHelper extends Fake implements MovieBlocEvent {}

class PopularMoviesStateHelper extends Fake implements MovieBlocState {}

class PopularMoviesBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements PopularMoviesBloc {}

class TopRatedMoviesEventHelper extends Fake implements MovieBlocEvent {}

class TopRatedMoviesStateHelper extends Fake implements MovieBlocState {}

class TopRatedMoviesBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements TopRatedMoviesBloc {}

class MovieDetailEventHelper extends Fake implements MovieBlocEvent {}

class MovieDetailStateHelper extends Fake implements MovieBlocState {}

class MovieDetailBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements MovieDetailBloc {}

class RecommendationsMovieEventHelper extends Fake implements MovieBlocEvent {}

class RecommendationsMovieStateHelper extends Fake implements MovieBlocState {}

class RecommendationsMovieBlocHelper
    extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements RecommendationMovieBloc {}

class WatchlistMovieEventHelper extends Fake implements MovieBlocEvent {}

class WatchlistMovieStateHelper extends Fake implements MovieBlocState {}

class WatchlistMovieBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements WatchlistMovieBloc {}
