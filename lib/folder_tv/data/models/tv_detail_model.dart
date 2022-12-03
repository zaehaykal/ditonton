import 'package:ditonton/folder_movie/data/models/genre_model.dart';
import 'package:ditonton/folder_tv/data/models/tv_season_model.dart';
import 'package:ditonton/folder_tv/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.genres,
    required this.seasons,
    required this.voteAverage,
  });

  final String? backdropPath;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final List<GenreModel> genres;
  final List<TvSeasonModel> seasons;
  final double voteAverage;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        id: json["id"],
        backdropPath: json["backdrop_path"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        seasons: List<TvSeasonModel>.from(
            json["seasons"].map((x) => TvSeasonModel.fromJson(x))),
        voteAverage: json["vote_average"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "backdrop_path": backdropPath,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "vote_average": voteAverage,
      };

  TvDetail toEntity() {
    return TvDetail(
      id: id,
      backdropPath: backdropPath,
      name: name,
      overview: overview,
      posterPath: posterPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      seasons: seasons.map((season) => season.toEntity()).toList(),
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        backdropPath,
        name,
        overview,
        posterPath,
        genres,
        seasons,
        voteAverage,
      ];
}
