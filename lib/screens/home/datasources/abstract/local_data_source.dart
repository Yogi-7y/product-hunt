import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';

abstract class LocalDataSource {
  Future<CustomResponse<List<PostModel>>> getTodaysPosts();

  Future<void> cacheTodaysPosts(List<PostModel> posts) async {}
}
