import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/components/custom_input.dart';
import 'package:maps/app/core/models/fav_place.dart';

import 'package:maps/app/core/services/geocoding.dart';
import 'package:maps/app/modules/home/places/place_controller.dart';
import '../../../core/components/custom_snackbar.dart';

abstract class CustomButtonSheetPlaceDetail {
  static Future showModalBottomSheetDetail(
    BuildContext context,
    PlacesController controller, {
    String? initialid,
    String? initialName,
    String? initialPhone,
    String? initialAddress,
    String? initialsocialmidia,
    String? initialdescription,
  }) async {
    final TextEditingController nameController =
        TextEditingController(text: initialName);
    final TextEditingController phoneController =
        TextEditingController(text: initialPhone);
    final TextEditingController addresController =
        TextEditingController(text: initialAddress);
    final TextEditingController socialmidiaController =
        TextEditingController(text: initialsocialmidia);
    final TextEditingController descriptionController =
        TextEditingController(text: initialdescription);
    GeoCodingService geoCoding = GeoCodingService();
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.1,
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
                              'Atualiza Lugar favorito',
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
                                  FavoritePlace? updatedPlace =
                                      await controller.detailPlace(initialid!);
                                  updatedPlace?.name = nameController.text;
                                  updatedPlace?.phone = phoneController.text;
                                  updatedPlace?.address = addresController.text;
                                  updatedPlace?.socialmidia =
                                      socialmidiaController.text;
                                  updatedPlace?.description =
                                      descriptionController.text;
                                  updatedPlace?.latitude =
                                      locations!['latitude'];
                                  updatedPlace?.longitude =
                                      locations!['longitude'];
                                  await controller.repository
                                      .updatePlace(updatedPlace!);
                                  // ignore: use_build_context_synchronously
                                  CustomSnackBar.showSnackBar(context,
                                      'Lugar favorito atualizado com sucesso!');
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
                            labelText: 'Nome do Lugar',
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomInput(
                            controller: socialmidiaController,
                            keyboardType: TextInputType.streetAddress,
                            labelText: 'Rede social',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomInput(
                            controller: descriptionController,
                            keyboardType: TextInputType.streetAddress,
                            labelText: 'Descrição desse lugar',
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