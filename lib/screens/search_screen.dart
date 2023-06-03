import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../widgets/image_widget.dart';
import '../services/tenor_api.dart';
import '../widgets/bottom_navigation_buttons.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  List<String> _imageUrls = [];
  List<String> _searchSuggestions = [];

  void _searchImages() async {
    List<String> imageUrls = await TenorAPI.searchImages(_searchText);

    setState(() {
      _imageUrls = imageUrls;
    });
  }

  void _getSearchSuggestions(String searchText) async {
    List<String> suggestions = await TenorAPI.searchSuggestions(searchText);

    setState(() {
      _searchSuggestions = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                          _getSearchSuggestions(value);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Enter text here',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            _searchImages();
                          },
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return await TenorAPI.searchSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _searchText = suggestion;
                        _searchSuggestions.clear();
                      });
                      _searchImages();
                    },
                  ),
                  if (_searchSuggestions.isNotEmpty)
                    Container(
                      height: 150,
                      child: ListView.builder(
                        itemCount: _searchSuggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_searchSuggestions[index]),
                            onTap: () {
                              setState(() {
                                _searchText = _searchSuggestions[index];
                                _searchSuggestions.clear();
                              });
                              _searchImages();
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return ImageWidget(imageUrl: _imageUrls[index]);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButtons(
        onHomePressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        onFavoritePressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoriteScreen()),
          );
        },
        onSettingsPressed: () {
          // TODO: Handle settings button pressed event
        },
      ),
    );
  }
}
