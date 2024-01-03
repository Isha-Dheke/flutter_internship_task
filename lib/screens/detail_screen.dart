import 'package:flutter/material.dart';
import 'package:internflutter/modals/product_modal.dart';


class DetailScreen extends StatefulWidget {
  String image, title, description, category;
  double price;
  DetailScreen({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<ProductModal> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Products Details",
              style: TextStyle(
                  fontFamily: 'Dancing Script',
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Image(
                  height: 400, width: 400, image: NetworkImage(widget.image)),
            ),
            Text(
              widget.category.toUpperCase(),
              style:const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.title,
                style:const TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Dancing Script',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.description,
                style:const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(left: 180),
              child: Row(
                children: [
                  const Text(
                    "Price   ",
                    style: TextStyle(
                        fontFamily: 'Dancing Script',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.price.toString(),
                    style:const  TextStyle(
                        fontFamily: 'Dancing Script',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
