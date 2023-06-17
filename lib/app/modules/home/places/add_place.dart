import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/home/places/place_controller.dart';

import '../../../core/components/custom_snackbar.dart';

class AddFavoritePlace extends StatefulWidget {
  const AddFavoritePlace({super.key});

  @override
  State<AddFavoritePlace> createState() => _AddFavoritePlaceState();
}

class _AddFavoritePlaceState extends State<AddFavoritePlace> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameInput = TextEditingController();
  TextEditingController phoneInput = TextEditingController();
  TextEditingController addressdInput = TextEditingController();
  TextEditingController socialmidiaInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  final _controller = Modular.get<PlacesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Adicionar Lugares Favoritos'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/favplace.jpg'),
                  radius: 73,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Adicione seu lugar favorito',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameInput,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'Por favor, preencha o campo com o nome do lugar.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Nome do lugar',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneInput,
                        keyboardType: TextInputType.phone,
                        validator: (phone) {
                          if (phone == null || phone.isEmpty) {
                            return 'Por favor, preencha o campo com o nome do lugar.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Telefone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: addressdInput,
                        keyboardType: TextInputType.streetAddress,
                        validator: (address) {
                          if (address == null || address.isEmpty) {
                            return 'Por favor, preencha o campo com o nome do lugar.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Endereço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: socialmidiaInput,
                        decoration: InputDecoration(
                          labelText: 'Rede social (opcional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: descriptionInput,
                        decoration: InputDecoration(
                          labelText: 'Descreva esse lugar (opcional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (_formkey.currentState!.validate()) {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            await _controller.createPlace(
                              nameInput.text,
                              phoneInput.text,
                              addressdInput.text,
                              socialmidiaInput.text,
                              descriptionInput.text,
                            );
                            await _controller.fetchPlaces();
                            // ignore: use_build_context_synchronously
                            CustomSnackBar.showSnackBar(
                                context, 'Usuário inserido com sucesso');
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Cadastro não realizado, tente novamente",
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.pink,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
