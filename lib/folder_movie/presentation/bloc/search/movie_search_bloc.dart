import 'package:ditonton/folder_movie/domain/usecases/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/folder_movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, SearchState> {
  final SearchMovies _moviesSearch;

  MovieSearchBloc(this._moviesSearch) : super(SearchEmpty()) {
    on<OnMovieQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _moviesSearch.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchMovieHasData(data));
          if (data.isEmpty) {
            emit(SearchEmpty());
          }
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
