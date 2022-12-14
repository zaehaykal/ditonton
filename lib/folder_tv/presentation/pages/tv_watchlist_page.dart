import 'package:ditonton/common/utils.dart';
import 'package:ditonton/folder_tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:ditonton/folder_tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvWatchListPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  const TvWatchListPage({super.key});

  @override
  State<TvWatchListPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<TvWatchListPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTvBloc>().add(FetchWatchlistTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(FetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.watchlistTv[index];
                  return TvCard(tv);
                },
                itemCount: state.watchlistTv.length,
              );
            } else if (state is TvHasError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('No Watchlist'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
