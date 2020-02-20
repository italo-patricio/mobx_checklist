import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form_mobx/controller.dart';
import 'package:form_mobx/widgets/item_widget.dart';

import 'models/item_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Controller();

  _dialog() {
    var model = ItemModel();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Adicionar item'),
            content: TextField(
              onChanged: model.setTitle,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Novo item'),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  controller.addItem(model);
                  Navigator.of(context).pop();
                },
                child: Text('Salvar'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: InputDecoration(hintText: "Pesquisa..."),
        ),
        actions: <Widget>[
          IconButton(
              icon: Observer(builder: (_) {
                return Text('${controller.totalChecked}');
              }),
              onPressed: () {})
        ],
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: controller.listFiltered.length,
          itemBuilder: (_, index) {
            var item = controller.listFiltered[index];
            return ItemWidget(
              item: item,
              onRemove: () {
                controller.removeItem(item);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
