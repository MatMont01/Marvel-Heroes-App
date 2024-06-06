import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../providers/database_provider.dart';
import '../theme.dart';

class EditMoviePage extends StatefulWidget {
  final MovieModel movie;

  const EditMoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  _EditMoviePageState createState() => _EditMoviePageState();
}

class _EditMoviePageState extends State<EditMoviePage> {
  late TextEditingController _titleController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.movie.title);
    _imageUrlController = TextEditingController(text: widget.movie.imageUrl);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveMovie() async {
    final updatedMovie = MovieModel(
      id: widget.movie.id,
      title: _titleController.text,
      imageUrl: _imageUrlController.text,
      characters: widget.movie.characters,
    );
    await DatabaseProvider().updateMovie(updatedMovie);
    Navigator.pop(context, updatedMovie);
  }

  Future<void> _deleteMovie() async {
    await DatabaseProvider().deleteMovie(widget.movie.id);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Película'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteMovie,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL de la Imagen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMovie,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
