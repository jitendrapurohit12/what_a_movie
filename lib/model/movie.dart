class Movie {
  int id;
  String name;
  int year,createdAt,updatedAt;
  String thumbnail;
  String director;
  String mainStar;
  String description;
  String url;
  List<Gentres> gentres;
  bool isFav = false;

  Movie(
      {this.id,
        this.name,
        this.year,
        this.thumbnail,
        this.director,
        this.mainStar,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.url,
        this.gentres});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    thumbnail = json['thumbnail'];
    director = json['director'];
    mainStar = json['main_star'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    if (json['gentres'] != null) {
      gentres = new List<Gentres>();
      json['gentres'].forEach((v) {
        gentres.add(new Gentres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['thumbnail'] = this.thumbnail;
    data['director'] = this.director;
    data['main_star'] = this.mainStar;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    if (this.gentres != null) {
      data['gentres'] = this.gentres.map((v) => v.toJson()).toList();
    }
    return data;
  }

  int _hashCode;

  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = identityHashCode(id);
    }
    return _hashCode;
  }

  @override
  bool operator ==(other) => other.id == id && other.name == name;
}

class Gentres {
  String name;

  Gentres({this.name});

  Gentres.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}