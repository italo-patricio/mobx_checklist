import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form_mobx/models/item_model.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel item;
  final Function onRemove;

  const ItemWidget({Key key, this.item, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        title: Text('${item.title}'),
        leading: Checkbox(
          value: item.check,
          onChanged: item.setCheck,
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle),
          color: Colors.red,
          onPressed: onRemove,
        ),
      );
    });
  }
}
