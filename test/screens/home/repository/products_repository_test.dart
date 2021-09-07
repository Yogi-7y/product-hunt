import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/screens/home/datasources/local_data_source.dart';
import 'package:product_hunt/screens/home/datasources/remote_data_source.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';
import 'package:product_hunt/screens/home/repository/fetch_posts_repository.dart';
import 'package:product_hunt/service/network_connectivity.dart';

import 'products_repository_test.mocks.dart';

@GenerateMocks(
    [NetworkConnectivity, RemoteDataSourceContract, LocalDataSourceContract])
void main() {
  final _successTodaysPostModel =
      ApiResponse<List<PostModel>>.success(data: const <PostModel>[]);

  final _failTodaysPostModel = ApiResponse<List<PostModel>>.error('');

  late FetchPostsRepository _fetchPostsRepository;
  late MockRemoteDataSource _mockRemoteDatasource;
  late MockLocalDataSource _mockLocalDatasource;
  final MockNetworkConnectivity _mockNetworkConnectivity =
      MockNetworkConnectivity();

  setUp(() {
    _mockRemoteDatasource = MockRemoteDataSource();
    _mockLocalDatasource = MockLocalDataSource();

    _fetchPostsRepository = FetchPostsRepository(
      remoteDataSource: _mockRemoteDatasource,
      localDataSource: _mockLocalDatasource,
      connectivity: _mockNetworkConnectivity,
    );
  });

  group('when device is online', () {
    setUp(() => when(_mockNetworkConnectivity.isConnected)
        .thenAnswer((_) async => true));

    test('should return todays posts if the request is successful', () async {
      when(_mockRemoteDatasource.getTodaysPosts()).thenAnswer(
        (realInvocation) async =>
            ApiResponse.success(data: const <PostModel>[]),
      );

      final result = await _fetchPostsRepository.getTodaysPosts();

      expect(result, equals(_successTodaysPostModel));
    });

    test('should cache todays posts if the request is successful', () async {
      when(_mockRemoteDatasource.getTodaysPosts()).thenAnswer(
        (realInvocation) async =>
            ApiResponse.success(data: const <PostModel>[]),
      );

      final result = await _fetchPostsRepository.getTodaysPosts();

      verify(_mockLocalDatasource.cacheTodaysPosts(result.data));
    });

    test('should cache nothing if the request is fails', () async {
      when(_mockRemoteDatasource.getTodaysPosts()).thenAnswer(
        (realInvocation) async => ApiResponse.error(''),
      );

      final result = await _fetchPostsRepository.getTodaysPosts();

      verify(_mockRemoteDatasource.getTodaysPosts());
      verifyZeroInteractions(_mockLocalDatasource);
      expect(result, _failTodaysPostModel);
    });
  });

  group('when device is offline', () {
    setUp(() => when(_mockNetworkConnectivity.isConnected)
        .thenAnswer((_) async => false));

    test('should return cached posts if present', () async {
      when(_mockLocalDatasource.getTodaysPosts())
          .thenAnswer((realInvocation) async => _successTodaysPostModel);

      final result = await _fetchPostsRepository.getTodaysPosts();

      verifyZeroInteractions(_mockRemoteDatasource);
      verify(_mockLocalDatasource.getTodaysPosts());
      expect(result, _successTodaysPostModel);
    });

    test('should return error if posts not present', () async {
      when(_mockLocalDatasource.getTodaysPosts())
          .thenAnswer((realInvocation) async => _failTodaysPostModel);

      final result = await _fetchPostsRepository.getTodaysPosts();

      verifyZeroInteractions(_mockRemoteDatasource);
      verify(_mockLocalDatasource.getTodaysPosts());
      expect(result, _failTodaysPostModel);
    });
  });
}
