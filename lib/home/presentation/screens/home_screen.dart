import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:twitter_demo/home/presentation/widgets/custom_drawer.dart';
import 'package:twitter_demo/home/presentation/widgets/home_FAB.dart';
import 'package:twitter_demo/home/presentation/widgets/news_feed.dart';
import 'package:twitter_demo/home/presentation/widgets/news_feed_appbar.dart';
import 'package:twitter_demo/home/presentation/widgets/news_feed_bottom_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? _previousOffset;
  ScrollDirection? _previousScrollDirection;
  bool? _showBottomMenu;

  @override
  void initState() {
    super.initState();
    _showBottomMenu = true;
    _previousOffset = 0.0;
    _previousScrollDirection = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleScrolling(ScrollController scrollController) {
    if(scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if(_previousScrollDirection != scrollController.position.userScrollDirection) {
        _previousScrollDirection = scrollController.position.userScrollDirection;
        _previousOffset = scrollController.offset;
      }
      if(_previousOffset! - scrollController.offset >= 80 && !_showBottomMenu!) {
        setState(() {
          _showBottomMenu = true;
        });
      }
      
    } else if(scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      
      if(_previousScrollDirection != scrollController.position.userScrollDirection) {
        _previousScrollDirection = scrollController.position.userScrollDirection;
        _previousOffset = scrollController.offset;
      }
      if(scrollController.offset - _previousOffset! >= 80 && _showBottomMenu!) {
        setState(() {
          _showBottomMenu = false;
        });
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: HomeScreenDrawer(),
        body: CustomScrollView(
          slivers: [
            NewsFeedAppBar(), 
            NewsFeed(_handleScrolling)
          ]
        ),
        bottomNavigationBar: NewsFeedBottomMenu(_showBottomMenu),
        floatingActionButton: HomeScreenFAB(_showBottomMenu),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
      
    );
  }
}
