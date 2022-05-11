import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/IconAndText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/SmallText.dart';
import 'package:pfa2_mobile_app/screens/getMenuItem.dart';
class MenuItemBody extends StatefulWidget {
  const MenuItemBody({ Key? key }) : super(key: key);

  @override
  State<MenuItemBody> createState() => _MenuItemBodyState();
}

class _MenuItemBodyState extends State<MenuItemBody> {
  
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
            itemCount: 2,
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
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/lunch3.jpg"),
            )
          ),
        ),
        Align(
           alignment: Alignment.bottomCenter,
            child: Container(
              height: 123,
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
                       BigText(text: "Lunch"),
                       SmallText(text: "10/04/2022"),
                     ],
                    ),
                    const SizedBox(height: 7.0),
                    const IconAndText(icon: Icons.brightness_1, text: "Chocolate Milk"),
                    const IconAndText(icon: Icons.brightness_1, text: "Sandwich"),
                    //IconAndText(icon: Icons.brightness_1, text: "Donnut", iconColor: AppColors.backgroundWhite),
                    //IconAndText(icon: Icons.brightness_1, text: "Tart", iconColor: AppColors.backgroundWhite),
                    Container(
                      margin: const EdgeInsets.only(left: 200),
                      child: IconButton(onPressed: (){
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GetMenuItem() ),
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

