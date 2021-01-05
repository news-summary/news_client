import 'package:NewsSummary/repository/summary_repository/summary_repository.dart';
import 'package:NewsSummary/pages/featured/featured_cube.dart';
import 'package:NewsSummary/pages/home/home_cube.dart';
import 'package:NewsSummary/pages/news/news_cube.dart';
import 'package:NewsSummary/pages/search/search_cube.dart';
import 'package:NewsSummary/pages/summarize/summary_cube.dart';
import 'package:NewsSummary/repository/notice_repository/notice_repository.dart';
import 'package:NewsSummary/support/connection/api.dart';
import 'package:cubes/cubes.dart';

initDependencies() {
  injectRepository();
  injectCubes();
}

injectCubes() {
  Cubes.registerDependency((i) => NewsCube(i.getDependency()));
  Cubes.registerDependency((i) => FeaturedCube(i.getDependency()));
  Cubes.registerDependency((i) => HomeCube());
  Cubes.registerDependency((i) => SearchCube(i.getDependency()));
  Cubes.registerDependency((i) => SummaryCube(i.getDependency()));
}

injectRepository() {
  Cubes.registerDependency(
    (i) => Api("http://10.0.2.2:5000/api/v1"),
    isSingleton: true,
  );

  Cubes.registerDependency<NoticeRepository>((i) => NoticeRepositoryImpl(i.getDependency()));
  Cubes.registerDependency<SummaryRepository>((i) => SummaryRepositoryImpl(i.getDependency()));
}
