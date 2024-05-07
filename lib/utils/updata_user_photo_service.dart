import 'package:image_picker/image_picker.dart';

class UpdateUserPhotoSManager {
  static XFile? _coverImage;
  static XFile? _avatarImage;

  static XFile? get coverImage => _coverImage;
  static XFile? get avatarImage => _avatarImage;

  static setCoverImage(XFile? image) => _coverImage = image;
  static setAvatarImage(XFile? image) => _avatarImage = image;
  static resetImages() {
    _coverImage = null;
    _avatarImage = null;
  }
}