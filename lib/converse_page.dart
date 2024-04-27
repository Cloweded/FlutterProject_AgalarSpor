import 'package:agalarspor/home_page.dart';
import 'package:flutter/material.dart';


class ConversePage extends StatelessWidget {
  final List<Map<String, dynamic>> converseProducts = [
    {
      'name': 'Converse Chuck Taylor All Star',
      'image': 'assets/product_image31.png',
      'price': '\$55'
    },
    {
      'name': 'Converse One Star',
      'image': 'assets/product_image32.png',
      'price': '\$70'
    },
    {
      'name': 'Converse Pro Leather',
      'image': 'assets/product_image33.png',
      'price': '\$80'
    },
    {
      'name': 'Converse Jack Purcell',
      'image': 'assets/product_image34.png',
      'price': '\$65'
    },
    {
      'name': 'Converse All Star Pro BB',
      'image': 'assets/product_image35.png',
      'price': '\$120'
    },
    {
      'name': 'Converse ERX',
      'image': 'assets/product_image36.png',
      'price': '\$95'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Converse"),
        backgroundColor: Color.fromARGB(1, 255, 218, 185), 
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.8, 
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10, 
        ),
        itemCount: converseProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: converseProducts[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                product['image'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product['price'],
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
