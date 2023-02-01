import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

const baseColor = Color(0xFFF5F5F5);
const highlightColor = Color(0xFFE0E0E0);

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({
    required this.width,
    required this.height,
    this.margin = EdgeInsets.zero,
    // this.borderRaidus = BorderRadiusDirectional.zero,
    Key? key
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsets? margin;
  // final BorderRadiusDirectional? borderRaidus;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: const BoxDecoration(
        color: highlightColor,
        // borderRadius: borderRaidus
      )
    );
  }
}

class HeadlineShimmer extends StatelessWidget {
  const HeadlineShimmer({
    required this.height,
    required this.widthVariants,
    this.alignment = CrossAxisAlignment.start,
    this.margin = const EdgeInsets.only(top: 8.0),
    Key? key
  }) : super(key: key);

  final double height;
  final List<double> widthVariants;
  final EdgeInsets? margin;
  final CrossAxisAlignment? alignment;

  List<ShimmerItem> getHeadlines() {
    final List<ShimmerItem> headlines = widthVariants
      .map((double headlineWidth) => ShimmerItem(
          width: headlineWidth,
          height: height,
          margin: margin,
        )
      )
      .toList();

    return headlines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment!,
      children: [
        ...getHeadlines()
      ],
    );
  }
}

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({
    Key? key
  }) : super(key: key);

  List<Widget> getTextsPlaceholder() {
    return [
      const ShimmerItem(width: 300, height: 32)

      // const HeadlineShimmer(
      //   height: 16.0,
      //   widthVariants: [297, 86],
      //   margin: EdgeInsets.only(top: 4.0),
      // ),

      // const SizedBox(height: 18,),

      // const HeadlineShimmer(
      //   height: 13.0,
      //   widthVariants: [310, 281, 247, 110],
      //   margin: EdgeInsets.only(top: 4.0),
      // ),
    ];
  }


  List<Widget> getTitleContainer() {
    Colors.grey;
    return [
      const HeadlineShimmer(height: 16, widthVariants: [297, 86],),

      const SizedBox(height: 18,),

      const HeadlineShimmer(height: 13, widthVariants: [310, 281, 247, 110]),

      const SizedBox(height: 32,),

      // Presetinho de botão
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 106),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade400,
        ),
        child: const ShimmerItem(height: 13, width: 104,),
      ),

      const SizedBox(height: 32,),

      // Presetinho de carrousel/lista horizontal de cards
      Row(
        children: const [
          ShimmerItem(
            height: 70,
            width: 70,
            margin: EdgeInsets.only(right: 12),
          ),
          ShimmerItem(
            height: 70,
            width: 70,
            margin: EdgeInsets.only(right: 12),
          ),
          ShimmerItem(
            height: 70,
            width: 70,
            margin: EdgeInsets.only(right: 12),
          ),
        ],
      )

    ];
  }

  Widget getContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      // child: Container(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       ...getTitleContainer()
      //     ],
      //   ),
      // ),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        period: const Duration(milliseconds: 1000),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...getTitleContainer()
            ],
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shimmer")
      ),
      body: getContent(),
    );
  }
}