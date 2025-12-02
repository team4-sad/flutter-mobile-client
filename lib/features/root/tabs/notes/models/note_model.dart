import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 3)
class NoteModel with HiveObjectMixin {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime dateUpdated;

  @HiveField(3)
  String? attachmentLocalPath;

  NoteModel({
    required this.title,
    required this.content,
    required this.dateUpdated,
    required this.attachmentLocalPath
  });

  NoteModel.empty(): this(
    title: "",
    content: "",
    dateUpdated: DateTime.now(),
    attachmentLocalPath: null
  );
}