class SearchResultModel {
  final int? rows;
  final int? numFound;
  final List<Results>? results;
  final String? nextCursorMark;

  SearchResultModel({
    this.rows,
    this.numFound,
    this.results,
    this.nextCursorMark,
  });

  SearchResultModel.fromJson(Map<String, dynamic> json)
      : rows = json['rows'] as int?,
        numFound = json['numFound'] as int?,
        results = (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList(),
        nextCursorMark = json['nextCursorMark'] as String?;

  Map<String, dynamic> toJson() => {
    'rows' : rows,
    'numFound' : numFound,
    'results' : results?.map((e) => e.toJson()).toList(),
    'nextCursorMark' : nextCursorMark
  };
}

class Results {
  final String? id;
  final String? url;
  final String? primaryTitle;
  final String? originalTitle;
  final String? type;
  final String? description;
  final dynamic primaryImage;
  final List<dynamic>? thumbnails;
  final dynamic trailer;
  final dynamic contentRating;
  final bool? isAdult;
  final dynamic releaseDate;
  final dynamic startYear;
  final dynamic endYear;
  final dynamic runtimeMinutes;
  final List<String>? genres;
  final List<String>? interests;
  final List<String>? countriesOfOrigin;
  final List<String>? externalLinks;
  final List<String>? spokenLanguages;
  final dynamic filmingLocations;
  final List<dynamic>? productionCompanies;
  final dynamic budget;
  final dynamic grossWorldwide;
  final dynamic averageRating;
  final dynamic numVotes;
  final dynamic metascore;

  Results({
    this.id,
    this.url,
    this.primaryTitle,
    this.originalTitle,
    this.type,
    this.description,
    this.primaryImage,
    this.thumbnails,
    this.trailer,
    this.contentRating,
    this.isAdult,
    this.releaseDate,
    this.startYear,
    this.endYear,
    this.runtimeMinutes,
    this.genres,
    this.interests,
    this.countriesOfOrigin,
    this.externalLinks,
    this.spokenLanguages,
    this.filmingLocations,
    this.productionCompanies,
    this.budget,
    this.grossWorldwide,
    this.averageRating,
    this.numVotes,
    this.metascore,
  });

  Results.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        url = json['url'] as String?,
        primaryTitle = json['primaryTitle'] as String?,
        originalTitle = json['originalTitle'] as String?,
        type = json['type'] as String?,
        description = json['description'] as String?,
        primaryImage = json['primaryImage'],
        thumbnails = json['thumbnails'] as List?,
        trailer = json['trailer'],
        contentRating = json['contentRating'],
        isAdult = json['isAdult'] as bool?,
        releaseDate = json['releaseDate'],
        startYear = json['startYear'],
        endYear = json['endYear'],
        runtimeMinutes = json['runtimeMinutes'],
        genres = (json['genres'] as List?)?.map((dynamic e) => e as String).toList(),
        interests = (json['interests'] as List?)?.map((dynamic e) => e as String).toList(),
        countriesOfOrigin = (json['countriesOfOrigin'] as List?)?.map((dynamic e) => e as String).toList(),
        externalLinks = (json['externalLinks'] as List?)?.map((dynamic e) => e as String).toList(),
        spokenLanguages = (json['spokenLanguages'] as List?)?.map((dynamic e) => e as String).toList(),
        filmingLocations = json['filmingLocations'],
        productionCompanies = json['productionCompanies'] as List?,
        budget = json['budget'],
        grossWorldwide = json['grossWorldwide'],
        averageRating = json['averageRating'],
        numVotes = json['numVotes'],
        metascore = json['metascore'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'url' : url,
    'primaryTitle' : primaryTitle,
    'originalTitle' : originalTitle,
    'type' : type,
    'description' : description,
    'primaryImage' : primaryImage,
    'thumbnails' : thumbnails,
    'trailer' : trailer,
    'contentRating' : contentRating,
    'isAdult' : isAdult,
    'releaseDate' : releaseDate,
    'startYear' : startYear,
    'endYear' : endYear,
    'runtimeMinutes' : runtimeMinutes,
    'genres' : genres,
    'interests' : interests,
    'countriesOfOrigin' : countriesOfOrigin,
    'externalLinks' : externalLinks,
    'spokenLanguages' : spokenLanguages,
    'filmingLocations' : filmingLocations,
    'productionCompanies' : productionCompanies,
    'budget' : budget,
    'grossWorldwide' : grossWorldwide,
    'averageRating' : averageRating,
    'numVotes' : numVotes,
    'metascore' : metascore
  };
}