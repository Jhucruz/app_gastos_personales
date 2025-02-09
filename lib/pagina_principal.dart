import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final TextEditingController fecha = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _precio = TextEditingController();

  final List<Map<String, String>> _gastos = [];

  selectedDate() async {
    DateTime? dateSelected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );
    fecha.text = dateSelected.toString().substring(0, 10);
  }

  void _agregarGasto() {
    if (fecha.text.isNotEmpty &&
        _descripcion.text.isNotEmpty &&
        _precio.text.isNotEmpty) {
      setState(() {
        _gastos.add({
          'fecha': fecha.text,
          'descripcion': _descripcion.text,
          'precio': _precio.text,
        });
      });
      fecha.clear();
      _descripcion.clear();
      _precio.clear();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListaGastosPage(
            gastos: _gastos,
            onDelete: (index) {
              setState(() {
                _gastos.removeAt(index);
              });
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Gastos Personales"),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/jhun.png",
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.red,
              ), // Ícono del botón
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (constex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: SizedBox(
                            height: 320,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  controller: fecha,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gapPadding: 16),
                                      labelText: "Fecha "),
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    selectedDate();
                                  },
                                ),
                                TextFormField(
                                  controller: _descripcion,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gapPadding: 16),
                                      labelText: "descripciòn"),
                                ),
                                TextFormField(
                                  controller: _precio,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gapPadding: 16),
                                      labelText: "precio"),
                                ),
                                ElevatedButton(
                                    onPressed: _agregarGasto,
                                    child: Text(
                                      "Agregar",
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      fecha.clear();
                                      _descripcion.clear();
                                      _precio.clear();
                                    },
                                    child: Text(
                                      "reset",
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
        body: Center(
          child: Lottie.asset(
            'assets/animations/Animation01.json',
            repeat: false,
            width: 400,
            height: 400,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

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
