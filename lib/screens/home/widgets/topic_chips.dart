import 'package:flutter/material.dart';
import '../../../core/resources/colors.dart';
import '../models/post_model.dart';

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
