import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  const TvSeason({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.posterPath,
  });

  final int id;
  final String name;
  final int episodeCount;
  final String? posterPath;

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        posterPath,
      ];
}
