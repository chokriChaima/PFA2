import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/IconAndText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/SmallText.dart';
import 'package:pfa2_mobile_app/screens/getMenuItem.dart';

import '../models/menu_item.dart';
import '../services/menu_item_service.dart';
import '../services/user_service.dart';
class MenuItemBody extends StatefulWidget {
  const MenuItemBody({ Key? key }) : super(key: key);

  @override
  State<MenuItemBody> createState() => _MenuItemBodyState();
}

class _MenuItemBodyState extends State<MenuItemBody> {
  
  //Dynamic Code
  UserService userService = UserService( database: FirebaseFirestore.instance, user: FirebaseAuth.instance.currentUser );
  //final ref = FirebaseStorage.instance ; 
  List<MenuItem> _menuItemForToday = [];


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getMenuItemsByDate();
  }

  

  Future<void> getMenuItemsByDate() async{
    MenuItemService menuItemService = MenuItemService(userService: userService);
    QuerySnapshot<Object?> data = await menuItemService.getMenuItemByDate();
    if(data.docs.isNotEmpty){
      setState(() {
        _menuItemForToday = List.from(
          data.docs.map((documentQuery) =>
            MenuItem.fromMap(documentQuery)
          )
        );
        print(_menuItemForToday);
      });
      print(_menuItemForToday);
    }else {
      print("no available menu items for this date");
    }
  }







  // Variables
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0 ;
  double scaleFactor = 0.8 ;
  double _height = 220;

  // method inside any stateful widget, to use you must override
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        // recuperate current page value
        _currentPageValue = pageController.page!;
      });
    });
  }

  // dispose liberates memories
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.backgroundWhite,
          margin: const EdgeInsets.only(top:10),
          height: 312,
          child: PageView.builder(
            controller: pageController,
            //position starts from 0 to itemcount -1 
            itemCount: _menuItemForToday.length,
            itemBuilder: (context, position){
            return _buildPageItem(position);
          })
        ),
         const SizedBox(height: 15,),
         DotsIndicator(
          dotsCount: 2,
          position: _currentPageValue,
          decorator: DotsDecorator(
            color: AppColors.mainColor,
            activeColor:AppColors.mainColor ,
            size: const Size.square(9.0),
            activeSize: const Size(88.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int position) {

  // the return value (x,y,z)
  // to scale via x and y
  Matrix4 matrix =  Matrix4.identity();
  if(position == _currentPageValue.floor())
  { 
    var currentScale = 1-(_currentPageValue - position)*(1-scaleFactor);
    var currentTrans = _height*(1-currentScale)/2;
    matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    
  }else if(position == _currentPageValue.floor()+1)
  {
    var currentScale = scaleFactor+(_currentPageValue-position+1)*(1-scaleFactor);
    var currentTrans = _height*(1-currentScale)/2;
    matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
  }
  
  return Transform(
    transform: matrix,
    child: Stack(
      children:[ 
        Container(
          height: _height,
          // this is what creates the space between the sliders
          margin: const EdgeInsets.only(left: 6.0,right:6.0,top: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("${_menuItemForToday[position].imageURL}")  ,

            )
          ),
        ),
        Align(
           alignment: Alignment.bottomCenter,
            child: Container(
              height: 141,
              margin: const EdgeInsets.only(bottom: 2,left: 30.0,right:30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0)
                  ),
                   BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  )
                ]

              ),
              child: Container(
                padding: const EdgeInsets.only(top:17,left:15,right:15,),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       _menuItemForToday[position].isLunch ?
                       BigText(text: "Lunch"):
                       BigText(text: "Dinner"),
                       SmallText(text: "${ _menuItemForToday[position].availabilityDate?.day.toString()} / ${_menuItemForToday[position].availabilityDate?.month.toString()} / ${ _menuItemForToday[position].availabilityDate?.year.toString()}"),
                     ],
                    ),
                    const SizedBox(height: 7.0),
                    ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _menuItemForToday[position].components.length,
                    itemBuilder: (context,index){
                      return IconAndText(icon: Icons.brightness_1, text:_menuItemForToday[position].components[index]);
                    },
                  ),
                    Container(
                      margin: const EdgeInsets.only(left: 200),
                      child: IconButton(onPressed: (){
                        
                          Navigator.push(
                            context,
                            // pass a menuItem as an attribut
                            MaterialPageRoute(builder: (context) => GetMenuItem(menuItem :_menuItemForToday[position]) ),
                          );}
                          ,icon: const Icon(Icons.arrow_forward_ios,size:15)
                        ),
                    ),
                  ],
                )
              )
            ),
         ),
      ]
    ),
  );
}
}

