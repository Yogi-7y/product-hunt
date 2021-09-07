import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';

abstract class RemoteDataSource {
  Future<ApiResponse<List<PostModel>>> getTodaysPosts();
}
