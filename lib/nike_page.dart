import 'package:agalarspor/home_page.dart';
import 'package:flutter/material.dart';


class NikePage extends StatelessWidget {
  final List<Map<String, dynamic>> nikeProducts = [
    {
      'name': 'Nike Air Max 270',
      'image': 'assets/product_image0.png',
      'price': '\$150'
    },
    {
      'name': 'Nike Air Force 1',
      'image': 'assets/product_image1.png',
      'price': '\$90'
    },
    {
      'name': 'Nike ZoomX Vaporfly',
      'image': 'assets/product_image2.png',
      'price': '\$250'
    },
    {
      'name': 'Nike ZoomX Vaporfly',
      'image': 'assets/product_image3.png',
      'price': '\$250'
    },
    {
      'name': 'Nike ZoomX Vaporfly',
      'image': 'assets/product_image4.png',
      'price': '\$250'
    },
    {
      'name': 'Nike ZoomX Vaporfly',
      'image': 'assets/product_image5.png',
      'price': '\$250'
    },
    {
      'name': 'Nike ZoomX Vaporfly',
      'image': 'assets/product_image6.png',
      'price': '\$250'
    },

 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nike"),
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
        itemCount: nikeProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: nikeProducts[index]);
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
