part of '../imports/profile_imports.dart';

class ProfileViewController {
  const ProfileViewController();

  String imageUrl(String image) {
    if (image.isEmpty || image.startsWith('http')) return image;
    final baseUri = Uri.tryParse(F.baseUrl);
    if (baseUri == null) return image;
    final port = baseUri.hasPort ? ':${baseUri.port}' : '';
    return '${baseUri.scheme}://${baseUri.host}$port$image';
  }

  void dispose() {}
}
