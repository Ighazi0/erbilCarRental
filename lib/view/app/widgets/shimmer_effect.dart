import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const ShimmerEffect({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            period: const Duration(seconds: 2),
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: child,
          )
        : child;
  }
}
