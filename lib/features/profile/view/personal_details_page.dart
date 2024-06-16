import 'package:flutter/material.dart';

class PersonalDetailsView extends StatelessWidget {
  const PersonalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Datos Personales",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text("Nombre(s)", style: TextStyle(fontSize: 16)),
              TextField(
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text("Apellido(s)", style: TextStyle(fontSize: 16)),
              TextField(
                decoration: InputDecoration(
                  labelText: "Apellido",
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text("Fecha de nacimiento", style: TextStyle(fontSize: 16)),
              TextField(
                decoration: InputDecoration(
                  labelText: "Correo Electrónico",
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text("Género", style: TextStyle(fontSize: 16)),
              SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {},
                  child: Text("Guardar Cambios"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
