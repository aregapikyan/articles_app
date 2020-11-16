class ModelArticle {
  int id;
  String userName;
  int elapsedTimeInHour;
  bool bookmarked;
  String userImage;
  String title;
  String description;
  List<String> images;

  ModelArticle({
      this.id, 
      this.userName, 
      this.elapsedTimeInHour, 
      this.bookmarked, 
      this.userImage, 
      this.title, 
      this.description, 
      this.images});

  ModelArticle.fromJson(dynamic json) {
    id = json["id"];
    userName = json["userName"];
    elapsedTimeInHour = json["elapsedTimeInHour"];
    bookmarked = json["bookmarked"];
    userImage = json["userImage"];
    title = json["title"];
    description = json["description"];
    images = json["images"] != null ? json["images"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["userName"] = userName;
    map["elapsedTimeInHour"] = elapsedTimeInHour;
    map["bookmarked"] = bookmarked;
    map["userImage"] = userImage;
    map["title"] = title;
    map["description"] = description;
    map["images"] = images;
    return map;
  }

}