import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> keyword = [];
  TextEditingController searchController = TextEditingController();

  void addKeyword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      keyword.add(value);
      searchController.text = "";
    });
    prefs.setStringList('keyword', keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 30),
              TextField(
                  controller: searchController,
                  decoration: new InputDecoration(hintText: 'Search'),
                  autofocus: true,
                  onSubmitted: (value) {
                    addKeyword(value);
                  },
                  textInputAction: TextInputAction.search),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      keyword[index],
                    ),
                  );
                },
                itemCount: keyword.length,
              ))
            ],
          ),
        )));
  }
}
