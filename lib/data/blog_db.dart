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
  String headerImage = '';
  DateTime creationDate = DateTime.now();
}