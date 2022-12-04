import 'package:bloc/bloc.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_bloc.dart';

class NowPlayingMoviesBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getNowPlayingMovies.execute();

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
