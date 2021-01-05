
import 'package:NewsSummary/repository/summary_repository/model/summary.dart';
import 'package:NewsSummary/repository/summary_repository/summary_repository.dart';
import 'package:NewsSummary/support/connection/api.dart';
import 'package:cubes/cubes.dart';

class SummaryCube extends Cube {
  final SummaryRepository repository;

  final tabPosition = ObservableValue<int>(value: 0);

  SummaryCube(this.repository);

  final progress = ObservableValue<bool>(value: false);
  final error = ObservableValue<bool>(value: false);
  final empty = ObservableValue<bool>(value: false);
  final summary = ObservableValue<Summary>();

  @override
  void ready() {
    summarize(data);
    super.ready();
  }

  void setPosition(int position) {
    tabPosition.update(position);
  }

  void summarize(String urlToSummarize) {
    progress.update(true);
    error.update(false);

    repository.getSummary(urlToSummarize).then((summary) => _showSummary(summary)).catchError(_showImplError);
  }

  _showSummary(Summary newsSummary) {
    progress.update(false);
    if (null != newsSummary) {
      summary.update(newsSummary);
      empty.update(false);
    } else {
      empty.update(true);
    }
  }

  _showImplError(onError) {
    print(onError);
    if (onError is FetchDataException) {
      print("code: ${onError.code()}");
    }
    error.update(true);
    progress.update(false);
  }
}
