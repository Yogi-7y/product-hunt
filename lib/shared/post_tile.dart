import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_hunt/core/resources/colors.dart';
import 'package:product_hunt/screens/home/post_detail_screen.dart';
import 'package:product_hunt/screens/home/providers/post_provider.dart';

import '../core/extensions/datetime_extension.dart';

import 'custom_image.dart';

class PostTile extends StatelessWidget {
  const PostTile();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final post = ref.watch(postProvider);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            onTap: () => Navigator.of(context)
                .pushNamed(PostDetailScreen.id, arguments: post),
            leading: AspectRatio(
              aspectRatio: 1,
              child: CustomCachedImage(
                imageUrl: post.thumbnail.imageUrl,
              ),
            ),
            title: Text(
              post.name,
              style: const TextStyle(
                color: kBlackColor,
                letterSpacing: .8,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.tagline,
                  style: TextStyle(
                      color: kBlackColor.withOpacity(.7),
                      letterSpacing: .2,
                      fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      post.userModel.name,
                      style: const TextStyle(
                        fontSize: 10.0,
                        letterSpacing: .4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      '  ·  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      post.createdAt.timesAgo,
                      style: const TextStyle(
                        fontSize: 10.0,
                        letterSpacing: .4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
            dense: true,
            trailing: Column(
              children: [
                Icon(
                  Icons.arrow_drop_up,
                  color: kBlackColor.withOpacity(.8),
                  size: 30.0,
                ),
                Text(
                  post.votesCount.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: .7,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
