import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';

class PersonalDetailsGenres extends StatelessWidget {
  final List<String> genreChoices;
  final String activeGenre;
  final Function(String) onGenreTap;

  const PersonalDetailsGenres({
    required this.genreChoices,
    required this.activeGenre,
    required this.onGenreTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...genreChoices.map(
          (genre) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Theme(
              data: ThemeData(), // reset the ThemeData to the default
              child: ChoiceChip(
                checkmarkColor: Colors.white,
                label: Text(genre),
                side: BorderSide.none,
                selected: activeGenre == genre,
                selectedColor: AppTheme.primaryColor,
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: AppTheme.secondaryColor,
                onSelected: (selected) {
                  onGenreTap(genre);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
