import 'package:flutter/material.dart';

class ListaGastosPage extends StatelessWidget {
  final List<Map<String, String>> gastos;
  final Function(int) onDelete;

  const ListaGastosPage(
      {required this.gastos, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Gastos"),
      ),
      body: ListView.builder(
        itemCount: gastos.length,
        itemBuilder: (context, index) {
          final gasto = gastos[index];
          return Card(
            child: ListTile(
              title: Text('${gasto['descripcion']} - ${gasto['precio']}'),
              subtitle: Text('Fecha: ${gasto['fecha']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => onDelete(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
