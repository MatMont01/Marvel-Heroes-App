import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../providers/database_provider.dart';

class EditHeroPage extends StatefulWidget {
  final HeroModel hero;

  EditHeroPage({required this.hero});

  @override
  _EditHeroPageState createState() => _EditHeroPageState();
}

class _EditHeroPageState extends State<EditHeroPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _aliasController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _earthController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  Map<String, int> _abilities = {};
  late List<String> _movies;
  String _category = 'Héroes';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.hero.name);
    _aliasController = TextEditingController(text: widget.hero.alias);
    _ageController = TextEditingController(text: widget.hero.age.toString());
    _weightController =
        TextEditingController(text: widget.hero.weight.toString());
    _heightController =
        TextEditingController(text: widget.hero.height.toString());
    _earthController = TextEditingController(text: widget.hero.earth);
    _descriptionController =
        TextEditingController(text: widget.hero.description);
    _imageUrlController = TextEditingController(text: widget.hero.imageUrl);
    _abilities = Map.from(widget.hero.abilities);
    _movies = List.from(widget.hero.movies);
    _category = widget.hero.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aliasController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _earthController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateHero() {
    if (_formKey.currentState!.validate()) {
      HeroModel updatedHero = HeroModel(
        id: widget.hero.id,
        name: _nameController.text,
        alias: _aliasController.text,
        age: int.parse(_ageController.text),
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
        earth: _earthController.text,
        abilities: _abilities,
        description: _descriptionController.text,
        movies: _movies,
        imageUrl: _imageUrlController.text,
        category: _category,
      );

      DatabaseProvider().updateHero(updatedHero).then((_) {
        Navigator.pop(context, updatedHero);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Héroe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aliasController,
                decoration: const InputDecoration(labelText: 'Alias'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el alias';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la edad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Peso'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el peso';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Altura'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la altura';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _earthController,
                decoration: const InputDecoration(labelText: 'Tierra'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la tierra';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL de Imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la URL de la imagen';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: [
                  'Héroes',
                  'Anti-héroes',
                  'Villanos',
                  'Alienígenas',
                  'Humanos'
                ].map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              ..._abilities.keys.map((ability) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$ability: ${_abilities[ability]}'),
                    Slider(
                      value: _abilities[ability]!.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _abilities[ability].toString(),
                      onChanged: (double newValue) {
                        setState(() {
                          _abilities[ability] = newValue.toInt();
                        });
                      },
                    ),
                  ],
                );
              }).toList(),
              ElevatedButton(
                onPressed: _updateHero,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
