import 'dart:io';

abstract class ClassificationState {}

class InitClassificationState extends ClassificationState {}

class ShowLoading extends ClassificationState {}

class ShowIdle extends ClassificationState {}

class ShowSuccessClassification extends ClassificationState {
  String data;
  String assumption;
  File image;
  ShowSuccessClassification({required this.data, required this.assumption, required this.image});
}

class ShowFailedClassification extends ClassificationState {}
