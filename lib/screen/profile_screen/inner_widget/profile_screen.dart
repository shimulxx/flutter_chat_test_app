import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app_constants/app_constants.dart';
import 'clipper/profile_clipper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.id,
    required this.imageUrl,
  }) : super(key: key);

  final String name, email, id, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: ProfileClipper(),
            child: Container(
              height: 300,
              color: const Color(0xff141414),
            ),
          ),
          Positioned(
            top: 210,
            child: Column(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 110,
                    width: 110,
                    fit: BoxFit.cover,
                    errorWidget: (c, u, e) => Image.asset(kDefaultLocalAvatarPhoto, height: 110, width: 110,),
                    placeholder: (c, s) => const Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator()),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(name, style: const TextStyle(fontSize: 30),),
                const SizedBox(height: 10,),
                Text('ID: $id', style: const TextStyle(fontSize: 20),),
                const SizedBox(height: 10,),
                Text('Email: $email', style: const TextStyle(fontSize: 20),),
              ],
            ),
          )
        ],
      ),
    );
  }
}