import 'package:movies/core/class/app_images.dart';

class AvatarModel {
  String image;
  int avatarIndex;

  AvatarModel({required this.image, required this.avatarIndex});

  static List<AvatarModel> avatars = [
    AvatarModel(image: AppImages.avatars[0], avatarIndex: 0),
    AvatarModel(image: AppImages.avatars[1], avatarIndex: 1),
    AvatarModel(image: AppImages.avatars[2], avatarIndex: 2),
    AvatarModel(image: AppImages.avatars[3], avatarIndex: 3),
    AvatarModel(image: AppImages.avatars[4], avatarIndex: 4),
    AvatarModel(image: AppImages.avatars[5], avatarIndex: 5),
    AvatarModel(image: AppImages.avatars[6], avatarIndex: 6),
    AvatarModel(image: AppImages.avatars[7], avatarIndex: 7),
    AvatarModel(image: AppImages.avatars[8], avatarIndex: 8),
  ];
}
