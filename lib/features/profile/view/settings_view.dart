import 'package:flutter/material.dart';
import 'package:savoir/common/widgets/buttons.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _notifications = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("Notificaciones", style: TextStyle(fontSize: 20)),
            SwitchListTile(
              title: Text("Recibir notificaciones"),
              value: _notifications,
              onChanged: (value) => setState(() => _notifications = value),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            Spacer(),
            PrimaryButton(
              onPressed: () {},
              text: "Guardar cambios",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
