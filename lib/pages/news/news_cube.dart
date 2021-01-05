import 'package:NewsSummary/repository/notice_repository/model/notice.dart';
import 'package:NewsSummary/repository/notice_repository/notice_repository.dart';
import 'package:NewsSummary/support/connection/api.dart';
import 'package:cubes/cubes.dart';

class NewsCube extends Cube {
  final NoticeRepository repository;

  int _page = 0;
  int _currentCategory = 0;
  List<String> _categories = ['general', 'sports', 'technology', 'entertainment', 'health', 'business'];

  NewsCube(this.repository) {
    categoriesName.add(Cubes.getString("cat_general"));
    categoriesName.add(Cubes.getString("cat_sport"));
    categoriesName.add(Cubes.getString("cat_technology"));
    categoriesName.add(Cubes.getString("cat_entertainment"));
    categoriesName.add(Cubes.getString("cat_health"));
    categoriesName.add(Cubes.getString("cat_business"));
  }

  final errorConnection = ObservableValue<bool>(value: false);
  final progress = ObservableValue<bool>(value: false);
  final noticeList = ObservableList<Notice>(value: []);
  final categoriesName = ObservableList<String>(value: []);

  @override
  void ready() {
    load(false);
    super.ready();
  }

  void categoryClick(int position) {
    _currentCategory = position;
    load(false);
  }

  void load(bool isMore) {
    if (!progress.value) {
      if (isMore) {
        _page++;
      } else {
        noticeList.clear();
        _page = 0;
      }

      errorConnection.update(false);

      progress.update(true);

      String category = _categories[_currentCategory];

      repository.loadNews(category, _page).then((news) => _showNews(news, isMore)).catchError(_showImplError);
    }
  }

  _showNews(List<Notice> news, bool isMore) {
    progress.update(false);

    if (isMore) {
      noticeList.addAll(news);
    } else {
      noticeList.update(news);
    }
  }

  _showImplError(onError) {
    if (onError is FetchDataException) {
      print("code: ${onError.code()}");
    }
    errorConnection.update(true);
    progress.update(false);
  }
}
