import 'package:ditonton/folder_movie/data/datasources/db/database_helper.dart';
import 'package:ditonton/folder_tv/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/folder_movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/folder_movie//data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/folder_tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/folder_movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/folder_tv/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

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
Future<void> main() async {}
