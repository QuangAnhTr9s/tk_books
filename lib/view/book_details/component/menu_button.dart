import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.title,
    required this.urlImage,
    this.onTap,
  });

  final String title;
  final String urlImage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: SizedBox(
        height: 42,
        width: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                urlImage,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xff009593),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
