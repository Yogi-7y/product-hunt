import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/core/api/dio_client.dart';
import 'package:product_hunt/core/api/endpoints.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';

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
