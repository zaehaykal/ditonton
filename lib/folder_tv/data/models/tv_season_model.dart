import 'package:ditonton/folder_tv/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  const TvSeasonModel({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.posterPath,
  });

  final int id;
  final String name;
  final int episodeCount;
  final String? posterPath;

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
        id: json["id"],
        name: json["name"],
        episodeCount: json["episode_count"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  TvSeason toEntity() {
    return TvSeason(
      id: id,
      name: name,
      episodeCount: episodeCount,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        posterPath,
      ];
}
