import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../theme.dart';

class HeroCard extends StatelessWidget {
  final HeroModel hero;
  final VoidCallback onTap;

  const HeroCard({
    Key? key,
    required this.hero,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                height: 230.0,
                width: 140.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(hero.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
                  color: Colors.black.withOpacity(0.1), // Fondo semitransparente
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hero.name,
                      style: AppTheme.heavy20px.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      hero.alias,
                      style: AppTheme.medium10px.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis, // Handle overflow of text
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
