import 'package:NewsSummary/pages/featured/featured_cube.dart';
import 'package:NewsSummary/repository/notice_repository/model/notice.dart';
import 'package:NewsSummary/widgets/error_connection.dart';
import 'package:NewsSummary/widgets/pageTransform/intro_page_item.dart';
import 'package:NewsSummary/widgets/pageTransform/page_transformer.dart';
import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

class FeaturedView extends CubeWidget<FeaturedCube> {
  @override
  Widget buildView(BuildContext context, FeaturedCube cube) {
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildFeatured(cube),
            _getProgress(cube),
          ],
        ),
        _buildErrorConnection(cube)
      ],
    );
  }

  Widget _getProgress(FeaturedCube cube) {
    return cube.progress.build<bool>((value) {
      return value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox.shrink();
    });
  }

  Widget _buildFeatured(FeaturedCube cube) {
    return Container(
      child: cube.noticeList.build<List<Notice>>(
        (value) {
          if (value.isEmpty) return Container();
          return PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return new PageView.builder(
                controller: new PageController(viewportFraction: 0.9),
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final item = IntroNews.fromNotice(value[index]);
                  final pageVisibility = visibilityResolver.resolvePageVisibility(index);
                  return new IntroNewsItem(
                    item: item,
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          );
        },
        animate: true,
      ),
    );
  }

  Widget _buildErrorConnection(FeaturedCube cube) {
    return cube.errorConnection.build<bool>((value) {
      return value
          ? ErrorConnection(tryAgain: () {
              cube.load();
            })
          : SizedBox.shrink();
    });
  }
}
