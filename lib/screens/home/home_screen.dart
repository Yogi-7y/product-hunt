import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_hunt/core/resources/strings.dart';
import 'package:product_hunt/screens/home/models/post_model.dart';

import '../../core/configs/duration.dart';
import '../../core/configs/size_config.dart';
import '../../core/resources/colors.dart';
import '../../shared/loading_wrapper.dart';
import '../../shared/post_tile.dart';
import 'providers/fetch_products_state_notifier.dart';
import 'providers/post_provider.dart';
import 'widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final response = ref.watch(fetchPostsStateNotifierProvider);

              return response.when(
                data: (posts) => ListView.separated(
                  controller: ref
                      .read(fetchPostsStateNotifierProvider.notifier)
                      .scrollController,
                  itemCount: posts.length,
                  separatorBuilder: (context, index) =>
                      const ListItemSeparator(),
                  itemBuilder: (BuildContext context, int index) =>
                      ProviderScope(
                    overrides: [postProvider.overrideWithValue(posts[index])],
                    child: const PostTile(),
                  ),
                ),
                loading: () => const HomeListLoading(),
                error: (error, _) => const Center(
                  child: Text(kSomethingWentWrongMessage),
                ),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) => ValueListenableBuilder<bool>(
              valueListenable: ref
                  .read(fetchPostsStateNotifierProvider.notifier)
                  .showSearchBar,
              builder: (context, showSearchBar, child) => AnimatedPositioned(
                top: showSearchBar ? kToolbarHeight * .8 : -100.0,
                left: SizeConfig.instance.blockWidth * 5,
                duration: kFastDuration,
                curve: Curves.easeIn,
                child: const SearchBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListItemSeparator extends StatelessWidget {
  const ListItemSeparator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        color: kSilverChalice.withOpacity(.4),
        height: 0,
      ),
    );
  }
}

class HomeListLoading extends StatelessWidget {
  const HomeListLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        16,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListTile(
            leading: AspectRatio(
              aspectRatio: 1,
              child: LoadingWrapper(
                  child: DecoratedBox(
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(8.0)),
              )),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingWrapper(
                  child: Container(
                    width: SizeConfig.instance.blockWidth * 60,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                LoadingWrapper(
                  child: Container(
                    width: SizeConfig.instance.blockWidth * 50,
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
