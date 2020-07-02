class Post {
  final String title;
  final String description;
  final String videoId;
  final String videoThumbnail;

  Post(this.title, this.description, this.videoId, this.videoThumbnail);
  Post.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        videoId = json['videoId'],
        videoThumbnail = json["videoThumbnail"];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'videoId': videoId,
        'videoThumbnail': videoThumbnail,
      };
}