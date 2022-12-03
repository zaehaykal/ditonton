import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/style/fonts_style.dart';
import 'package:ditonton/folder_movie/presentation/pages/about_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/movie_home_page.dart';
import 'package:ditonton/folder_movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_now_playing_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_popular_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_search_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_top_rated_page.dart';
import 'package:ditonton/folder_tv/presentation/pages/tv_watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tv.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-home';
  const HomeTvPage({super.key});

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(FetchNowPlayingTv());
      context.read<PopularTvBloc>().add(FetchPopularTv());
      context.read<TopRatedTvBloc>().add(FetchTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movie'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.live_tv_outlined),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movie'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv'),
              onTap: () {
                Navigator.pushNamed(context, TvWatchListPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, TvNowPlayingPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvHasData) {
                  return TvList(state.tv);
                } else if (state is TvHasError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, TvPopularPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvHasData) {
                  return TvList(state.tv);
                } else if (state is TvHasError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TvState>(builder: (context, state) {
                if (state is TvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvHasData) {
                  return TvList(state.tv);
                } else if (state is TvHasError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [Text('See more'), Icon(Icons.arrow_forward)],
          ),
        ),
      ),
    ],
  );
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  const TvList(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv1 = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv1.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv1.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
