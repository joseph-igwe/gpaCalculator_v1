


import 'package:flutter/material.dart';
import 'package:gp_calculator_by_joseph/service_classes/gpa_calculator_UI_service.dart';

class GpCalcManager {

static int course_duration = 0;



static double calculate_gpa_for_semester(int cntrlrMapsListIndex, BuildContext context){

List<Map<String, TextEditingController>> temp_list =  GpaUIservice.list_of_lists_with_maps_of_txtEdt_cntrlrz[cntrlrMapsListIndex];

double temp_sum_of_quality_points = 0.0;
double temp_sum_of_unit_loads = 0.0;

try{

  for (Map<String,TextEditingController> m in temp_list){

    // If the User Did not Enter anything in both the "score" Cell and the "unit Load" Cell
    // of a given DataRow, Don't raise an error, Just Continue on to the Next Row
    // This way, an Error(Alert Dialog) is only thrown if the user Enters one Cell in a 
    // given Row, but not the Other Cell on the Same Row
     if(m["score"]!.text == "" && m["unitLoad"]!.text == ""){
        continue;        
     } else{
        temp_sum_of_quality_points += GpCalcManager.get_quality_point( 
        double.parse( m["score"]!.text ),  // Pass the Value the User typed in the Score Cell of the Given Row
        double.parse( m["unitLoad"]!.text )  // Pass the Value the User typed in the Unit Load Cell of the Given Row
      );

     temp_sum_of_unit_loads  += double.parse( m["unitLoad"]!.text );
     }
  }

  return temp_sum_of_quality_points / temp_sum_of_unit_loads ;

}catch(error){
  showDialog(
    context: context, 
    builder: (context){
      return const AlertDialog(
        title: Text("Every Score you enter must have a Unit Load and Every Unit Load must have a Score"),
      );
    });
}
return 0.0;
} // calculate_gpa_for_semester( )


static double calculate_cgpa_for_level(int firstSemesterCntrlrMapsListIndex, int secondSemesterCntrlrMapsListIndex, BuildContext context)
{

   List<Map<String, TextEditingController>> firstSemester_list_of_cntrlr_maps =
   GpaUIservice.list_of_lists_with_maps_of_txtEdt_cntrlrz[firstSemesterCntrlrMapsListIndex];
   

   List<Map<String, TextEditingController>> secondSemester_list_of_cntrlr_maps =
   GpaUIservice.list_of_lists_with_maps_of_txtEdt_cntrlrz[secondSemesterCntrlrMapsListIndex];
   

  double temp_firstSemester_sumOfQualityPoints = 0;
  double temp_firstSemester_sumOfUnitLoads = 0;
  double temp_firstSemester_gpa = 0;

  double temp_secondSemester_sumOfQualityPoints = 0;
  double temp_secondSemester_sumOfUnitLoads = 0;
  double temp_secondSemester_gpa = 0;

  try{

    for(Map<String, TextEditingController> m in firstSemester_list_of_cntrlr_maps){

        if( !(m["score"]!.text == ""  && m["unitLoad"]!.text == "") ) // If it is false that Both Cells in the DataRow are empty, i.e Ignore any Row Where Both Cells on the Row is Empty
        {
         
              temp_firstSemester_sumOfQualityPoints  +=  
              GpCalcManager.get_quality_point(double.parse(m["score"]!.text), double.parse(m["unitLoad"]!.text));

              temp_firstSemester_sumOfUnitLoads += double.parse(m["unitLoad"]!.text);

         }
     }
  } catch(error)
  {
      showDialog(context: context, builder: (context)=> const AlertDialog(title: Text("ERROR !! Every Score Entered must have a Unit Load and Every Unit Load must have a Score"),));
  }

  temp_firstSemester_gpa = temp_firstSemester_sumOfQualityPoints / temp_firstSemester_sumOfUnitLoads;

  try{
       for(Map<String, TextEditingController> m  in secondSemester_list_of_cntrlr_maps){
       if(!(m["score"]!.text == ""  && m["unitLoad"]!.text == "")) // If it is false that Both Cells in the DataRow are empty, i.e Ignore any Row Where Both Cells on the Row is Empty
       {
         
              temp_secondSemester_sumOfQualityPoints  +=  
              GpCalcManager.get_quality_point(double.parse(m["score"]!.text), double.parse(m["unitLoad"]!.text));

              temp_secondSemester_sumOfUnitLoads += double.parse(m["unitLoad"]!.text);
         }
      }

  }catch(error)
  {
       showDialog(context: context, builder: (context)=> const AlertDialog(title: Text("ERROR!! Every Score Entered must have a Unit Load and Every Unit Load must have a Score"),));
  }


  temp_secondSemester_gpa = temp_secondSemester_sumOfQualityPoints / temp_secondSemester_sumOfUnitLoads;


  return  (temp_firstSemester_gpa + temp_secondSemester_gpa) / 2;
} // calculate_gpa_for_level( )



static double calculate_full_cgpa(BuildContext context){

   double temp_full_cgpa  = 0;

   for( int i=0;  i<GpaUIservice.list_of_lists_with_maps_of_txtEdt_cntrlrz.length; i+=2 ){

     temp_full_cgpa += GpCalcManager.calculate_cgpa_for_level(i, i+1, context);
   }

   temp_full_cgpa = temp_full_cgpa / ( (GpaUIservice.list_of_lists_with_maps_of_txtEdt_cntrlrz.length)/2 );

   return temp_full_cgpa;
}



static double get_quality_point(double score, double courseUnitLoad){

    if(score >=70  && score <= 100){
            return 5*courseUnitLoad;

        } else if (score >= 60 && score <= 69){
            return 4*courseUnitLoad;

        } else if (score >=50 && score <= 59){
            return 3*courseUnitLoad;

        } else if (score >=45 && score <= 49){
            return 2*courseUnitLoad;

        } else if (score >= 40 && score <= 44){
            return 1*courseUnitLoad;

        } else {
            return 0*courseUnitLoad;
        } 
}

static String get_class_of_gp(double cgpa){
  if (cgpa >= 4.5 && cgpa <= 5){
        return "First Class";

    } else if (cgpa >= 3.5 && cgpa <= 4.49){
        return "Second Class upper";

    } else if (cgpa >= 2.49 && cgpa <= 3.49){
       return "Second class Lower";

    } else if (cgpa >= 1.50 && cgpa <= 2.48){
        return "Third Class";

    } else if(cgpa >= 1 && cgpa <= 1.49){
        return "Good Academic Standing";

    } else {
        return "Not in Good Academic Standing";
    }
}
}





// EXTENSION............
extension doubleOps on double{

  int get_index_of_point_in_string(String  doubleAsString){
    int returnIndex = 0;

    for(int i=0; i<doubleAsString.length; i++){
      if(doubleAsString[i] == "."){
        returnIndex = i;
        break;
      }
    }

    return returnIndex;

  }

  String to_x_decimal_places(int numOfDecimalPlaces){
    // 1. Convert double to String
    // 2. get index of point "." in the string
    // 3. slice all to the left of index of point and add in a String "temp_result_string"
    // 4. add "." to String "temp_result_string"
    //
    // 5. IF "numOfDecimalPlaces"  is Greater Than or equal to the total number of Characters to the right of "index_of_point", 
           //  ADD all Characters to the right of  "index_of_point" to "temp_result_string"

    //    ELSE 
    //         slice the first "numOfDecimalPlaces" characters to the right of  "index_of_point"slice the first "numOfDecimalPlaces" characters to the right of  "index_of_point"and add them to the String  "temp_result_string"
    //
    // 6. return "temp_result_string"

   
    //__________IMPLEMENTATION
    //--------------------------
    
    // Convert double to String
    String double_as_string = this.toString();

    // get index of point "." in the string
    int  index_of_point   =  get_index_of_point_in_string(double_as_string);
    
    // slice all to the left of index of point and add in a String "temp_result_string"
    String temp_result_string  = double_as_string.substring(0,index_of_point);

    // add "." to String "temp_result_string"
     temp_result_string += ".";

    // IF "numOfDecimalPlaces"  is Greater Than or equal to 
    // the total number of Characters to the right of "index_of_point", 
           //  ADD all Characters to the right of  "index_of_point" to "temp_result_string"
    if( numOfDecimalPlaces >= double_as_string.substring(index_of_point).length )
    {
       temp_result_string += double_as_string.substring(index_of_point);
    }
    // ELSE 
    //     slice the first "numOfDecimalPlaces" characters to the right of  "index_of_point"
    
    for(int i=1; i<=numOfDecimalPlaces; i++){
      temp_result_string += double_as_string[index_of_point+i];
    }

    //return "temp_result_string"
    return temp_result_string;
  }
}