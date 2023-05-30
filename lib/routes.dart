import 'package:flutter/material.dart';

import 'app/view/change_config/change_config_screen.dart';
import 'app/view/history/history_screen.dart';
import 'app/view/home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  HistoryScreen.routeName: (context) => const HistoryScreen(),
  ChangeConfigScreen.routeName: (context) => const ChangeConfigScreen(),
};
