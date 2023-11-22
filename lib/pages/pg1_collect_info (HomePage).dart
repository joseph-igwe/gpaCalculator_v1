import 'package:flutter/material.dart';
import 'package:gp_calculator_by_joseph/pages/pg2_num_of_courses_per_semester_ collector_page.dart';
import 'package:gp_calculator_by_joseph/service_classes/gp_calc_manager.dart';
import 'package:gp_calculator_by_joseph/service_classes/gpa_calculator_UI_service.dart';


class NeededDataCollectionPage extends StatefulWidget {

  NeededDataCollectionPage({super.key});

  @override
  State<NeededDataCollectionPage> createState() => _NeededDataCollectionPageState();
} // END of Widget Class


class _NeededDataCollectionPageState extends State<NeededDataCollectionPage> {
  TextEditingController current_user_name = TextEditingController();

  TextEditingController current_user_years_studied  = TextEditingController();


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GpA calculator by Joseph", style: TextStyle(color:Colors.black),),
      ),
      drawer: Drawer(backgroundColor: Colors.green.shade400, width: 250,),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),

            child: Column(
              mainAxisSize: MainAxisSize.max,

              children: [

              const Text(
                "Please Fill the Form below to Calculate your GpA and CGpA",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
                ),

              const SizedBox(height: 30,),

              const Divider(thickness: 5,height: 3, color: Colors.black,),

              const SizedBox(height: 60,),

              const Text.rich(
                         TextSpan(
                              text:"Enter Your Name", style:  TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                              children: [
                                      TextSpan(
                                        text: "(Optional)", style:  TextStyle(fontWeight: FontWeight.w500)
                                   )
                              ]
                         )
              ),
              TextField(
                controller: current_user_name, 
                decoration:  const InputDecoration(
                                           disabledBorder: OutlineInputBorder( 
                                                                borderSide: BorderSide(color:Colors.black,  width: 20.0)),
                                           border:         OutlineInputBorder(
                                                                borderSide: BorderSide(color:Colors.black,  width: 20.0)
                                           )),
                ),
              
              const SizedBox(height: 60,),
          
              const Text("If you are done with school,Enter                     \n", style: TextStyle(fontSize:18, fontWeight: FontWeight.w500),),
              
              const Text(
                ">> How many Years was the Course you studied ?\n",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              
              const Text("But, If you are still a student          \n",style: TextStyle(fontSize:18, fontWeight: FontWeight.w500),),
              
              const Text(
                ">>Enter The Number of Years you have Studied so Far ",
                 style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              TextField( // TextField for Number of Years Studied(or Studied So Far)
                controller: current_user_years_studied,
                keyboardType: TextInputType.number, 
                decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                  ),
                ),

              const SizedBox(height: 60,),
              
              ElevatedButton(
                onPressed: (){
                 // GpaCalcService.current_user_name = current_user_name.text;
                  // Set the value of the 'course_duration' property in the GpaCalc class
                  // to the value passed in by the current user
                 try{
                  GpCalcManager.course_duration = int.parse(current_user_years_studied.text);
                  
                  // Based on the course duration(or number of years Studied) entererd by the user,
                  // Create and ADD the appropriate number of Container Fetcher cards into the List .

                  // First Clear Any Existing Content in the Lists before adding New Stuff
                  GpaUIservice.list_of_container_fetcher_cards.clear();
                  GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.clear();
                  

                  // Then add the Necessary number of Container Fetcher Cards as well as 
                  // a TextEditing Controller For Each Container Fetcher Card
                  GpaUIservice.add_needed_container_fetcher_cards();


                  // Then after doing that, Navigate to the Next Page (pg 2) 
                  // where the user will then enter number of course done in each semester
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> const NumOfCoursesPerSemeseterCollectorPage()
                      ),
                    );

                 }catch(error){
                  showDialog(
                    context: context, 
                    builder: (context){
                      return const AlertDialog(title: Text("Invalid Course Duration, Please enter a valid Number"),); 
                      }
                    );
                 }
                }, 
                child: const Text("NEXT", style:  TextStyle(color: Colors.black87),
                   ),
                ),

                SizedBox(height: 30,)

              ],
            ),
          ),
        ),
      )
    );
  }
}

