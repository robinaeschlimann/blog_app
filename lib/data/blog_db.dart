import 'package:isar/isar.dart';

part 'blog_db.g.dart';

@collection
class BlogDB {
  Id id = Isar.autoIncrement;
  String apiId = '';
  String title = '';
  String content = '';
  DateTime publishedAt = DateTime.now();
  bool isLikedByMe = false;
  String headerImageUrl = '';
  DateTime creationDate = DateTime.now();

  /*BlogDB({
    required this.apiId,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.isLikedByMe,
    required this.headerImageUrl,
  });*/
}