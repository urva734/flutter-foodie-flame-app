import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodie_flame/recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> allRecipes = [
    {
      'name': 'Chicken Biryani',
      'category': 'Biryani',
      'image': 'https://images.unsplash.com/photo-1631515242808-497c3fbd3972?w=600',
      'description': 'Fragrant rice with tender chicken and spices',
      'ingredients': '- 500g Chicken\n- 2 Cups Basmati Rice\n- Biryani Masala\n- Yogurt\n- Onions\n- Ginger Garlic Paste',
      'steps': '1. Marinate chicken\n2. Fry onions\n3. Layer rice and chicken\n4. Dum cook for 30 mins'
    },
    {
      'name': 'Chicken Karahi',
      'category': 'Curry',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2CIPPAC8kr6sAm9n8NjQ8ijFEq5zhJU1qXB_SoUaCNdgpARiCoxWrBY4&s=10',
      'description': 'Spicy tomato and ginger chicken curry',
      'ingredients': '- 1kg Chicken\n- 4 Tomatoes\n- Green Chilies\n- Ginger\n- Garlic\n- Karahi Masala',
      'steps': '1. Cook chicken in oil\n2. Add tomatoes\n3. Add spices\n4. Cook on high flame'
    },
    {
      'name': 'Beef Nihari',
      'category': 'Curry',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0NjBQzanCH8zD9F6wy_LuARmhc4hme3yQ42ZkFBHqCTl3ToB-0fatiKoV&s=10',
      'description': 'Slow cooked beef stew with special spices',
      'ingredients': '- 1kg Beef\n- Nihari Masala\n- Wheat Flour\n- Ginger\n- Green Chilies\n- Lemon',
      'steps': '1. Boil beef for 4 hours\n2. Add nihari masala\n3. Make roux\n4. Garnish and serve'
    },
    {
      'name': 'Seekh Kebab',
      'category': 'BBQ',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdv-vD5pxLlgA9QwJNNfr2uVKX-_P9LVCzVWFdbxz3cxO-IJHcuEZPfJbt&s=10',
      'description': 'Grilled minced meat skewers',
      'ingredients': '- 500g Minced Meat\n- Onions\n- Green Chilies\n- Spices\n- Skewers\n- Oil',
      'steps': '1. Mix meat with spices\n2. Make on skewers\n3. Grill on coal\n4. Serve with naan'
    },
    {
      'name': 'Beef Biryani',
      'category': 'Biryani',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5_O_0TkGbhcgELy4YaaKjDhC_cFzdmzWfvM3S6zlqaTKbGWMDI0hvVfA&s=10',
      'description': 'Rich beef biryani with potatoes',
      'ingredients': '- 1kg Beef\n- 3 Cups Rice\n- Potatoes\n- Biryani Masala\n- Yogurt\n- Fried Onions',
      'steps': '1. Cook beef with masala\n2. Boil rice\n3. Layer with potatoes\n4. Dum for 25 mins'
    },
    {
      'name': 'Daal Chawal',
      'category': 'Daal',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfaHMbe28b87FckQhIdsAjrcrx3mFp1v7uCfeBTUMw0EVbM2xDWZnqtn5w&s=10',
      'description': 'Comforting lentils with steamed rice',
      'ingredients': '- 1 Cup Daal\n- 2 Cups Rice\n- Onions\n- Tomatoes\n- Ginger Garlic\n- Spices',
      'steps': '1. Boil daal with spices\n2. Make tarka\n3. Cook rice\n4. Serve together'
    },
    {
      'name': 'Chicken Tikka',
      'category': 'BBQ',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSONGXf6YHVHesvjzqXLoqUAC7MClIooisfrGDVFMG81g&s=10',
      'description': 'Marinated chicken pieces grilled to perfection',
      'ingredients': '- 1kg Chicken\n- Tikka Masala\n- Yogurt\n- Lemon\n- Ginger Garlic\n- Coal',
      'steps': '1. Marinate for 2 hours\n2. Skewer chicken\n3. Grill on coal\n4. Serve with chutney'
    },
    {
      'name': 'Paya',
      'category': 'Curry',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0d8_UKJZv8A-GYf1NpOiTbKz3jQ5yqi0KR7mqOFCghZWVTX72YsbsdH8&s=10',
      'description': 'Traditional trotters curry',
      'ingredients': '- 1kg Paya\n- Spices\n- Onions\n- Ginger Garlic\n- Green Chilies\n- Naan',
      'steps': '1. Boil paya for 6 hours\n2. Add spices\n3. Cook thick gravy\n4. Serve with naan'
    },
  ];

  List<Map<String, String>> filteredRecipes = [];
  List<String> categories = ['All', 'Biryani', 'Curry', 'BBQ', 'Daal'];
  String selectedCategory = 'All';
  TextEditingController searchController = TextEditingController();
  List<String> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = allRecipes;
    _loadFavorites();
    searchController.addListener(_filterRecipes);
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteRecipes = prefs.getStringList('favorites')?? [];
    });
  }

  Future<void> _toggleFavorite(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteRecipes.contains(name)) {
        favoriteRecipes.remove(name);
      } else {
        favoriteRecipes.add(name);
      }
    });
    prefs.setStringList('favorites', favoriteRecipes);
  }

  void _filterRecipes() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = allRecipes.where((recipe) {
        bool matchesSearch = recipe['name']!.toLowerCase().contains(query);
        bool matchesCategory = selectedCategory == 'All' || recipe['category'] == selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      _filterRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Foodie Flame', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)), // BIGGER TITLE
        backgroundColor: Colors.deepOrange,
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          // NEW: WELCOME BANNER - MAKES IT LOOK ATTRACTIVE
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover Delicious Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Authentic Pakistani cuisine at your fingertips',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) => _selectCategory(category),
                    selectedColor: Colors.deepOrange,
                    labelStyle: TextStyle(color: selectedCategory == category? Colors.white : Colors.black, fontWeight: FontWeight.w600),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65, // TALLER CARDS FOR BIGGER IMAGES
              ),
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                return buildRecipeCard(filteredRecipes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecipeCard(Map<String, String> recipe) {
    bool isFav = favoriteRecipes.contains(recipe['name']);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe: recipe)),
        );
      },
      child: Card(
        elevation: 5, // MORE SHADOW
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                recipe['image']!, 
                height: 180, // BIGGER IMAGE
                width: double.infinity, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: Icon(Icons.restaurant, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(recipe['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(recipe['description']!, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(isFav? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  onPressed: () => _toggleFavorite(recipe['name']!),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}