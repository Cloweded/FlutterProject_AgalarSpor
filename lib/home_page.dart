import 'package:agalarspor/adidas_page.dart';
import 'package:agalarspor/converse_page.dart';
import 'package:agalarspor/newbalance_page.dart';
import 'package:agalarspor/nike_page.dart';
import 'package:agalarspor/notifications.dart';
import 'package:agalarspor/puma_page.dart';
import 'package:agalarspor/shopping_cart.dart';
import 'package:agalarspor/theme_model.dart';
import 'package:agalarspor/vans_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agalarstore',
        theme: theme.theme,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> products = List.generate(
    36,
    (index) {
    
      List<String> categories = [
        'Nike',
        'Nike',
        'Nike',
        'Nike',
        'Nike',
        'Nike',
        "Nike",
        "Adidas",
        "Adidas",
        "Adidas",
        "Adidas",
        "Adidas",
        "Adidas",
        "Puma",
        "Puma",
        "Puma",
        "Puma",
        "Puma",
        "Puma",
        "New Balance",
        "New Balance",
        "New Balance",
        "New Balance",
        "New Balance",
        "New Balance",
        "Vans",
        "Vans",
        "Vans",
        "Vans",
        "Vans",
        "Vans",
        "Converse",
        "Converse",
        "Converse",
        "Converse",
        "Converse",
        "Converse",
      ];
      List<String> productNames = [
        'One Blue Mid',
        'Air 180',
        'One Orange Mid',
        'One Classic Red',
        'One TYRX Mid',
        'Dunk Blue-White',
        "Dunk Yellow-Black",
        "SAMBA",
        "One Tap Green ",
        "Yeezy Vultures",
        "One Tap Red Prestige",
        "Red Dead",
        "Campus Istinye Edition",
        "Roaar",
        "Lion",
        "Cat",
        "Panda Buy Panda",
        "Fenerbahce",
        "1907",
        "Starship",
        "Doja Cat",
        "The Weeknd",
        "Sagopa Kjmr",
        "WRLD",
        "ppsmoke",
        "WeDontTrustYou",
        "WeStillDontTrustYou",
        "AGALARSPOR",
        "BTW",
        "Crazy World",
        "dojdojdoj",
        "gunna",
        "life is good",
        "trscoottttt",
        "3000 times",
        "loveu",
        "DilxBah est2022",
      ];
      int categoryIndex =
          index % categories.length; 
      return {
        'name':
            '${categories[categoryIndex]} ${productNames[categoryIndex]} $index',
        'price': '\$${(index + 1) * 3}',
        'image': 'assets/product_image$index.png',
      };
    },
  );

  void navigateToProductDetail(
      BuildContext context, Map<String, dynamic> product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ProductDetailPage(product: product),
    ));
  }

  void _requestNotificationPermission(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Permissions'),
          content: Text('Do you allow this app to send you notifications?'),
          actions: <Widget>[
            TextButton(
              child: Text('Deny'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Allow'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => NotificationsPage()));
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 1:
        _requestNotificationPermission(context);
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ShoppingPage()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () =>
                Provider.of<ThemeModel>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            expandedHeight: 120.0,
            backgroundColor: Color.fromARGB(0, 255, 218, 185),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double top = constraints.biggest.height - 56;
                return Stack(
                  children: [
                    Positioned(
                      top: top / 2 - 10,
                      left: MediaQuery.of(context).size.width / 2 - 40,
                      child: Image.asset('assets/agalar3.png', height: 70),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BrandButton(
                      brandAsset: 'assets/nike_logo.png',
                      onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => NikePage()))),
                  BrandButton(
                      brandAsset: 'assets/adidas_logo.png',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AdidasPage()))),
                  BrandButton(
                      brandAsset: 'assets/puma_logo.png',
                      onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => PumaPage()))),
                  BrandButton(
                      brandAsset: 'assets/newbalance_logo.png',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => NewBalancePage()))),
                  BrandButton(
                      brandAsset: 'assets/vans_logo.png',
                      onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => VansPage()))),
                  BrandButton(
                      brandAsset: 'assets/converse_logo.png',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ConversePage()))),
                ],
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => navigateToProductDetail(context, product),
                  child: ProductCard(
                    productName: product['name'],
                    productPrice: product['price'],
                    productImage: product['image'],
                  ),
                );
              },
              childCount: products.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Shopping Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 37, 161, 233),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class BrandButton extends StatelessWidget {
  final String brandAsset;
  final VoidCallback onPressed;

  const BrandButton({
    Key? key,
    required this.brandAsset,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          side: BorderSide(color: Color(0xFFFFDAB9)),
        ),
        onPressed: onPressed,
        child: Image.asset(brandAsset, width: 50),
      ),
    );
  }
}


class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSizeIndex = 0;
  List<String> sizes = ['40', '41', '42', '43', '44', '45', '46'];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']),
        backgroundColor: Color.fromARGB(0, 37, 161, 233),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 211, 210, 210).withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(widget.product['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name'],
                    style: theme.textTheme.headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.product['price'],
                    style: theme.textTheme.headline6!
                        .copyWith(color: theme.colorScheme.secondary),
                  ),
                  SizedBox(height: 16),
                  DropdownButton<String>(
                    value: sizes[selectedSizeIndex],
                    onChanged: (newValue) {
                      setState(() {
                        selectedSizeIndex = sizes.indexOf(newValue!);
                      });
                    },
                    items: sizes.map((size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      ShoppingCart.addItem(widget.product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${widget.product['name']} added to cart!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                    label: Text('Add to Cart', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Product Description",
                    style: theme.textTheme.headline6,
                  ),
                  Text(
                    "This is a placeholder text for the product description. It can include details about the material, dimensions, care instructions, and more.",
                    style: theme.textTheme.bodyText2,
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


class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8, 
      shadowColor: Colors.grey.withOpacity(0.5), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: 'product-hero-${productName}',
              child: Image.asset(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black, 
                  ),
                ),
                Text(
                  productPrice,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
