import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_healthy_desktop/presentation/bloc/classification/classification_bloc.dart';
import 'package:she_healthy_desktop/presentation/bloc/classification/classification_event.dart';
import 'package:she_healthy_desktop/presentation/components/image/image_place_holder.dart';

import '../../core/theme/app_primary_theme.dart';
import '../bloc/classification/classification_state.dart';
import '../components/button/primary_button.dart';
import '../components/dialog/dialog_component.dart';
import '../components/dropdown/dropdown_value.dart';
import '../components/dropdown/generic_dropdown.dart';
import '../components/image/image_result.dart';
import 'classification_detail_page.dart';

class CervixClassificationPage extends StatefulWidget {
  final ClassificationBloc bloc;

  const CervixClassificationPage({Key? key, required this.bloc})
      : super(key: key);

  @override
  State<CervixClassificationPage> createState() =>
      _CervixClassificationPageState();
}

class _CervixClassificationPageState extends State<CervixClassificationPage> {
  File? image;
  String selectedItem = initialDataShown;

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (ctx, state) {
        if (state is ShowFailedClassification) {
          Navigator.pop(context);
          showFailedDialog(
              context: context,
              title: "Terjadi Kesalahan",
              message:
                  'Sepertinya ada kesalahan dari server kami, coba lagi nanti!',
              onTap: () {
                Navigator.pop(context);
              });
          return;
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Gambar Sel Serviks',
                    style: AppTheme.subTitle,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 350,
                  child: image != null
                      ? ExploriaImageResult(
                          onTapGallery: () {
                            Navigator.pop(context);
                            pickImageFromGallery();
                          },
                          image: image!,
                          heroTag: '1b')
                      : ImagePlaceHolder(
                          onTapGallery: () {
                            pickImageFromGallery();
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Pastikan gambar jelas.',
                    textAlign: TextAlign.center,
                    style: AppTheme.smallBodyGrey,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Jenis Klasifikasi',
              style: AppTheme.subTitle,
            ),
          ),
          GenericDropdown(
            selectedItem: selectedItem,
            items: classificationItem,
            height: 45,
            width: double.infinity,
            backgroundColor: Colors.white,
            borderColor: Colors.transparent,
            onChanged: (String? value) {
              setState(() {
                selectedItem = value ?? initialDataShown;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: PrimaryButton(
                width: double.infinity,
                context: context,
                isEnabled: true,
                onPressed: () {
                  if (image == null) {
                    showWarningDialog(
                        context: context,
                        title: 'Peringatan',
                        message: 'Gambar tidak boleh kosong!');
                    return;
                  }

                  widget.bloc.add(UploadClassification(file: image!));
                },
                text: 'Analisa'),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Future pickImageFromGallery() async {
    print("Called gallery");
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result != null) {
        image = File(result.files.single.path!);
      } else {
        // User canceled the picker
      }
    });
  }
}
