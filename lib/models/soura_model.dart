class Soura {
  List<Verses>? verses;
  Meta? meta;

  Soura({this.verses, this.meta});

  Soura.fromJson(Map<String, dynamic> json) {
    if (json['verses'] != null) {
      verses = <Verses>[];
      json['verses'].forEach((v) {
        verses!.add(Verses.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (verses != null) {
      data['verses'] = verses!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Verses {
  int? id;
  String? verseKey;
  String? textImlaei;

  Verses({this.id, this.verseKey, this.textImlaei});

  Verses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verseKey = json['verse_key'];
    textImlaei = json['text_imlaei'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['verse_key'] = verseKey;
    data['text_imlaei'] = textImlaei;
    return data;
  }
}

class Meta {
  Filters? filters;

  Meta({this.filters});

  Meta.fromJson(Map<String, dynamic> json) {
    filters =
    json['filters'] != null ? Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    return data;
  }
}

class Filters {
  String? chapterNumber;

  Filters({this.chapterNumber});

  Filters.fromJson(Map<String, dynamic> json) {
    chapterNumber = json['chapter_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_number'] = chapterNumber;
    return data;
  }
}