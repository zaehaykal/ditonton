import 'package:dartz/dartz.dart';
import 'package:ditonton/folder_movie/domain/entities/movie.dart';
import 'package:ditonton/folder_movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
