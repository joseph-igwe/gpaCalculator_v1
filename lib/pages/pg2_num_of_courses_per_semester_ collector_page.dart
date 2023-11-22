import 'package:flutter/material.dart';
import 'package:gp_calculator_by_joseph/service_classes/gp_calc_manager.dart';
import 'package:gp_calculator_by_joseph/service_classes/gpa_calculator_UI_service.dart';
import 'package:gp_calculator_by_joseph/pages/pg3_main_gp_calc_page.dart';
import 'package:gp_calculator_by_joseph/strings.dart';




class NumOfCoursesPerSemeseterCollectorPage extends StatelessWidget {
  const NumOfCoursesPerSemeseterCollectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: AppBarHelper().appTitle,),

      body: SingleChildScrollView(
        child: Column(
          // Display The List of the Created Container Cards Created to Collected the Number of
          // courses created in each 
          children:[
            const Padding(
              padding: EdgeInsets.only(top : 15.0),
              child: Text("Fill the Following Fields", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),),
            ),

            const Divider(thickness: 4, color: Colors.black,),

            SizedBox(height: 15,),

            SingleChildScrollView(
              child: Column(
                children: GpaUIservice.list_of_container_fetcher_cards.toList(),
                ),
              ),

            ElevatedButton(
              onPressed:(){
                 // First, Verify that All Container Fetcher Cards Contain valid Integers
                 try{

                  for( // A For Loop,  just to test and confirm that all Container Fetcher Cards contain Valid integers in their input fields and none contains a WhiteSpace
                    int k=0; 
                    k<GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.length; 
                    k++){
                      int temp = int.parse(
                        GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.elementAt(k).text
                      );
                    }


                // Having Successfully Verified that all fields contain valid integers,
                
                // First Clear Whatever may already be in the list of Semester DataTables
                GpaUIservice.list_of_semester_dataTables.clear();

                // And Clear Whatever may already be in the list of all needed for Gp Calc page
                GpaUIservice.list_of_all_needed_4_gp_calc_page.clear();

                
                // THEN  PROCEED TO,

                // Dynamuically Create a List of 'DataTables' one For Each Semester,
                // and the number of Rows fOr that 'DataTable' will be based on
                // the specified number of Courses entered by the user for that Semester of that year
                
                GpaUIservice.create_semester_dataTables_and_their_textEditingControllers();


                // Next Populate the list of all Components needed to be displayed on the Gp calculation page 
                GpaUIservice.populate_list_of_all_needed_4_gp_calc_page();

                
                // Then all is Set So Navigate to page_3 (i.e Main Gp Calc Page)
                Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> const MainGpCalPage() // i.e Page_3
                      ),
                    );


                 }catch(error){
                   showDialog(
                    context: context,
                    builder: (context){
                      return const AlertDialog(title: Text("ERROR: Please Enter a Valid Number in all Fields"),);
                    });
                 }

                
              }, 
              child: const Text("NEXT", style: TextStyle(color: Colors.black),),
            )
          ]
        ),
      ),
    );
  }
}


