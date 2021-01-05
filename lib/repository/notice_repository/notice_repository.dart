
import 'package:NewsSummary/repository/notice_repository/model/notice.dart';
import 'package:NewsSummary/support/connection/api.dart';

import 'model/notice.dart';

abstract class NoticeRepository{
  Future<List<Notice>> loadNews(String category, int page);
  Future<List<Notice>> loadNewsRecent();
  Future<List<Notice>> loadSearch(String query);
}
class NoticeRepositoryImpl implements NoticeRepository{

  final Api _api;

  NoticeRepositoryImpl(this._api);

  Future<List<Notice>> loadNews(String category, int page) async {
    final Map result = await _api.get("/news/recent/$category");
    return result['data'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
  }

  Future<List<Notice>> loadNewsRecent() async {
    final Map result = await _api.get("/news/recent/?country=us");
    return result['data'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
  }

  Future<List<Notice>> loadSearch(String query) async {

    final Map result = await _api.get("/news/recent/search/$query");

    if(result.containsKey('data') && result['data'] != null){
      return result['data'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
    }else{
      return List();
    }
  }

}

