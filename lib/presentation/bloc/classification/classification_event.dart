import 'dart:io';

abstract class ClassificationEvent {}

class UploadClassification extends ClassificationEvent {
  final File file;
  final String classificationType;
  UploadClassification({required this.file, required this.classificationType});
}


class ResetClassification extends ClassificationEvent {}
