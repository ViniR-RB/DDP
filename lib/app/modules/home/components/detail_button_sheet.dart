import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/components/custom_input.dart';
import 'package:maps/app/core/models/contact.dart';
import 'package:maps/app/core/services/geocoding.dart';

import '../../../core/components/custom_snackbar.dart';
import '../home_controller.dart';

abstract class CustomButtonSheetDetail {
  static Future showModalBottomSheetDetail(
    BuildContext context,
    HomeController controller, {
    String? initialid,
    String? initialName,
    String? initialPhone,
    String? initialAddress,
  }) async {
    final TextEditingController nameController =
        TextEditingController(text: initialName);
    final TextEditingController phoneController =
        TextEditingController(text: initialPhone);
    final TextEditingController addresController =
        TextEditingController(text: initialAddress);
    GeoCodingService geoCoding = GeoCodingService();
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.2,
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Modular.to.pop(),
                            ),
                            const Text(
                              'Atualiza Contato',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: 100,
                            height: 42,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final locations = await geoCoding
                                      .searchFromAddress(addresController.text);
                                 final Contact updatedContact = await controller
                                      .detailContact(initialid!);
                                  final newContact = updatedContact.copyWith(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      addres: addresController.text,
                                      latitude: locations!['latitude']!,
                                      longitude: locations['longitude']!);
                                  await controller.repository
                                      .updateContact(newContact);
                                  // ignore: use_build_context_synchronously
                                  CustomSnackBar.showSnackBar(context,
                                      'Usuário atualizado com sucesso');
                                  Modular.to.pop();
                                },
                                child: const Text('Salvar'))),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomInput(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            labelText: 'Nome do Contato',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomInput(
                            controller: phoneController,
                            keyboardType: TextInputType.name,
                            labelText: 'Telefone',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomInput(
                            controller: addresController,
                            keyboardType: TextInputType.streetAddress,
                            labelText: 'Endereço do Contato',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
