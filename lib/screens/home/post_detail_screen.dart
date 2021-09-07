import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_hunt/core/configs/size_config.dart';
import 'package:product_hunt/core/resources/colors.dart';
import 'package:product_hunt/screens/home/models/comment_model.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';
import 'package:product_hunt/screens/home/providers/post_comments_provider.dart';
import 'package:product_hunt/shared/custom_image.dart';
import 'package:product_hunt/shared/empty_widget.dart';

import '../../core/extensions/datetime_extension.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel postModel;

  static const String id = 'popst_detail_screen';

  const PostDetailScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) => Stack(
          children: [
            CustomScrollView(
              controller: ref
                  .read(postCommentStateNotifierProvider(postModel).notifier)
                  .scrollcontroller,
              slivers: [
                child!,
                PostDetails(postModel: postModel),
                Topics(postModel: postModel),
                Comments(
                  comments:
                      ref.watch(postCommentStateNotifierProvider(postModel)),
                )
              ],
            ),
            ValueListenableBuilder<bool>(
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
            ),
          ],
        ),
        child: SliverAppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kBlackColor,
              )),
          expandedHeight: SizeConfig.instance.blockHeight * 25,
          flexibleSpace: FlexibleSpaceBar(
            background: postModel.screenshotUrl?.eightHundredAndFiftyPixels ==
                    null
                ? const EmptyWidget()
                : CustomCachedImage(
                    imageUrl:
                        postModel.screenshotUrl!.eightHundredAndFiftyPixels!,
                  ),
          ),
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

class PostDetails extends StatelessWidget {
  const PostDetails({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12.0),
            Text(
              postModel.name,
              style: const TextStyle(
                color: kBlackColor,
                fontWeight: FontWeight.w600,
                letterSpacing: .7,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              postModel.tagline,
              style: const TextStyle(
                color: kSilverChalice,
                fontWeight: FontWeight.w500,
                letterSpacing: .7,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(postModel.userModel.imageUrl!),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  postModel.userModel.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kMattBlackColor,
                    letterSpacing: .4,
                    fontSize: 16.0,
                  ),
                ),
                const Text(
                  '  ·  ',
                  style: TextStyle(
                      color: kSilverChalice, fontWeight: FontWeight.bold),
                ),
                Text(
                  postModel.createdAt.timesAgo,
                  style: TextStyle(color: kBlackColor.withOpacity(.7)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Topics extends StatelessWidget {
  const Topics({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            postModel.topics.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Chip(
                label: Text(
                  postModel.topics[index].name,
                  style: const TextStyle(
                    color: kWhiteColor,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
                backgroundColor: kMattBlackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
