import 'package:flutter/material.dart';
import 'package:gp_calculator_by_joseph/service_classes/gpa_calculator_UI_service.dart';
import 'package:gp_calculator_by_joseph/strings.dart';



class MainGpCalPage extends StatelessWidget {
  const MainGpCalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  AppBarHelper().appTitle,),
      body: SingleChildScrollView(
        child: Column(
          children: GpaUIservice.list_of_all_needed_4_gp_calc_page.toList()
        ),
      ),
    );
  }
}