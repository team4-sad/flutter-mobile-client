import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 3)
class NoteModel with HiveObjectMixin {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime dateUpdated;

  @HiveField(3)
  final String? attachmentLocalPath;

  NoteModel({
    required this.title,
    required this.content,
    required this.dateUpdated,
    required this.attachmentLocalPath
  });
}