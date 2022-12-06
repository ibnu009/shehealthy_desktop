import 'package:flutter/material.dart';
import 'package:she_healthy_desktop/presentation/pages/cervix_classification_page.dart';
import 'package:she_healthy_desktop/presentation/pages/classification_detail_page.dart';

import '../../core/theme/app_primary_theme.dart';
import '../bloc/classification/classification_bloc.dart';
import '../components/appbar/custom_generic_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClassificationBloc bloc = ClassificationBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: HomeAppBar(
                  url: '',
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.only(left: 16),
                          child: CervixClassificationPage(
                            bloc: bloc,
                          ))),
                  Expanded(
                      flex: 7,
                      child: ClassificationDetailPage(
                        bloc: bloc,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
