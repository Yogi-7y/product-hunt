import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_hunt/core/configs/size_config.dart';
import 'package:product_hunt/core/resources/colors.dart';
import 'package:product_hunt/screens/home/providers/fetch_products_state_notifier.dart';
import 'package:product_hunt/screens/home/widgets/post_search_delegate.dart';
import 'package:product_hunt/shared/empty_widget.dart';

enum DaysAgo {
  today,
  sevenDaysAgo,
  fourteenDaysAgo,
  thirtyDaysAgo,
}

extension DaysAgoExtension on DaysAgo {
  int get intValue => _mapDaysAgo[this]!;
}

final _mapDaysAgo = <DaysAgo, int>{
  DaysAgo.today: 0,
  DaysAgo.sevenDaysAgo: 7,
  DaysAgo.fourteenDaysAgo: 14,
  DaysAgo.thirtyDaysAgo: 30,
};

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: SizeConfig.instance.blockWidth * 90,
      child: Consumer(
        builder: (context, ref, child) => DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kBlackColor.withOpacity(.12),
                offset: const Offset(0, 4),
                blurRadius: 4.0,
              )
            ],
            color: kWildSandColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: InkWell(
            onTap: () => ref.read(fetchPostsStateNotifierProvider).when(
                  data: (value) => showSearch(
                      context: context, delegate: PostSearchDelegate(value)),
                  loading: () => const EmptyWidget(),
                  error: (_, __) => const EmptyWidget(),
                ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    size: 30.0,
                    color: kSilverChalice,
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: .4,
                      fontWeight: FontWeight.w500,
                      color: kSilverChalice,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<DaysAgo>(
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: DaysAgo.today,
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: kBlackColor,
                            letterSpacing: .4,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: DaysAgo.sevenDaysAgo,
                        child: Text(
                          '7 days ago',
                          style: TextStyle(
                            color: kBlackColor,
                            letterSpacing: .4,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: DaysAgo.fourteenDaysAgo,
                        child: Text('14 days ago',
                            style: TextStyle(
                              color: kBlackColor,
                              letterSpacing: .4,
                              fontSize: 14.0,
                            )),
                      ),
                      PopupMenuItem(
                        value: DaysAgo.thirtyDaysAgo,
                        child: Text(
                          '30 days ago',
                          style: TextStyle(
                            color: kBlackColor,
                            letterSpacing: .4,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                    onSelected: (daysAgo) => _handleDaysAgo(daysAgo, ref),
                    child: const Icon(
                      Icons.filter_list,
                      color: kSilverChalice,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDaysAgo(DaysAgo daysAgo, WidgetRef ref) {
    if (daysAgo == DaysAgo.today) {
      ref.read(fetchPostsStateNotifierProvider.notifier).fetchTodaysPosts();
      return;
    }

    ref
        .read(fetchPostsStateNotifierProvider.notifier)
        .fetchDaysAgoPosts(daysAgo.intValue);
  }
}
