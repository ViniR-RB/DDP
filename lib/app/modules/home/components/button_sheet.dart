import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/components/custom_input.dart';

import '../home_controller.dart';

abstract class CustomButtonSheetContact {
  static Future showModalBottomSheetCustom(
      BuildContext context, HomeController controller) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addresController = TextEditingController();

    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
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
                          'Cria Contato',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: 100,
                        height: 42,
                        child: ElevatedButton(
                            onPressed: () => controller.createContact(
                                nameController.text,
                                phoneController.text,
                                addresController.text),
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
                        labelText: 'Insira o Endereço do Contato',
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
