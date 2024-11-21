import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {super.key,
      required this.child,
      required this.isLoading,
      this.cover = false});

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !cover
        ? (isLoading ? _loadingView : child)
        : Stack(
            children: [child, isLoading ? _loadingView : Container()],
          );
  }
}
