import 'package:flutter/material.dart';

import '../../widget/loading_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafc),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RefreshIndicator(
                  onRefresh: () {
                    // return Future;
                  },
                  child: ListView(
                    children: [],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
