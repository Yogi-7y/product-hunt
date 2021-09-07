// class MockRemoteDatasource extends Mock implements RemoteDataSource {}

// class MockLocalDatasource extends Mock implements LocalDataSource {}

// class MockNetworkConnectivity extends Mock implements NetworkConnectivity {}

import 'package:mockito/annotations.dart';
import 'package:product_hunt/service/network_connectivity.dart';

@GenerateMocks([NetworkConnectivity])
void main() {
  // late PostsRepository _postsRepository;
  // late MockRemoteDatasource _mockRemoteDatasource;
  // late MockLocalDatasource _mockLocalDatasource;
  // final MockNetworkConnectivity _mockNetworkConnectivity =
  //     MockNetworkConnectivity();

  // setUp(() {
  //   _mockRemoteDatasource = MockRemoteDatasource();
  //   _mockLocalDatasource = MockLocalDatasource();

  //   _postsRepository = PostsRepository(
  //     remoteDataSource: _mockRemoteDatasource,
  //     localDataSource: _mockLocalDatasource,
  //     connectivity: _mockNetworkConnectivity,
  //   );
  // });

  // test('check if device is online', () {
  //   when(_mockNetworkConnectivity.isConnected).thenAnswer((_) async => true);

  //   _postsRepository.getTodaysPosts();

  //   verify(_mockNetworkConnectivity.isConnected);
  // });
}
