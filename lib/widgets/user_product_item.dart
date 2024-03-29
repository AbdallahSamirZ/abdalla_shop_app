import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_second_time/providers/products.dart';
import 'package:shop_app_second_time/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String id;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    final scaffold =  Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton (
              icon: Icon(Icons.delete),
              onPressed: () async{
                try {
                  await Provider.of<Products>(context,listen: false).deleteProduct(id);
                } on Exception catch (error) {
                  scaffold.showSnackBar(SnackBar(content: Text('Deleting Failed',textAlign: TextAlign.center,),));
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
