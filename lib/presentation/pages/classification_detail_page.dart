import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_healthy_desktop/presentation/bloc/classification/classification_event.dart';
import 'package:she_healthy_desktop/presentation/components/generic/loading_widget.dart';
import 'package:she_healthy_desktop/presentation/components/text/generic_radius_text_container.dart';
import 'package:she_healthy_desktop/utils/string_ext.dart';

import '../../core/theme/app_primary_theme.dart';
import '../bloc/classification/classification_bloc.dart';
import '../bloc/classification/classification_state.dart';
import '../components/button/primary_button.dart';
import '../components/dialog/dialog_component.dart';
import '../components/image/image_place_holder_static.dart';

const noAssumption = 'Belum ada asumsi';

//Sebagai place holder
const nullData = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null];

class ClassificationDetailPage extends StatefulWidget {
  final ClassificationBloc bloc;

  const ClassificationDetailPage({Key? key, required this.bloc})
      : super(key: key);

  @override
  State<ClassificationDetailPage> createState() =>
      _ClassificationDetailPageState();
}

class _ClassificationDetailPageState extends State<ClassificationDetailPage> {
  final List<String> _data = [];

  @override
  void initState() {
    super.initState();
  }

  Widget blocBuilder() {
    return BlocBuilder(
      bloc: widget.bloc,
      builder: (ctx, state) {
        if (state is ShowSuccessClassification) {
          _data.clear();
          _data.addAll(state.data.split(','));
          return buildBody(_data, state.assumption, state.image, 'CNN' ,false);
        }

        if (state is ShowLoading) {
          return buildBody( nullData ,noAssumption, null, null, true);
        }

        return buildBody(nullData, noAssumption, null, null, false);
      },
    );
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (ctx, state) {
        if (state is ShowFailedClassification) {
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
    return blocListener(child: blocBuilder());
  }

  Widget buildBody(List<String?> data, String assumption, File? image, String? method, bool isLoading) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'GLCM Properties',
                              style: AppTheme.subTitle,
                            ),
                          ),
                          buildTableGLCM(data),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Gambar Sel Serviks GLCM',
                            style: AppTheme.subTitle,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 350,
                          width: 250,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: image == null
                                  ? const ImagePlaceHolderStatic()
                                  : Image.file(
                                image,
                                fit: BoxFit.cover,
                                color: Colors.grey,
                                colorBlendMode: BlendMode.color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Kesimpulan Analisa',
                  style: AppTheme.subTitle,
                ),
              ),
              buildKesimpulan(assumption, method),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding : const EdgeInsets.symmetric( vertical: 16),
                child: PrimaryButton(
                    width: double.infinity,
                    color: Colors.redAccent,
                    context: context, isEnabled: true, onPressed: (){
                  widget.bloc.add(ResetClassification());

                }, text: 'Reset'),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
        Visibility(
            visible: isLoading,
            child: const Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: LoadingWidget()))
      ],
    );
  }

  Widget buildKesimpulan(String? assumption, String? method) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Hasil analisa sel serviks dengan metode ${method ?? '-'}',
                style: AppTheme.smallBodyGrey.copyWith(color: Colors.black87),
              ),
            ],
          ),
          const Spacer(),
          GenericRadiusTextContainer(
              text: assumption ?? noAssumption,
              hMargin: 4,
              radius: 32,
              width: MediaQuery.of(context).size.width * 0.2,
              color: assumption == noAssumption ? Colors.grey :
              assumption == 'NORMAL' ? Colors.green : Colors.red),
        ],
      ),
    );
  }


  Widget buildTableGLCM(List<String?> data) {
    debugPrint('Dissimilarity ${data[4]}, ${data[5]}, ${data[6]}, ${data[7]}}');

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,

      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black38),
            ),
            children: [
              rowTextHeading('Properties'),
              rowTextHeading('0\u00B0'),
              rowTextHeading('45\u00B0'),
              rowTextHeading('90\u00B0'),
              rowTextHeading('135\u00B0'),
            ]),
        buildDataRow('Contrast', data[0], data[1], data[2], data[3]),
        buildDataRow('Dissimilarity', data[4], data[5], data[6], data[7]),
        buildDataRow('Homogeneity', data[8], data[9], data[10], data[11]),
        buildDataRow('Energy', data[12], data[13], data[14], data[15]),
      ],
    );
  }

  TableRow buildDataRow(
      String property, String? val1, String? val2, String? val3, String? val4) {
    return TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(property,
                style: const TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ),
          Text(val1.removeChars() ?? '-', textAlign: TextAlign.center),
          Text(val2.removeChars() ?? '-', textAlign: TextAlign.center),
          Text(val3.removeChars() ?? '-', textAlign: TextAlign.center),
          Text(val4.removeChars() ?? '-', textAlign: TextAlign.center),
        ]);
  }

  Widget rowText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  Widget rowTextHeading(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
