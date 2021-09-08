import '../../../core/api/api_response.dart';
import '../../../core/api/dio_client.dart';
import '../../../core/resources/strings.dart';
import '../models/post_model.dart';
import '../../../service/local_state.dart';

abstract class LocalDataSourceContract {
  Future<ApiResponse<List<PostModel>>> getTodaysPosts();

  Future<void> cacheTodaysPosts(List<PostModel> posts);
}

class LocalDataSource implements LocalDataSourceContract {
  final _className = 'LocalDataSource';

  @override
  Future<void> cacheTodaysPosts(List<PostModel> posts) async =>
      LocalState.instance.storeObject(kLocalPostsKey,
          posts.map<Map<String, dynamic>>((e) => e.toMap()).toList());

  @override
  Future<ApiResponse<List<PostModel>>> getTodaysPosts() async {
    try {
      final result = List<Map<String, dynamic>>.from(
              LocalState.instance.getObject(kLocalPostsKey) as Iterable)
          .map((e) => PostModel.fromMap(e))
          .toList();

      return ApiResponse.success(
          data: result, message: kPoorConnectivityMessage);
    } catch (e) {
      return DioClient.instance.handleExceptions(e, _className);
    }
  }
}
