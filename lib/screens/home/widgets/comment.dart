import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/configs/size_config.dart';
import '../../../core/resources/colors.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../providers/post_comments_provider.dart';
import '../../../shared/empty_widget.dart';

class CommentsProgressIndicator extends ConsumerWidget {
  const CommentsProgressIndicator({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder<bool>(
      valueListenable: ref
          .watch(postCommentStateNotifierProvider(postModel).notifier)
          .isLoadingNotifier,
      builder: (context, isLoading, child) =>
          isLoading ? child! : const EmptyWidget(),
      child: Positioned(
        bottom: 10.0,
        left: SizeConfig.instance.blockWidth * 45,
        child: const CircularProgressIndicator(
          color: kBlackColor,
        ),
      ),
    );
  }
}

class Comments extends StatelessWidget {
  final List<CommentModel> comments;

  const Comments({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => CommentTile(
          commentModel: comments[index],
        ),
        childCount: comments.length,
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final CommentModel commentModel;

  const CommentTile({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (commentModel.user.imageUrl != null)
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(commentModel.user.imageUrl!),
                ),
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: kSilverChalice.withOpacity(.15),
                borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10.0),
                    ) +
                    const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                    ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        commentModel.user.username,
                        style: const TextStyle(
                          color: kBlackColor,
                          letterSpacing: .4,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${commentModel.votes} vote(s)',
                        style: const TextStyle(
                          color: kSilverChalice,
                          letterSpacing: .4,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    commentModel.user.headline ?? '',
                    style: const TextStyle(
                      color: kSilverChalice,
                      letterSpacing: .4,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(commentModel.body),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
