import '../../../core/api/api_response.dart';
import '../../../core/api/dio_client.dart';
import '../../../core/api/endpoints.dart';
import '../models/post_model.dart';

abstract class RemoteDataSourceContract {
  Future<ApiResponse<List<PostModel>>> getTodaysPosts();
  Future<ApiResponse<List<PostModel>>> getDaysAgoPosts(int daysAgo);
}

class RemoteDataSource implements RemoteDataSourceContract {
  final className = 'RemoteProductsRepository';

  @override
  Future<ApiResponse<List<PostModel>>> getTodaysPosts() async {
    try {
      final response = await DioClient.instance.dio
          .get<Map<String, dynamic>>(kTodaysPostsEndpoint);

      final posts =
          List<Map<String, dynamic>>.from(response.data!['posts'] as Iterable)
              .map((tag) => PostModel.fromMap(tag))
              .toList();

      return ApiResponse.success(data: posts);
    } catch (e) {
      return DioClient.instance.handleExceptions(e, className);
    }
  }

  @override
  Future<ApiResponse<List<PostModel>>> getDaysAgoPosts(int daysAgo) async {
    try {
      final response = await DioClient.instance.dio.get<Map<String, dynamic>>(
        kTodaysPostsEndpoint,
        queryParameters: <String, dynamic>{'days_ago': daysAgo},
      );

      final posts =
          List<Map<String, dynamic>>.from(response.data!['posts'] as Iterable)
              .map((tag) => PostModel.fromMap(tag))
              .toList();

      return ApiResponse.success(data: posts);
    } catch (e) {
      return DioClient.instance.handleExceptions(e, className);
    }
  }
}
