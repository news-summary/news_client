import 'package:NewsSummary/pages/featured/featured_view.dart';
import 'package:NewsSummary/pages/home/home_cube.dart';
import 'package:NewsSummary/pages/info/info.dart';
import 'package:NewsSummary/pages/news/news_view.dart';
import 'package:NewsSummary/widgets/bottom_navigation.dart';
import 'package:NewsSummary/widgets/search.dart';
import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubeBuilder<HomeCube>(
      builder: (context, cube) {
        return Scaffold(
          body: Container(
            color: Colors.grey[200],
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: SearchWidget(),
                  ),
                  Expanded(child: _getContent(cube))
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation((index) {
            cube.setPosition(index);
          }), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  Widget _getContent(HomeCube cube) {
    return cube.tabPosition.build<int>(
      (value) {
        switch (value) {
          case 0:
            return FeaturedView();
            break;
          case 1:
            return NewsView();
            break;
          case 2:
            return Info();
          default:
            return Container();
        }
      },
      animate: true,
    );
    ;
  }
}
