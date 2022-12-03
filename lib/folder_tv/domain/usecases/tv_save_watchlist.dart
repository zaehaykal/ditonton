import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/folder_tv/domain/entities/tv_detail.dart';
import 'package:ditonton/folder_tv/domain/repositories/tv_repository.dart';

class TvSaveWatchlist {
  final TvRepository repository;

  TvSaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.tvSaveWatchList(tv);
  }
}
