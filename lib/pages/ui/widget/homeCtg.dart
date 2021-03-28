import 'package:flutter/material.dart';
import 'package:sanchika/model/CtgAttribute.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/pages/ui/screens/home/home.dart';
import 'package:sanchika/pages/ui/screens/categories/productAttribute_view.dart';
import 'package:sanchika/services/api_service.dart';
class HomeCtg extends StatefulWidget {
  CtgyNameAndId ctgyNameAndId;
  HomeCtg({this.ctgyNameAndId});
  @override
  _HomeCtgState createState() => _HomeCtgState();
}

class _HomeCtgState extends State<HomeCtg> {
  APIService apiService;
  @override
  void initState(){
    super.initState();
    apiService = new APIService();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          title(title: widget.ctgyNameAndId.ctgyNm),
          ctgAttributes(),
          SizedBox(height:4),
          products(),
        ],
      ),
      
    );
  }
  Widget products(){
  return Container(
    width: double.maxFinite,
    child: FutureBuilder(
      future:apiService.getKillerOffeers() ,
      builder: (context,snapshot){
        if(snapshot.hasData){
        return HorizontalRow(productList: snapshot.data,);
        }
        else{
          return Center(child: CircularProgressIndicator());
        } 
      }),
  );

}
Widget ctgAttributes(){
  Widget label({CategoryAttribute categoryAttribute}){
    return GestureDetector(
      onTap: (){
         Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>ProductAttribute(categoryAttribute:categoryAttribute,ctgyNameAndId: widget.ctgyNameAndId,) ),
        );
      },
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4.0),
        child: Container(
          height: 10,
  
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
                color: Colors.green[50],
               border: Border.all(color: Colors.green)
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(child: Text(categoryAttribute.categoryValue)),
          ),
        ),
      ),
    );

  }
  return Container(
  
       child: FutureBuilder(
          future: apiService.getCategoryAttributeBySecondOrder(widget.ctgyNameAndId.mnId),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Container(
                height: snapshot.data.length>0?40:0,
                child: ListView.builder(
                  cacheExtent: 1000,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    CategoryAttribute ctgAttr = snapshot.data[index];
                    return label(categoryAttribute: ctgAttr);
                  }),
              );
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
           
  );
}

}
Widget title({String title}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(title,style:TextStyle(
          color: Color(0xff032e6b),
          fontSize: 18,
          
        ))
      ],
    ),
  );
}
