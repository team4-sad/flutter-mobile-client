import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

abstract class INoteAttachmentRepository {
  Future<NoteModel> addAttachment(File attachment, NoteModel note);
}

class NoteAttachmentRepository extends INoteAttachmentRepository {

  static const String _imageFolder = 'cached_images';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get _imageFolderPath async {
    final localPath = await _localPath;
    final folderPath = p.join(localPath, _imageFolder);

    final folder = Directory(folderPath);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    return folderPath;
  }

  Future<File> copyImageToCache(File originalFile, {String? customName}) async {
    try {
      final imageFolder = await _imageFolderPath;

      final originalName = p.basename(originalFile.path);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = p.extension(originalName).toLowerCase();

      final fileName = customName ?? 'image_$timestamp}$extension';
      final newPath = p.join(imageFolder, fileName);

      final newFile = await originalFile.copy(newPath);
      return newFile;
    } catch (e) {
      debugPrint('Error copying image to cache: $e');
      rethrow;
    }
  }

  @override
  Future<NoteModel> addAttachment(File attachment, NoteModel note) async {
    final copiedFile = await copyImageToCache(attachment);
    note.attachmentLocalPath = copiedFile.path;
    note.save();
    return note;
  }
}