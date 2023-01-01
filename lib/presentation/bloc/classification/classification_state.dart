import 'dart:io';

abstract class ClassificationState {}

class InitClassificationState extends ClassificationState {}

class ShowLoading extends ClassificationState {}

class ShowIdle extends ClassificationState {}

class ShowSuccessClassification extends ClassificationState {
  final String data, assumption, classificationType;
  File image;

  ShowSuccessClassification(
      {required this.data,
      required this.assumption,
      required this.image,
      required this.classificationType});
}

class ShowFailedClassification extends ClassificationState {}
