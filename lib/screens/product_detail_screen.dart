import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;
  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is a ID
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(loadedProduct.title),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(
                loadedProduct.title,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: 10,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(
                // color: Colors.black,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'About Product',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 800,
            ),
          ])),
        ],
      ),
    );
  }
}
