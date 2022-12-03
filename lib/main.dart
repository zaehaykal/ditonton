import 'package:ditonton/common/style/colors.dart';
import 'package:ditonton/common/style/fonts_style.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/folder_tv/presentation/pages/home_tv_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_now_playing_page.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_popular_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_top_rated_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_watchlist_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/folder_movie/presentation/pages/about_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/movie_home_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/search_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/folder_movie/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/folder_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_popular_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_search_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_top_rated_page.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_now_playing_notifie.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_watchlist_page.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvNowPlayingNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvWatchListNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case TvPopularPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvPopularPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case TvSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case TvWatchListPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvWatchListPage());
            case TvNowPlayingPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvNowPlayingPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
