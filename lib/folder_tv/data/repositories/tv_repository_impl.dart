import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/folder_tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/folder_tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/folder_tv/data/models/tv_table.dart';
import 'package:ditonton/folder_tv/domain/entities/tv.dart';
import 'package:ditonton/folder_tv/domain/entities/tv_detail.dart';
import 'package:ditonton/folder_tv/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvLocalDataSource localDataSource;
  final TvRemoteDataSource remoteDataSource;

  TvRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTv() async {
    try {
      final result = await remoteDataSource.getNowPlayingTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('Certificate Verify failed:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('Certificate Verify failed:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('Certificate Verify failed:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('Certificate Verify failed:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendation(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendation(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('Certificate Verify failed:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('Certificate Verify failed:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, String>> tvSaveWatchList(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchList(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> tvRemoveWatchlist(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchList(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isTvAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    try {
      final reslut = await localDataSource.getWatchlistTv();
      return Right(reslut.map((data) => data.toEntity()).toList());
    } on TlsException catch (e) {
      return Left(SSLFailure('Certificate Verify failed:\n${e.message}'));
    }
  }
}
