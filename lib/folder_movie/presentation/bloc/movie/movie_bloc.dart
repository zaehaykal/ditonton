import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/folder_movie/domain/entities/movie.dart';
import 'package:ditonton/folder_movie/domain/entities/movie_detail.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/folder_movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/folder_movie/domain/usecases/save_watchlist.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class PopularMoviesBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MoviesEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesHasError(failure.message));
        },
        (moviesData) {
          emit(MoviesHasData(moviesData));
        },
      );
    });
  }
}

class TopRatedMoviesBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MoviesEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesHasError(failure.message));
        },
        (moviesData) {
          emit(MoviesHasData(moviesData));
        },
      );
    });
  }
}

class MovieDetailBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MoviesEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MoviesLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (failure) {
          emit(MoviesHasError(failure.message));
        },
        (movies) {
          emit(MovieDetailHasData(movies));
        },
      );
    });
  }
}

class RecommendationMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(MoviesEmpty()) {
    on<FetchMovieRecommendations>((event, emit) async {
      final int id = event.id;

      emit(MoviesLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(MoviesHasError(failure.message));
        },
        (moviesData) {
          emit(MoviesHasData(moviesData));
        },
      );
    });
  }
}

class WatchlistMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistMovieBloc(this.getWatchlistMovies, this.getWatchListStatus,
      this.saveWatchlist, this.removeWatchlist)
      : super(MoviesEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesHasError(failure.message));
        },
        (moviesData) {
          emit(WatchlistMovieHasData(moviesData));
        },
      );
    });

    on<AddWatchlistMovies>((event, emit) async {
      final movie = event.movie;

      emit(MoviesLoading());
      final result = await saveWatchlist.execute(movie);

      result.fold(
        (failure) {
          emit(MoviesHasError(failure.message));
        },
        (successMessage) {
          emit(
            WatchlistMoviesMessage(successMessage),
          );
        },
      );
    });

    on<RemoveWatchlistMovies>((event, emit) async {
      final movie = event.movie;

      emit(MoviesLoading());
      final result = await removeWatchlist.execute(movie);

      result.fold(
        (failure) {
          emit(MoviesHasError(failure.message));
        },
        (successMessage) {
          emit(WatchlistMoviesMessage(successMessage));
        },
      );
    });

    on<LoadWatchlistMovieStatus>((event, emit) async {
      final id = event.id;

      emit(MoviesLoading());
      final result = await getWatchListStatus.execute(id);

      emit(LoadWatchlistData(result));
    });
  }
}
