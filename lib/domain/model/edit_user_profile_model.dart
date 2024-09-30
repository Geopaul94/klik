class EditUserProfileModel {
  final String name;
  final String bio;
  final dynamic image;
  final String imageUrl;
  final dynamic bgImage;
  final String bgImageUrl;

  EditUserProfileModel(
      {required this.name,
      required this.bio,
      required this.image,
      required this.imageUrl,
      required this.bgImage,
      required this.bgImageUrl});
}
