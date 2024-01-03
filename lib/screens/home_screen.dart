import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internflutter/modals/product_modal.dart';
import 'package:http/http.dart' as http;
import 'package:internflutter/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModal> productList = [];

  Future<List<ProductModal>> getProductApi() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        productList = data.map((item) => ProductModal.fromJson(item)).toList();

        return productList;
      } else {
        print('Failed to load products');
        return productList;
      }
    } catch (error) {
      print('Error: $error');
      return productList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[50],
      ),
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(
                                title: 'title',
                                image: 'image',
                                description: 'description',
                                category: 'category',
                                price: productList.isNotEmpty
                                    ? productList[0].price ?? 0.0
                                    : 0.0,
                                
                              )),
                    );
                  },
                  child: Container(
                    width: 500,
                    child:const  Text(
                      "Search Products",
                      style: TextStyle(
                          fontFamily: 'Dancing Script',
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ))),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 10.0,
            children: [
              Container(
                height: 150,
                width: 250,
                color: const Color.fromARGB(255, 245, 212, 223),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Get Exciting Gifts this",
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Dancing Script',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "'NEW YEAR'",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Dancing Script',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "GET free delivery on every purchase",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Dancing Script',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  height: 90,
                  width: 90,
                  color: Colors.white,
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "10%",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Dancing Script',
                          ),
                        ),
                        Text(
                          "OFF",
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Dancing Script',
                          ),
                        )
                      ]),
                ),
              )
            ],
          ),
          Expanded(
            child: FutureBuilder<List<ProductModal>>(
              future: getProductApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No Data"));
                } else {
                  return ListView(
                    children: [
                      // Other widgets before the Wrap
                      Expanded(
                        child: Wrap(
                          spacing: 2.0,
                          alignment: WrapAlignment.center,
                          children: snapshot.data!.map((product) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 270,
                                width: 200,
                                color: const Color.fromARGB(255, 205, 144, 164),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 160,
                                      width: 160,
                                      child: Image.network(
                                          product.image.toString()),
                                    ),
                                    Container(
                                        height: 110,
                                        width: 160,
                                        child: Column(
                                          children: [
                                            Text(
                                              product.title.toString(),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(product.price.toString()),
                                            const Icon(
                                                Icons.favorite_border_outlined)
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // Other widgets after the Wrap
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
