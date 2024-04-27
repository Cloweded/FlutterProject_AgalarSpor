import 'package:agalarspor/home_page.dart';
import 'package:flutter/material.dart';


class AdidasPage extends StatelessWidget {
  final List<Map<String, dynamic>> adidasProducts = [
    {
      'name': 'Adidas Ultra Boost',
      'image': 'assets/product_image7.png',
      'price': '\$180'
    },
    {'name': 'Adidas NMD', 'image': 'product_image8.png', 'price': '\$130'},
    {'name': 'Adidas Yeezy', 'image': 'product_image9.png', 'price': '\$220'},
    {'name': 'Adidas Yeezy', 'image': 'product_image10.png', 'price': '\$220'},
    {'name': 'Adidas Yeezy', 'image': 'product_image11.png', 'price': '\$220'},
    {'name': 'Adidas Yeezy', 'image': 'product_image12.png', 'price': '\$220'},

   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adidas"),
        backgroundColor: Color.fromARGB(0, 255, 218, 185), 
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.8, 
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10, 
        ),
        itemCount: adidasProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: adidasProducts[index]);
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
