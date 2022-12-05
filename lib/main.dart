import 'package:ditonton/common/sslpinning.dart';
import 'package:ditonton/common/style/colors.dart';
import 'package:ditonton/common/style/fonts_style.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/folder_tv/presentation/pages/home_tv_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_now_playing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:ditonton/folder_tv/presentation/bloc/search/tv_search_bloc.dart';
import 'package:ditonton/folder_movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/folder_movie/presentation/pages/about_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/movie_home_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/search_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_popular_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_search_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_top_rated_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_watchlist_page.dart';
import 'package:ditonton/folder_movie/presentation/bloc/movie/movie_np_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //bloc movie
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),

        //Bloc Tv
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
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
