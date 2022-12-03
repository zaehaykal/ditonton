import 'package:ditonton/common/exception.dart';
import 'package:ditonton/folder_tv/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper_tv.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late TvLocalDataSourceImpl dataSourceTv;
  late MockTvDatabaseHelper mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelperTv = MockTvDatabaseHelper();
    dataSourceTv =
        TvLocalDataSourceImpl(tvDatabaseHelper: mockDatabaseHelperTv);
  });

  group('save watchlist TV', () {
    test('should return success message when insert to tv database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceTv.insertWatchList(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to TV database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTv.insertWatchList(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist TV', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceTv.removeWatchList(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTv.removeWatchList(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Detail By Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSourceTv.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSourceTv.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist TV', () {
    test('should return list of Tv Table from database', () async {
      // arrange
      when(mockDatabaseHelperTv.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSourceTv.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
