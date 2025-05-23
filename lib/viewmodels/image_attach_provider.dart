import 'dart:io';

abstract class ImageAttachProvider {
  void addImage(File image);
  void removeImage(File? image);
  List<File> get images;
  int get imageItemCount;
  int get maxImageCount;
}