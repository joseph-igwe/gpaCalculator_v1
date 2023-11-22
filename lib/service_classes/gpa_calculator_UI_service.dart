// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:gp_calculator_by_joseph/service_classes/gp_calc_manager.dart';
import 'package:gp_calculator_by_joseph/pages/pg2_num_of_courses_per_semester_ collector_page.dart';


class GpaUIservice{

  // NB: "c_fetcher_card"  = container_fetcher_card

  static Set<NumOfCoursesPerSemesterFetcherContainer>     list_of_container_fetcher_cards = {}; 
  static Set<TextEditingController>                       list_of_TextEditing_controllers_for_each_container_fetcher_card = { /* TextEditingController(), TextEditingController() */};
  static Set<DataTable>                                   list_of_semester_dataTables = { /* DataTable() , DataTable( ), ...*/};
  static Set<Widget>                                    list_of_all_needed_4_gp_calc_page = {};
  static List<List<Map<String,TextEditingController>>>    list_of_lists_with_maps_of_txtEdt_cntrlrz = [
    /* 
      [  
         [ {"score":TexEditingController(), "unitLoad":TextEditingController()}] , 
         [ {"score":TexEditingController(), "unitLoad":TextEditingController()} ]  ,
         ...
         ...
         ...
       ] 
    */
    ];

  static void add_needed_container_fetcher_cards(){
    // Create and Add the Appropriate number of "Container Fetcher Cards"
    // as well as a 'TextEditingController' for each Container Fetcher Card added
    //   
    // A card will be only, ONLY IF it does not already
    // exist in the List/Set
    int level_tracker = 1;

    for(int i=0; i< GpCalcManager.course_duration*2; i++){
                     

                        // Add a TextEditing Controller For the 'Container Fetcher Card' that was just added
                        GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.add(
                             new TextEditingController()
                        );


                      if(i%2 != 0){ // if "i"  is odd
                            GpaUIservice.list_of_container_fetcher_cards.add(
                            NumOfCoursesPerSemesterFetcherContainer( level: (level_tracker)*100,  semester: "2nd",
                            numOfCoursesController: GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.elementAt(i),)
                        );
                        level_tracker += 1;

                      } else{ // else if "i"  even
                            GpaUIservice.list_of_container_fetcher_cards.add(
                            NumOfCoursesPerSemesterFetcherContainer( level: (level_tracker)*100,  semester: "1st",
                            numOfCoursesController: GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.elementAt(i),)
                        );
                      }

                }
       } // add_needed_container_fetcher_cards()


       static void  create_semester_dataTables_and_their_textEditingControllers(){

          // First Clear any Existing Data in the following Lists/Sets
          GpaUIservice.list_of_semester_dataTables.clear();
          GpaUIservice.list_of_lists_with_maps_of_txtEdt_cntrlrz.clear();

          // Iterate as many times as there are elements in the list 'GpaUIservice.list_Of_container_fetcher_cards'
          for(int i=0; i<GpaUIservice.list_of_container_fetcher_cards.length; i++)
          {
             DataTable?  tempdataTable;  // Declare a temporary DataTable which will hold the dataTable for a current Semester unitl it is added into the list "GpaUIservice.list_of"
             List<Map<String,TextEditingController>> temp_list_of_maps_of_txtEdt_Cntrlrz = [];  // Create a List that will temporarily hold maps which will hold the TextEditing Controllers for the 'Score'  and  'UnitLoad' cell of each table
             List<DataRow> temp_list_of_dataRows = [];  // Create a temporary List to hold the DataRows that will be created for a given Semester DataTable until it is added into that DataTable
             
             // For each Container Fetcher Card, Iterate as many times as the number of Courses
             // entered to have been done in that semester
             for(
              int j=0; 
              j < int.parse(GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.elementAt(i).text);
              j++){
                Map<String, TextEditingController> temp_map_of_txtEdt_cntrlrz = {};

                temp_map_of_txtEdt_cntrlrz["score"] = TextEditingController();
                temp_map_of_txtEdt_cntrlrz["unitLoad"] = TextEditingController();

                temp_list_of_maps_of_txtEdt_Cntrlrz.add(temp_map_of_txtEdt_cntrlrz);

                DataRow tempDataRow = DataRow(
                  cells: [
                    DataCell(Text("${j+1}")),
                    DataCell(TextField(controller: temp_list_of_maps_of_txtEdt_Cntrlrz[j]["score"],)),
                    DataCell(TextField(controller: temp_list_of_maps_of_txtEdt_Cntrlrz[j]["unitLoad"],))
                  ]
                  );

                  temp_list_of_dataRows.add(tempDataRow);
              } // END OF INNER LOOP

              tempdataTable = DataTable(
                border: const TableBorder(
                  left: BorderSide(width: 4, color: Colors.black), 
                  right:BorderSide(width: 4, color: Colors.black) , 
                  top: BorderSide(width: 4, color: Colors.black), 
                  bottom: BorderSide(width: 4, color: Colors.black),
                  verticalInside: BorderSide(width: 3, color: Colors.black),
                  horizontalInside: BorderSide(width: 3, color: Colors.black)),
                dividerThickness: 5.0,
                columns: const [ DataColumn(label: Text("index")),  DataColumn(label: Text("Score")),  DataColumn(label: Text("Unit Load")) ], 
                rows: temp_list_of_dataRows // set the DataRows of the Table to be the DataRows Created in the iteration of the Inner loop
                );

                
                // Finally Add the DataTable Created to the List of DataTables for each Semester
                GpaUIservice.list_of_semester_dataTables.add(tempdataTable);

                // And the List of Holding the Maps containing TextEditing Controllers for each cells of each row
                // to the list 'GpaUIservice.list_Of_lists_with_maps_of_txtEdt_cntrlrz
                GpaUIservice.list_of_lists_with_maps_of_txtEdt_cntrlrz.add(temp_list_of_maps_of_txtEdt_Cntrlrz);
          
          } // END OF OUTTER LOOP
       
       } // create_semester_dataTables_and_their_textEditingControllers()


       static void populate_list_of_all_needed_4_gp_calc_page(){
           int level_counter = 1;
           
             GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                const SizedBox(height: 5,)
              );

           for( int i = 0; i< GpaUIservice.list_of_semester_dataTables.length; i++){
              
              if( i%2 != 0)
              { // if "i" is odd e.g 1, 3, ..etc

                  if(i == 0)  // if it is the First Iteration, Wrap the First 'Enter Your <level> level Results' With Padding
                  {
                     GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                     Padding(
                       padding: const EdgeInsets.only(top: 15.0),
                       child: Text("Enter Your ${level_counter * 100} level 2nd Semester Results", style: const TextStyle(fontWeight: FontWeight.w900),),
                            )
                         );
                  } else
                  {
                       GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                       Text("Enter Your ${level_counter * 100} level 2nd Semester Results", style: const TextStyle(fontWeight: FontWeight.w900),)
                             );
                  } // ELSE BLOCK OF INNER IF (if "i" == 0)
                //  level_counter += 1;  

              } else  // ELSE  OF THE OUTTER IF
              { // else if "i"  is even e.g 0, 1, ..etc
                 GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                  Text("Enter Your ${level_counter * 100} level 1st Semester Results", style: const TextStyle(fontWeight: FontWeight.w900),)
                );
              }


              GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                const SizedBox(height: 5,)
              );


              GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                InteractiveViewer(
                  child: GpaUIservice.list_of_semester_dataTables.elementAt(i)
                  )
              );


              GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                SemesterGpaCalcCard(i)
              );


              if( i%2 != 0 ){ // if "i"  is Odd and it has just added a  'SecondSemesterCalcCard'
                 
              // GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
              //   const SizedBox(height: 0.5,)
              //   );


              GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                  Text("Calculate Your CgpA for The Entire ${level_counter * 100} level", style: const TextStyle(fontWeight: FontWeight.w900),)
                );


              GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                  LevelCgpaCalcCard(i-1, i, level_counter*100)
                );


               level_counter +=  1;  // at this point the 'level_counter'  tracker variable can then be incremented
             } 

             
             // if it is the Last Iteration of the Loop, then add a 'FullCgpaCalcCard' to total Cgpa of the Cgpa  for entire Course of Study
             if(i == GpaUIservice.list_of_semester_dataTables.length - 1){
                
                GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                const Divider(height: 26, thickness:3, color:Colors.black,)
                );


                GpaUIservice.list_of_all_needed_4_gp_calc_page.add(
                  FullCgpaCalcCard()
                );
             }


           } // END OF LOOP
       }

  } // END OF CLASS  'GpaUIservice'

 




class SemesterGpaCalcCard extends StatefulWidget {

  int _cntrlrMapsListIndex = 0;  // index_of_the list in GpaUIservice.   containing_controller_maps_for_a_semester = 0;
  double _semesterGpa = 0.0;
  String  _classOfDegree_for_semester = "";
  bool _hasCalculatedGpa = false;

  SemesterGpaCalcCard(this._cntrlrMapsListIndex);

  @override
  State<SemesterGpaCalcCard> createState() => _SemesterGpaCalcCardState();
} // Widget Class of  SemesterGpaCalcCard



class _SemesterGpaCalcCardState extends State<SemesterGpaCalcCard> {

  //String _semester_gpa = this._semesterGpa.toString();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height:  deviceHeight * 0.15,
        width:  deviceWidth,
        child: Row(
          children: [
    
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: ElevatedButton(
                style: ButtonStyle(elevation: MaterialStateProperty.all(25)),
                onPressed:(){
                   widget._semesterGpa =  GpCalcManager.calculate_gpa_for_semester(widget._cntrlrMapsListIndex, context);
                   widget._classOfDegree_for_semester = GpCalcManager.get_class_of_gp(widget._semesterGpa);
                   widget._hasCalculatedGpa = true;
                    if(widget._semesterGpa.toString() == "NaN"){
                       showDialog(
                        context: context, 
                        builder: (context){
                          widget._hasCalculatedGpa = false;
                          return const AlertDialog(title: Text("Please Enter at least One Score and it's Unit Load to Calculate Gpa"),);
                        });
                     }
                   setState(() { });
                },
            
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: deviceHeight * 0.05,
                    maxWidth: deviceWidth * 0.40
                  ),
                  child: const Text("Calculate Your Gpa For the above Semester", style:  TextStyle(color: Colors.white),),
                  ),
            
                ),
            ),

            SizedBox(width: deviceHeight * 0.02,),

            Container( // The Container Displaying the Computed Gpa
              height: 20,width: 50, 
              color: Colors.white, 
              child:widget._hasCalculatedGpa == false ? 
                    const Text("") : 
                    Center(child: Text("${widget._semesterGpa.to_x_decimal_places(1)}", style: TextStyle(fontWeight: FontWeight.w900),))
                    ),
            
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: deviceWidth * 0.25, maxHeight: deviceHeight * 0.25),
              child: widget._hasCalculatedGpa ? Text("${widget._classOfDegree_for_semester}") : const Text("")
              )
          ],
        ),
      ),
    );
  }
} 




class LevelCgpaCalcCard extends StatefulWidget {

  // ignore: prefer_final_fields
  int _semesterOneCntrlrMapsListIndex = 0;  // index_of_the list in GpaUIservice.   containing_controller_maps_for_a_semester = 0;
  int _semesterTwoCntrlrMapsListIndex = 0;
  double _cgpa_for_the_level = 0;
  String  _classOfDegree_for_level = "";
  int    _level = 0;
  bool _hasCalculatedCgpa = false;

  LevelCgpaCalcCard(this._semesterTwoCntrlrMapsListIndex, this._semesterOneCntrlrMapsListIndex, this._level);

  @override
  State<LevelCgpaCalcCard> createState() => _LevelCgpaCalcCardState();
} //



class _LevelCgpaCalcCardState extends State<LevelCgpaCalcCard> {


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height:  deviceHeight * 0.10,
        width:  deviceWidth,
        child: Row(
          children: [
  
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: ElevatedButton(
                style: ButtonStyle(elevation: MaterialStateProperty.all(25)),
                onPressed: (){
                  
                  // Calculate the Cgpa for the Level
                  widget._cgpa_for_the_level =  GpCalcManager.calculate_cgpa_for_level(widget._semesterOneCntrlrMapsListIndex, widget._semesterTwoCntrlrMapsListIndex, context);
                
                 // Get the Class of Degree for the Calculated Cgpa
                  widget._classOfDegree_for_level  = GpCalcManager.get_class_of_gp(widget._cgpa_for_the_level);
                 
                 // Indicate that a Cgpa has been Calculated
                  widget._hasCalculatedCgpa = true;
            
                  if(widget._cgpa_for_the_level.toString() == "NaN"){
                       showDialog(
                        context: context, 
                        builder: (context){
                          widget._hasCalculatedCgpa = false;
                          return const AlertDialog(title: Text("Please Enter At Least one Score in Both First Semester and Second Semester Tables, to Calculate Your Cummulative Gpa(CgpA) for this Level"),);
                        });
                     }
                   setState(() { });
                },
            
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: deviceHeight * 0.05,
                    maxWidth: deviceWidth * 0.40
                  ),
                  child: Text("Calculate Your Gpa For ${widget._level} Level", style:  TextStyle(color: Colors.white),),
                  ),
            
                ),
            ),

            SizedBox(width: deviceHeight * 0.02,),

            Container( // The Container Displaying the Computed Cgpa in a box
              height: 20,width: 50, 
              color: Colors.white, 
              child:widget._hasCalculatedCgpa == false ? 
                    const Text("") : 
                    Center(
                      child: widget._hasCalculatedCgpa ? // if the value of "widget._hasCalculatedCGpa"  is TRUE that means a valid Cgpa has been calculated (not NaN) hence display that Cgpa
                             Text("${widget._cgpa_for_the_level.to_x_decimal_places(1)}", style: const TextStyle(fontWeight: FontWeight.w900),)
                             : const Text(""), 
                             ),
                      ),
            
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: deviceWidth * 0.25, maxHeight: deviceHeight * 0.25),
              child: widget._hasCalculatedCgpa ? Text("${widget._classOfDegree_for_level}") : const Text("")
              )
          ],
        ),
      ),
    );
  }
}



class FullCgpaCalcCard extends StatefulWidget {
  
  double _fullCgpa = 0;
  String _classOfDegree = "";
  bool   _hasCalculatedCgpa = false;

  FullCgpaCalcCard();

  @override
  State<FullCgpaCalcCard> createState() => _FullCgpaCalcCardState();
}



class _FullCgpaCalcCardState extends State<FullCgpaCalcCard> {

  @override
  Widget build(BuildContext context) {
     double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height:  deviceHeight * 0.15,
        width:  deviceWidth,
        child: Row(
          children: [
    
            Padding(
              padding: const EdgeInsets.only(left: 15.0),

              child: ElevatedButton(
                style: ButtonStyle(elevation: MaterialStateProperty.all(25)),
                onPressed: (){
                  widget._fullCgpa =  GpCalcManager.calculate_full_cgpa(context);
            
                  widget._classOfDegree = GpCalcManager.get_class_of_gp(widget._fullCgpa);
            
                  widget._hasCalculatedCgpa  = true;
                  
                   if(widget._fullCgpa.toString() == "NaN"){
                       showDialog(
                        context: context, 
                        builder: (context){
                          widget._hasCalculatedCgpa = false;
                          return const AlertDialog(title: Text("Please Enter At Least one Score and One Unit Load in All the Semester Tables, to Calculate Your Total Cgpa "),);
                        });
                     }
                   setState(() { });
                },
            
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: deviceHeight * 0.05,
                    maxWidth: deviceWidth * 0.40
                  ),
                  child: const Text("Calculate Your CgpA for Your Entire Course Of Study", style:  TextStyle(color: Colors.white),),
                  ),
            
                ),
            ),

            SizedBox(width: deviceWidth * 0.02,),

            Container( // The Container Displaying the Computed Gpa
              //height: 20,width: 50, 
              color: Colors.white, 
              child:widget._hasCalculatedCgpa == false ? 
                    const Text("") : 
                    Center(child: Text("${widget._fullCgpa.to_x_decimal_places(1)}", style: const TextStyle(fontWeight: FontWeight.w900),))
                    ),
            
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: deviceWidth * 0.25, maxHeight: deviceHeight * 0.25),
              child: widget._hasCalculatedCgpa ? Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("${widget._classOfDegree}"),
              ) : const Text("")
              )
          ],
        ),
      ),
    );
  }
}



class NumOfCoursesPerSemesterFetcherContainer extends StatelessWidget {

  int level = 0;
  String semester = "";
  TextEditingController? numOfCoursesController;
  int indexOfTextEditingControllerToPassValueToUponTapOutside = 0;

  NumOfCoursesPerSemesterFetcherContainer(
    {required this.level, required this.semester, required this.numOfCoursesController});  

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: deviceHeight*0.2,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: deviceHeight*0.15),
        child: Column(  
          children: [
            Padding(
              padding: EdgeInsets.only(left: deviceWidth * 0.05),
              child: Text(
                "How many Courses did you do in your $level level\n $semester Semester ?",
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
            ),
      
              TextField(
                keyboardType: TextInputType.number,
                decoration:   InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(width: 5.0)
                                            ),
                                            constraints: BoxConstraints(maxWidth: deviceWidth * 0.5, maxHeight:  deviceHeight * 0.1)
                                            ),
                controller: numOfCoursesController,
                // focusNode: FocusNode(),
                // ----  COMMENTED OUT BECAUSE THIS WASN'T NECESSSARY, 
                //       I INITIALLY WAS GOING TO USE THIS TO ENSURE THAT INPUT ENTERED BY 
                //       USER IN THE "ContainerFetcher Card" TextFields, ARE ACCURATELY 
                //       REFLECTED IN THE LIST OF 'TextEditingControllers' in GpaUIService
                //       BUT IT WORKS ITSELF OUT AND THIS ISN'T NEEDED ------
                //
                // onTapOutside: (x){
                //   GpaUIservice.list_of_TextEditing_controllers_for_each_container_fetcher_card.elementAt(
                //     indexOfTextEditingControllerToPassValueToUponTapOutside
                //   ).text  = numOfCourses.text;
                // },
              ), 
              //const SizedBox(height: 15,),
              const Divider(height: 5, color:  Colors.black, thickness: 5,),
              
              const SizedBox(/*height: deviceHeight * 0.05,*/)
          ],
        ),
      ),
    );
  }
}