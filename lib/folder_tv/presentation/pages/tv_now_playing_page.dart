import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/folder_tv/presentation/provider/tv_now_playing_notifie.dart';
import 'package:ditonton/folder_tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvNowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/-tv-nowplaying-page';

  @override
  _TvNowPlatingPageState createState() => _TvNowPlatingPageState();
}

class _TvNowPlatingPageState extends State<TvNowPlayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvNowPlayingNotifier>(context, listen: false)
            .fetchNowPlayingNotifier());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvNowPlayingNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
