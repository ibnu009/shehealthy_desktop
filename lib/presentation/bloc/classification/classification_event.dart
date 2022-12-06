import 'dart:io';

abstract class ClassificationEvent {}

class UploadClassification extends ClassificationEvent {
  File file;

  UploadClassification({required this.file});
}


class ResetClassification extends ClassificationEvent {}
