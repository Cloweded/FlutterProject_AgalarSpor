import 'package:agalarspor/home_page.dart';
import 'package:flutter/material.dart';


class VansPage extends StatelessWidget {
  final List<Map<String, dynamic>> vansProducts = [
    {
      'name': 'Vans Old Skool',
      'image': 'assets/product_image25.png',
      'price': '\$65'
    },
    {
      'name': 'Vans Sk8-Hi',
      'image': 'assets/product_image26.png',
      'price': '\$75'
    },
    {
      'name': 'Vans Slip-On',
      'image': 'assets/product_image27.png',
      'price': '\$50'
    },
    {
      'name': 'Vans Era',
      'image': 'assets/product_image28.png',
      'price': '\$55'
    },
    {
      'name': 'Vans Authentic',
      'image': 'assets/product_image29.png',
      'price': '\$60'
    },
    {
      'name': 'Vans UltraRange EXO',
      'image': 'assets/product_image30.png',
      'price': '\$85'
    },
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vans"),
        backgroundColor: Color.fromARGB(8, 255, 218, 185), 
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.8, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10, 
        ),
        itemCount: vansProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: vansProducts[index]);
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
