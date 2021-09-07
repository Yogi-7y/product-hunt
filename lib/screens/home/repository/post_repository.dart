import 'package:product_hunt/core/api/api_response.dart';
import 'package:product_hunt/core/api/dio_client.dart';
import 'package:product_hunt/core/api/endpoints.dart';
import 'package:product_hunt/screens/home/models/comment_model.dart';

class PostCommentRepository {
  final _className = 'PostCommentRepository';

  final _limit = 5;

  Future<ApiResponse<List<CommentModel>>> getComments(
      int postId, int page) async {
    try {
      final _queryParams = <String, dynamic>{
        'page': page,
        'per_page': _limit,
        'search[post_id]': postId,
      };

      final response = await DioClient.instance.dio.get<Map<String, dynamic>>(
        kCommentsEndpoint,
        queryParameters: _queryParams,
      );

      final comments = List<Map<String, dynamic>>.from(
              response.data!['comments'] as Iterable)
          .map((tag) => CommentModel.fromMap(tag))
          .toList();

      return ApiResponse.success(data: comments);
    } catch (e) {
      return DioClient.instance.handleExceptions(e, _className);
    }
  }
}
