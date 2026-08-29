import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, String> recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']!),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        children: [
          // Recipe Image
          Image.network(
            recipe['image']!, 
            height: 250, 
            width: double.infinity, 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 250,
                color: Colors.grey[300],
                child: Icon(Icons.restaurant, size: 50),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Chip
                Chip(
                  label: Text(recipe['category']!),
                  backgroundColor: Colors.deepOrange[100],
                ),
                SizedBox(height: 10),

                // Description
                Text('About', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(recipe['description']!, style: TextStyle(fontSize: 16, height: 1.5)),
                SizedBox(height: 20),

                // Ingredients
                Text('Ingredients', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(recipe['ingredients']!, style: TextStyle(fontSize: 16, height: 1.5)),
                SizedBox(height: 20),

                // Steps
                Text('Steps', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(recipe['steps']!, style: TextStyle(fontSize: 16, height: 1.5)),
                SizedBox(height: 30),
              ],
            ),
          )
        ],
      ),
    );
  }
}