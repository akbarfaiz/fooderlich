import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/explore_recipe.dart';
import 'components/components.dart';
import 'screens/explore_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/grocery_screen.dart';
import 'screens/search_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<String> keyword = [];
  TextEditingController searchController = TextEditingController();

  void increment(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      keyword.add(value);
      searchController.text = "";
    });
    prefs.setStringList('keyword', keyword);
  }

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Fooderlich',
                style: Theme.of(context).textTheme.headline6),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  icon: Icon(Icons.search))
            ]),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: 'Explore'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.receipt), label: 'Recipes'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'To Buy'),
            ]));
  }
}
