import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_response.dart';
import '../../../core/utils/logger.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../repository/fetch_posts_repository.dart';
import '../../../service/network_connectivity.dart';

import '../models/post_model.dart';

final _log = getLogger('FetchPostsStateNotifier');

final fetchPostsStateNotifierProvider =
    StateNotifierProvider<FetchPostsStateNotifier, AsyncValue<List<PostModel>>>(
  (ref) => FetchPostsStateNotifier(FetchPostsRepository(
    remoteDataSource: RemoteDataSource(),
    localDataSource: LocalDataSource(),
    connectivity: NetworkConnectivityChecker(),
  )),
);

class FetchPostsStateNotifier
    extends StateNotifier<AsyncValue<List<PostModel>>> {
  FetchPostsStateNotifier(this.fetchPostsRepository)
      : super(const AsyncValue.loading()) {
    fetchTodaysPosts();
    scrollListener();
  }

  final FetchPostsRepository fetchPostsRepository;

  final scrollController =
      ScrollController(debugLabel: 'Home ScrollController');

  final showSearchBar = ValueNotifier<bool>(true);

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _log.i('upwards');
        showSearchBar.value = true;
      } else {
        _log.i('downwards');
        showSearchBar.value = false;
      }
    });
  }

  Future<void> fetchTodaysPosts() async {
    state = const AsyncValue.loading();

    final response = await fetchPostsRepository.getTodaysPosts();

    if (response.status == ApiResponseStatus.error) {
      state = AsyncValue.error(response.message!);
      return;
    }

    state = AsyncValue.data(response.data!);
  }

  Future<void> fetchDaysAgoPosts(int daysAgo) async {
    state = const AsyncValue.loading();

    final response = await fetchPostsRepository.getDaysAgo(daysAgo);

    if (response.status == ApiResponseStatus.error) {
      state = AsyncValue.error(response.message!);
      return;
    }

    state = AsyncValue.data(response.data!);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
