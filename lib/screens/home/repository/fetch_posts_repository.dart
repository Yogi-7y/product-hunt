import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/core/resources/strings.dart';
import 'package:product_hunt/screens/home/datasources/local_data_source.dart';
import 'package:product_hunt/screens/home/datasources/remote_data_source.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';
import 'package:product_hunt/service/network_connectivity.dart';

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
