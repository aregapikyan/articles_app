import 'package:flutter/cupertino.dart';

class UserImage extends StatelessWidget {
  final String imageUrl;

  UserImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                height: 40,
                width: 40,
              )
            : Image.asset(
                'assets/images/profile.jpeg',
                height: 36,
                width: 36,
              ),
      ),
    );
  }
}
