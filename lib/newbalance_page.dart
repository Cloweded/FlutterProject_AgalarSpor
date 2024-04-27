import 'package:agalarspor/home_page.dart';
import 'package:flutter/material.dart';


class NewBalancePage extends StatelessWidget {
  final List<Map<String, dynamic>> newBalanceProducts = [
    {
      'name': 'New Balance 574',
      'image': 'assets/product_image19.png',
      'price': '\$80'
    },
    {
      'name': 'New Balance 1080',
      'image': 'assets/product_image20.png',
      'price': '\$150'
    },
    {
      'name': 'New Balance Fresh Foam',
      'image': 'assets/product_image21.png',
      'price': '\$120'
    },
    {
      'name': 'New Balance Fresh Foam',
      'image': 'assets/product_image22.png',
      'price': '\$120'
    },
    {
      'name': 'New Balance Fresh Foam',
      'image': 'assets/product_image23.png',
      'price': '\$120'
    },
    {
      'name': 'New Balance Fresh Foam',
      'image': 'assets/product_image24.png',
      'price': '\$120'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Balance"),
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
        itemCount: newBalanceProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: newBalanceProducts[index]);
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
        clipBehavior: Clip.antiAlias, // Kenarları yumuşat
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5, // Gölge derinliği
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
