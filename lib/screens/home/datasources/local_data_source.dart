import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/core/resources/strings.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';
import 'package:product_hunt/service/local_state.dart';

abstract class LocalDataSourceContract {
  Future<ApiResponse<List<PostModel>>> getTodaysPosts();

  Future<void> cacheTodaysPosts(List<PostModel> posts);
}

class LocalDataSource implements LocalDataSourceContract {
  @override
  Future<void> cacheTodaysPosts(List<PostModel> posts) async =>
      LocalState.instance.storeObject(kLocalPostsKey,
          posts.map<Map<String, dynamic>>((e) => e.toMap()).toList());

  @override
  Future<ApiResponse<List<PostModel>>> getTodaysPosts() async {
    final result = List<Map<String, dynamic>>.from(
            LocalState.instance.getObject(kLocalPostsKey) as Iterable)
        .map((e) => PostModel.fromMap(e))
        .toList();

    return ApiResponse.success(data: result, message: kPoorConnectivityMessage);
  }
}
