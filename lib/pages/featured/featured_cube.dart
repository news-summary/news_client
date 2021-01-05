import 'package:NewsSummary/repository/notice_repository/model/notice.dart';
import 'package:NewsSummary/repository/notice_repository/notice_repository.dart';
import 'package:NewsSummary/support/connection/api.dart';
import 'package:cubes/cubes.dart';

class FeaturedCube extends Cube {
  FeaturedCube(this.repository);

  final NoticeRepository repository;

  final progress = ObservableValue<bool>(value: false);
  final errorConnection = ObservableValue<bool>(value: false);
  final noticeList = ObservableList<Notice>(value: []);

  @override
  void ready() {
    load();
    super.ready();
  }

  void load() {
    progress.update(true);
    errorConnection.update(false);

    repository.loadNewsRecent().then((news) => _showNews(news)).catchError(_showImplError);
  }

  _showNews(List<Notice> news) {
    progress.update(false);
    noticeList.addAll(news);
  }

  _showImplError(onError) {
    if (onError is FetchDataException) {
      print("code: ${onError.code()}");
    }
    print(onError);
    errorConnection.update(true);
    progress.update(false);
  }
}
