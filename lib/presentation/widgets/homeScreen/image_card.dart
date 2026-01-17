import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_icons.dart';

class ImageFeatureCardsSection extends StatelessWidget {
  const ImageFeatureCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth / 2) - 24;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT: Record Your Prayer
        SizedBox(
          width: cardWidth,
          height: 200,
          child: SvgFeatureCard(
            title: "Record Your Prayer",
            svgPath: AppIcons.record_prayer_bg,
            onTap: () {},
          ),
        ),

        const SizedBox(width: 10),

        // RIGHT: Qibla + Tashbih
        Column(
          children: [
            SizedBox(
              width: cardWidth,
              height: 95,
              child: SvgFeatureCard(
                title: "Qibla Finder",
                svgPath: AppIcons.qibla_finder_bg,
                onTap: () {},
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: cardWidth,
              height: 95,
              child: SvgFeatureCard(
                title: "Tashbih Counter",
                svgPath: AppIcons.tashbih_counter_bg,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class SvgFeatureCard extends StatelessWidget {
  final String title;
  final String svgPath;
  final VoidCallback onTap;
  final double height;

  const SvgFeatureCard({
    super.key,
    required this.title,
    required this.svgPath,
    required this.onTap,
    this.height = 140,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // SVG Background
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(
                svgPath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Go",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward_ios,
                            size: 10, color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
