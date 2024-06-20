import 'package:flutter/material.dart';
import 'package:sqlite/animal.dart';
import 'package:sqlite/db.dart';

class Listado extends StatefulWidget {
  @override
  _ListadoState createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  List<Animal> animales = [];

  @override
  void initState() {
    super.initState();
    cargaAnimales();
  }

  Future<void> cargaAnimales() async {
    List<Animal> auxAnimales = await DB.animales();
    setState(() {
      animales = auxAnimales;
    });
  }

  void eliminarAnimal(Animal animal) {
    DB.delete(animal);
    setState(() {
      animales.remove(animal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animales"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/editar", arguments: Animal(id: 0, nombre: "", especie: ""))
              .then((_) => cargaAnimales());
        },
      ),
      body: ListView.builder(
        itemCount: animales.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(animales[index].nombre),
            subtitle: Text(animales[index].especie),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(context, "/editar", arguments: animales[index])
                        .then((_) => cargaAnimales());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmar Eliminación"),
                          content: Text("¿Estás seguro de eliminar ${animales[index].nombre}?"),
                          actions: [
                            TextButton(
                              child: Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Eliminar"),
                              onPressed: () {
                                eliminarAnimal(animales[index]);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}