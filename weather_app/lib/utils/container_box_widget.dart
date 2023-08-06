import 'package:flutter/material.dart';

class ContainerBox extends StatelessWidget {
  const ContainerBox({
    super.key,
    required this.cover,
    required this.imageUrl,
    required this.text,
  });

  final num? cover;
  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.12,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900,
            offset: const Offset(1, 2),
            blurRadius: 3,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.09,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
