import 'package:app_gastos_personales/ingresar_fecha.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final TextEditingController fechaGastos = TextEditingController();
  final TextEditingController _Descripcion = TextEditingController();
  final TextEditingController _Precio = TextEditingController();
  selectedDate() async {
    DateTime? dateSelected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );
    fechaGastos.text = dateSelected.toString().substring(0, 10);
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
                          child: Container(
                            height: 320,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  controller: fechaGastos,
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
                                  controller: _Descripcion,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gapPadding: 16),
                                      labelText: "Descripciòn"),
                                ),
                                TextFormField(
                                  controller: _Precio,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gapPadding: 16),
                                      labelText: "Precio"),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Agregar",
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      fechaGastos.clear();
                                      _Descripcion.clear();
                                      _Precio.clear();
                                      ;
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
