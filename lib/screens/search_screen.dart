import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internflutter/screens/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class Search extends StatefulWidget {
  String title, image, description, category;
  double price;

  Search(
      {required this.title,
      required this.image,
      required this.description,
      required this.category,
      required this.price,
      Key? key})
      : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Search> searchList = [];
  TextEditingController searchController = TextEditingController();

  Future<List<Search>> getsearch() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Search search = Search(
          title: i['title'],
          image: i['image'],
          description: i['description'],
          category: i['category'],
          price: i['price'],
        );
        searchList.add(search);
      }
      return searchList;
    } else {
      return searchList;
    }
  }

  List<Search> filterSearchResults(String query) {
    return searchList
        .where((search) =>
            search.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    color: Colors.black, // Border color when focused
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getsearch(),
              builder: (context, AsyncSnapshot<List<Search>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(children: [
                          ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 70,
                                width: 70,
                                color: Colors.white,
                              ),
                            ),
                            title: Container(
                              height: 10,
                              width: 80,
                              color: Colors.white,
                            ),
                          )
                        ]),
                      );
                    },
                  );
                } else {
                  List<Search> filteredResults =
                      filterSearchResults(searchController.text);

                  return ListView.builder(
                    itemCount: filteredResults.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        image: snapshot.data![index].image,
                                        title: snapshot.data![index].title,
                                        description:
                                            snapshot.data![index].description,
                                        category:
                                            snapshot.data![index].category,
                                        price: snapshot.data![index].price,
                                      )));
                        },
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image(
                              height: 120,
                              width: 120,
                              image: NetworkImage(
                                filteredResults[index].image,
                              ),
                            ),
                          ),
                          title: Text(filteredResults[index].title),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
