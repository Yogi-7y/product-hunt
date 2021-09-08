import '../../../core/api/api_response.dart';
import '../../../core/resources/strings.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/post_model.dart';
import '../../../service/network_connectivity.dart';

abstract class PostsRepositoryContract {
  Future<ApiResponse<List<PostModel>>> getTodaysPosts();
}

class FetchPostsRepository implements PostsRepositoryContract {
  final RemoteDataSourceContract remoteDataSource;
  final LocalDataSourceContract localDataSource;
  final NetworkConnectivity connectivity;

  FetchPostsRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  @override
  Future<ApiResponse<List<PostModel>>> getTodaysPosts() async {
    if (!await connectivity.isConnected)
      return localDataSource.getTodaysPosts();

    final response = await remoteDataSource.getTodaysPosts();

    if (response.status == ApiResponseStatus.success)
      localDataSource.cacheTodaysPosts(response.data!);

    return response;
  }

  Future<ApiResponse<List<PostModel>>> getDaysAgo(int daysAgo) async {
    if (!await connectivity.isConnected)
      return ApiResponse.error(kPoorConnectivityMessage);

    final response = await remoteDataSource.getDaysAgoPosts(daysAgo);

    if (response.status == ApiResponseStatus.success)
      localDataSource.cacheTodaysPosts(response.data!);

    return response;
  }
}
