import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_response.dart';
import '../../../core/utils/logger.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../repository/post_repository.dart';

final _log = getLogger('PostCommentsProvider');

final postCommentStateNotifierProvider = StateNotifierProvider.family<
    PostCommentsProvider,
    List<CommentModel>,
    PostModel>((ref, postModel) => PostCommentsProvider(postModel));

class PostCommentsProvider extends StateNotifier<List<CommentModel>> {
  final PostModel postModel;

  PostCommentsProvider(this.postModel) : super(const <CommentModel>[]) {
    fetchComments();
    scrollListener();
  }

  final _commentRepository = PostCommentRepository();

  final scrollcontroller =
      ScrollController(debugLabel: 'Comments ScrollController');

  void scrollListener() {
    scrollcontroller.addListener(() {
      if (!scrollcontroller.position.atEdge) return;

      if (scrollcontroller.position.pixels != 0) {
        _log.i('at bottom');
        fetchComments();
      }
    });
  }

  final isLoadingNotifier = ValueNotifier<bool>(false);
  late int _page = 1;
  void _incrementPage() => _page++;

  Future<void> fetchComments() async {
    isLoadingNotifier.value = true;

    final response = await _commentRepository.getComments(postModel.id, _page);

    if (response.status == ApiResponseStatus.error) {
      isLoadingNotifier.value = false;
      return;
    }

    state = [...state, ...response.data ?? []];
    isLoadingNotifier.value = false;
    _incrementPage();
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }
}
