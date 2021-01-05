import 'package:NewsSummary/pages/search/search_cube.dart';
import 'package:NewsSummary/repository/notice_repository/model/notice.dart';
import 'package:NewsSummary/widgets/AnimatedContent.dart';
import 'package:NewsSummary/widgets/error_connection.dart';
import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

class SearchView extends CubeWidget<SearchCube> {
  final String query;

  SearchView(this.query);

  @override
  get initData => query;

  @override
  Widget buildView(BuildContext context, SearchCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text(query),
      ),
      body: Stack(
        children: <Widget>[
          _getListViewWidget(cube),
          _getProgress(cube),
          _getEmpty(cube),
          _buildConnectionError(cube),
        ],
      ),
    );
  }

  Widget _getListViewWidget(SearchCube cube) {
    return cube.noticeList.build<List<Notice>>((value) {
      return AnimatedContent(
        show: value.length > 0,
        child: ListView.builder(
          itemCount: value.length,
          padding: const EdgeInsets.only(top: 5.0),
          itemBuilder: (context, index) {
            return value[index];
          },
        ),
      );
    });
  }

  Widget _getProgress(SearchCube cube) {
    return cube.progress.build<bool>(
      (value) {
        return value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink();
      },
      animate: true,
    );
  }

  Widget _getEmpty(SearchCube cube) {
    return cube.empty.build<bool>((value) {
      return value
          ? Center(
              child: Text(Cubes.getString("error_search")),
            )
          : SizedBox.shrink();
    });
  }

  Widget _buildConnectionError(SearchCube cube) {
    return cube.error.build((value) {
      return value
          ? ErrorConnection(tryAgain: () {
              cube.search(query);
            })
          : SizedBox.shrink();
    });
  }
}
