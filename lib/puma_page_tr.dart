import 'package:agalarspor/home_page_tr.dart';
import 'package:flutter/material.dart';


class PumaPageTR extends StatelessWidget {
  final List<Map<String, dynamic>> pumaProducts = [
    {
      'name': 'Puma RS-X',
      'image': 'assets/product_image13.png',
      'price': '\$110'
    },
    {
      'name': 'Puma Future Rider',
      'image': 'assets/product_image14.png',
      'price': '\$80'
    },
    {
      'name': 'Puma Suede Classic',
      'image': 'assets/product_image15.png',
      'price': '\$70'
    },
    {
      'name': 'Puma Suede Classic',
      'image': 'assets/product_image16.png',
      'price': '\$70'
    },
    {
      'name': 'Puma Suede Classic',
      'image': 'assets/product_image17.png',
      'price': '\$70'
    },
    {
      'name': 'Puma Suede Classic',
      'image': 'assets/product_image18.png',
      'price': '\$70'
    },
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Puma"),
        backgroundColor: Color.fromARGB(14, 255, 218, 185), 
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.8, 
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10, 
        ),
        itemCount: pumaProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: pumaProducts[index]);
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
