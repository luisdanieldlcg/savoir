import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/common/widgets/text_input.dart';
import 'package:savoir/features/auth/controller/auth_controller.dart';
import 'package:savoir/features/profile/widgets/personal_details_header.dart';

class PersonalDetailsView extends ConsumerStatefulWidget {
  final bool firstTime;
  const PersonalDetailsView({
    super.key,
    required this.firstTime,
  });

  static final _genreChoices = ["Femenino", "Masculino", "Otro"];

  @override
  ConsumerState<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends ConsumerState<PersonalDetailsView> {
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _birthDateController;
  final _formKey = GlobalKey<FormState>();
  bool _buttonDisabled = true;
  File? _image;
  DateTime _birthDate = DateTime.now();
  String _selectedGenre = "Masculino";

  @override
  void initState() {
    super.initState();

    if (!widget.firstTime) {
      final user = getUserOrLogOut(ref, context);
      if (user == null) return;
      _nameController = TextEditingController(text: user.firstName);
      _lastNameController = TextEditingController(text: user.lastName);
      _birthDateController = TextEditingController(text: formatDate(user.birthDate));
      _birthDate = user.birthDate;
      _selectedGenre = user.genre;
    } else {
      _nameController = TextEditingController();
      _lastNameController = TextEditingController();
      _birthDateController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> pickBirthDay({
    required BuildContext context,
    required TextEditingController birthDayHandler,
  }) async {
    final DateTime dateToday = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(dateToday.year - 18, dateToday.month, dateToday.day),
      firstDate: DateTime(dateToday.year - 90),
      lastDate: DateTime(dateToday.year - 18, dateToday.month, dateToday.day),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );
    if (date != null) {
      _birthDateController.text = formatDate(date);
      _birthDate = date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppTheme.primaryColor),
      ),
    );
    final loading = ref.watch(authControllerProvider);
    final user = getUserOrLogOut(ref, context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          widget.firstTime ? "Completa tu perfil para continuar" : "Editar Perfil",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: loading
          ? const PulseProgressIndicator()
          : Center(
              child: ListView(
                children: [
                  PersonalDetailsHeader(
                    avatarCallback: () async {
                      final image = await pickGaleryImage();
                      setState(() => _image = image);
                    },
                    avatar: _image != null
                        ? FileImage(_image!)
                        : NetworkImage(
                            user!.profilePicture,
                          ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      onChanged: () {
                        setState(() {
                          _buttonDisabled = !_formKey.currentState!.validate();
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Datos Personales",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text("Nombre(s)", style: TextStyle(fontSize: 16)),
                          TextInput(
                            controller: _nameController,
                            decoration: inputDecoration,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20),
                          Text("Apellido(s)", style: TextStyle(fontSize: 16)),
                          TextInput(
                            keyboardType: TextInputType.text,
                            controller: _lastNameController,
                            decoration: inputDecoration,
                          ),
                          SizedBox(height: 20),
                          Text("Fecha de nacimiento", style: TextStyle(fontSize: 16)),
                          TextInput(
                            controller: _birthDateController,
                            decoration: inputDecoration,
                            keyboardType: TextInputType.datetime,
                            readOnly: true,
                            onTap: () => pickBirthDay(
                              context: context,
                              birthDayHandler: _birthDateController,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Género", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 24),
                          Wrap(
                            children: [
                              for (final genre in PersonalDetailsView._genreChoices)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Theme(
                                    data: ThemeData(), // reset the ThemeData to the default
                                    child: ChoiceChip(
                                      checkmarkColor: Colors.white,
                                      label: Text(genre),
                                      side: BorderSide.none,
                                      selected: _selectedGenre == genre,
                                      selectedColor: AppTheme.primaryColor,
                                      labelStyle: TextStyle(color: Colors.white),
                                      backgroundColor: AppTheme.secondaryColor,
                                      onSelected: (selected) {
                                        setState(() {
                                          _selectedGenre = genre;
                                          _buttonDisabled = !_formKey.currentState!.validate();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              onPressed: _buttonDisabled ? null : () => finish(),
                              child: Text(widget.firstTime ? "Continuar" : "Guardar Cambios"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void finish() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(authControllerProvider.notifier).completeProfile(
          firstName: _nameController.text,
          lastName: _lastNameController.text,
          birthDate: _birthDate,
          genre: _selectedGenre,
          image: _image,
          onSuccess: (updatedUser) {
            if (!mounted) return;
            if (widget.firstTime) {
              Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
            } else {
              ref.read(userProvider.notifier).state = updatedUser;
              Navigator.of(context).pop();
            }
          },
          onError: () {
            errorAlert(
              context: context,
              title: "Algo salió mal",
              text: "Ocurrió un error al completar tu perfil. Por favor, intenta de nuevo.",
            );
          },
        );
  }
}
