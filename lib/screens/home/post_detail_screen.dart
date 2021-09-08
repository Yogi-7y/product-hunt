import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_hunt/core/configs/size_config.dart';
import 'package:product_hunt/core/resources/colors.dart';
import 'package:product_hunt/core/utils/show_message.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';
import 'package:product_hunt/screens/home/providers/post_comments_provider.dart';
import 'package:product_hunt/screens/home/widgets/comment.dart';
import 'package:product_hunt/screens/home/widgets/topic_chips.dart';
import 'package:product_hunt/shared/custom_image.dart';
import 'package:product_hunt/shared/empty_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
            CommentsProgressIndicator(postModel: postModel),
          ],
        ),
        child: PostDetailsAppBar(postModel: postModel),
      ),
      floatingActionButton: SourceFloatingActionButton(postModel: postModel),
    );
  }
}

class SourceFloatingActionButton extends StatelessWidget {
  final PostModel postModel;

  const SourceFloatingActionButton({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _goToSource(context, postModel.redirectUrl),
      backgroundColor: kMattBlackColor,
      child: const Icon(Icons.public),
    );
  }

  Future<void> _goToSource(BuildContext context, String url) async {
    if (!await canLaunch(url)) {
      ShowMessage.showSnacBar(context, 'Failed to launch');
      return;
    }

    launch(url);
  }
}

class PostDetailsAppBar extends StatelessWidget {
  const PostDetailsAppBar({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kBlackColor,
          )),
      expandedHeight: SizeConfig.instance.blockHeight * 25,
      flexibleSpace: FlexibleSpaceBar(
        background: postModel.screenshotUrl?.eightHundredAndFiftyPixels == null
            ? const EmptyWidget()
            : CustomCachedImage(
                imageUrl: postModel.screenshotUrl!.eightHundredAndFiftyPixels!,
              ),
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
