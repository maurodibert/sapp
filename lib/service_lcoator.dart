import 'package:get_it/get_it.dart';
import 'package:sapp/core/services/tv_maze_db.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<TvMazeDB>(TvMazeDB());
}
