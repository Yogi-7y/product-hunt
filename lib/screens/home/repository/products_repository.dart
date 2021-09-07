import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/core/api/dio_client.dart';
import 'package:product_hunt/core/api/endpoints.dart';
import 'package:product_hunt/screens/home/datasources/abstract/local_data_source.dart';
import 'package:product_hunt/screens/home/datasources/abstract/remote_data_source.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';
import 'package:product_hunt/service/network_connectivity.dart';

abstract class PostsRepositoryContract {
  Future<ApiResponse<List<PostModel>>> getTodaysPosts();
}

class PostsRepository implements PostsRepositoryContract {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkConnectivity connectivity;

  PostsRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  @override
  Future<ApiResponse<List<PostModel>>> getTodaysPosts() async {
    if (!await connectivity.isConnected)
      return localDataSource.getTodaysPosts();

    final response = await remoteDataSource.getTodaysPosts();

    if (response.status == CustomResponseStatus.success)
      localDataSource.cacheTodaysPosts(response.data!);

    return response;
  }
}

class RemoteProductsRepository {
  final className = 'RemoteProductsRepository';

  Future<ApiResponse<List<PostModel>>> getTodaysPosts() async {
    try {
      final response = await DioClient.instance.dio
          .get<Map<String, dynamic>>(kTodaysPostsEndpoint);

      final posts =
          List<Map<String, dynamic>>.from(response.data![''] as Iterable)
              .map((tag) => PostModel.fromMap(tag))
              .toList();

      return ApiResponse.success(data: posts);
    } catch (e) {
      return DioClient.instance.handleExceptions(e, className);
    }
  }
}
