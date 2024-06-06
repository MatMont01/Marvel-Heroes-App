import 'package:flutter/material.dart' hide SearchBar;
import '../components/search_bar.dart';
import '../components/hero_card.dart';
import '../models/hero_model.dart';
import '../providers/database_provider.dart';
import '../theme.dart';
import 'detail_page.dart';

class CategoryPage extends StatefulWidget {
  final String category;

  CategoryPage({required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<HeroModel> _heroes = [];
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadHeroes();
  }

  void _loadHeroes() async {
    List<HeroModel> heroes = await DatabaseProvider().getHeroes();
    setState(() {
      _heroes =
          heroes.where((hero) => hero.category == widget.category).toList();
    });
  }

  void _searchHeroes(String term) {
    setState(() {
      _searchTerm = term;
    });
  }

  void _reloadHeroes() {
    _loadHeroes();
  }

  @override
  Widget build(BuildContext context) {
    List<HeroModel> filteredHeroes = _heroes
        .where((hero) =>
        hero.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: AppTheme.silverColor,
      ),
      body: Column(
        children: [
          SearchBar(onChanged: _searchHeroes),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: filteredHeroes.map((hero) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 152) / 2,
                    child: HeroCard(
                      hero: hero,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(hero: hero),
                          ),
                        ).then((updatedHero) {
                          if (updatedHero != null) {
                            _reloadHeroes();
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
