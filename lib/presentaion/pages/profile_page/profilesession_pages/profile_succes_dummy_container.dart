
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

Widget profileContainer(Size media, String profileImage, String coverImage,) {
  return Container(
    height: 210,
    width: media.width,
    decoration: BoxDecoration(
      color: white,
      image: DecorationImage(
        image: CachedNetworkImageProvider(coverImage),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: -60,
          left: 20,
          child: Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              color: white,
              border: Border.all(width: 5, color: white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: CachedNetworkImage(
              imageUrl: profileImage,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    ),
  );
}
