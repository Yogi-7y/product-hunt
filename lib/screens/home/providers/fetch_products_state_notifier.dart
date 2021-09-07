import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post_model.dart';

final fetchPostsStateNotifierProvider =
    StateNotifierProvider<FetchPostsStateNotifier, AsyncValue<List<PostModel>>>(
  (ref) => FetchPostsStateNotifier(),
);

class FetchPostsStateNotifier
    extends StateNotifier<AsyncValue<List<PostModel>>> {
  FetchPostsStateNotifier() : super(const AsyncValue.loading());

  // final ProductsRepository productsRepository;

  Future<void> call() async {
    // state = const AsyncValue.loading();

    // final response = await productsRepository.getTodaysPosts();

    // if (response.status == ApiResponseStatus.error) {
    //   state = AsyncValue.error(response.message!);
    //   return;
    // }

    // state = AsyncValue.data(response.data!);
  }
}
