
import 'package:NewsSummary/support/connection/api.dart';

import 'model/summary.dart';

abstract class SummaryRepository {
  Future<Summary> getSummary(String sourceUrl);
}

class SummaryRepositoryImpl implements SummaryRepository {
  final Api _api;

  SummaryRepositoryImpl(this._api);

  @override
  Future<Summary> getSummary(String sourceUrl) async{
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final Map result = await _api.post("/news/summary/",  "raw_url=$sourceUrl",
        headers: headers);
    return new Summary.fromMap(result);
  }

}

