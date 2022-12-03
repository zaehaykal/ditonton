import 'package:bloc/bloc.dart';
import 'package:ditonton/folder_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_bloc.dart';

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
