class PopularMovies {
  final String? id;
  final String? url;
  final String? primaryTitle;
  final String? originalTitle;
  final String? type;
  final String? description;
  final String? primaryImage;
  final List<Thumbnails>? thumbnails;
  final String? trailer;
  final String? contentRating;
  final int? startYear;
  final dynamic endYear;
  final String? releaseDate;
  final List<String>? interests;
  final List<String>? countriesOfOrigin;
  final List<String>? externalLinks;
  final List<String>? spokenLanguages;
  final List<String>? filmingLocations;
  final List<ProductionCompanies>? productionCompanies;
  final int? budget;
  final dynamic grossWorldwide;
  final List<String>? genres;
  final bool? isAdult;
  final int? runtimeMinutes;
  final double? averageRating;
  final int? numVotes;
  final dynamic metascore;

  PopularMovies({
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
    this.startYear,
    this.endYear,
    this.releaseDate,
    this.interests,
    this.countriesOfOrigin,
    this.externalLinks,
    this.spokenLanguages,
    this.filmingLocations,
    this.productionCompanies,
    this.budget,
    this.grossWorldwide,
    this.genres,
    this.isAdult,
    this.runtimeMinutes,
    this.averageRating,
    this.numVotes,
    this.metascore,
  });

  PopularMovies.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        url = json['url'] as String?,
        primaryTitle = json['primaryTitle'] as String?,
        originalTitle = json['originalTitle'] as String?,
        type = json['type'] as String?,
        description = json['description'] as String?,
        primaryImage = json['primaryImage'] as String?,
        thumbnails = (json['thumbnails'] as List?)?.map((dynamic e) => Thumbnails.fromJson(e as Map<String, dynamic>)).toList(),
        trailer = json['trailer'] as String?,
        contentRating = json['contentRating'] as String?,
        startYear = json['startYear'] as int?,
        endYear = json['endYear'],
        releaseDate = json['releaseDate'] as String?,
        interests = (json['interests'] as List?)?.map((dynamic e) => e as String).toList(),
        countriesOfOrigin = (json['countriesOfOrigin'] as List?)?.map((dynamic e) => e as String).toList(),
        externalLinks = (json['externalLinks'] as List?)?.map((dynamic e) => e as String).toList(),
        spokenLanguages = (json['spokenLanguages'] as List?)?.map((dynamic e) => e as String).toList(),
        filmingLocations = (json['filmingLocations'] as List?)?.map((dynamic e) => e as String).toList(),
        productionCompanies = (json['productionCompanies'] as List?)?.map((dynamic e) => ProductionCompanies.fromJson(e as Map<String, dynamic>)).toList(),
        budget = json['budget'] as int?,
        grossWorldwide = json['grossWorldwide'],
        genres = (json['genres'] as List?)?.map((dynamic e) => e as String).toList(),
        isAdult = json['isAdult'] as bool?,
        runtimeMinutes = json['runtimeMinutes'] as int?,
        averageRating = json['averageRating'] != null
            ? (json['averageRating'] is int
            ? (json['averageRating'] as int).toDouble()
            : json['averageRating'] as double?)
            : null,
        numVotes = json['numVotes'] as int?,
        metascore = json['metascore'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'primaryTitle': primaryTitle,
    'originalTitle': originalTitle,
    'type': type,
    'description': description,
    'primaryImage': primaryImage,
    'thumbnails': thumbnails?.map((e) => e.toJson()).toList(),
    'trailer': trailer,
    'contentRating': contentRating,
    'startYear': startYear,
    'endYear': endYear,
    'releaseDate': releaseDate,
    'interests': interests,
    'countriesOfOrigin': countriesOfOrigin,
    'externalLinks': externalLinks,
    'spokenLanguages': spokenLanguages,
    'filmingLocations': filmingLocations,
    'productionCompanies': productionCompanies?.map((e) => e.toJson()).toList(),
    'budget': budget,
    'grossWorldwide': grossWorldwide,
    'genres': genres,
    'isAdult': isAdult,
    'runtimeMinutes': runtimeMinutes,
    'averageRating': averageRating,
    'numVotes': numVotes,
    'metascore': metascore
  };
}

class Thumbnails {
  final String? url;
  final int? width;
  final int? height;

  Thumbnails({
    this.url,
    this.width,
    this.height,
  });

  Thumbnails.fromJson(Map<String, dynamic> json)
      : url = json['url'] as String?,
        width = json['width'] as int?,
        height = json['height'] as int?;

  Map<String, dynamic> toJson() => {
    'url': url,
    'width': width,
    'height': height
  };
}

class ProductionCompanies {
  final String? id;
  final String? name;

  ProductionCompanies({
    this.id,
    this.name,
  });

  ProductionCompanies.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name
  };
}