import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts(); //This Won't Work!
    //Future.delayed(Duration.zero).then((_) {
    //  Provider.of<Products>(context).fetchAndSetProducts();   // This is Hacking way of working!
    //});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Products>(context).fetchAndSetProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Product'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOptions.All,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
