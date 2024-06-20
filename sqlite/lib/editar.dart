import 'package:flutter/material.dart';
import 'package:sqlite/animal.dart';
import 'package:sqlite/db.dart';

class Editar extends StatefulWidget {
  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreController;
  late TextEditingController especieController;
  late Animal animal;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    especieController = TextEditingController();
  }

  @override
  void dispose() {
    nombreController.dispose();
    especieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animal = ModalRoute.of(context)!.settings.arguments as Animal;
    nombreController.text = animal.nombre;
    especieController.text = animal.especie;

    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                validator: (value) {
                  if (value!.isEmpty) return "El nombre es obligatorio";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nombre",
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: especieController,
                validator: (value) {
                  if (value!.isEmpty) return "La especie es obligatoria";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Especie",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (animal.id != null && animal.id! > 0) {
                      animal.nombre = nombreController.text;
                      animal.especie = especieController.text;
                      DB.update(animal);
                    } else {
                      DB.insert(Animal(
                        nombre: nombreController.text,
                        especie: especieController.text,
                      ));
                    }
                    Navigator.pop(context, true);
                  }
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}