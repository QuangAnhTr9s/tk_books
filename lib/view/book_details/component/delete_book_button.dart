import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteBookButton extends StatelessWidget {
  const DeleteBookButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 113,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFF5C5C),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.trash_fill,
            size: 12,
            color: Colors.white,
          ),
          Text(
            text.toUpperCase(),
            style: GoogleFonts.quicksand(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          )
        ],
      ),
    );
  }
}
