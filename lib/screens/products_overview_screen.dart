import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOption {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOption selectedValue) {
                //print(selectedValue);
                setState(() {
                  if (selectedValue == FilterOption.Favorites) {
                    //productsContainer.showFavoritesOnly();
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                    //productsContainer.showAll();
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text('Only Favorites'),
                        value: FilterOption.Favorites),
                    PopupMenuItem(
                        child: Text('Show All'), value: FilterOption.All),
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              color: Colors.red,
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
