
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utilitis/app_main_color.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';

class ChatSectionPage extends StatelessWidget {
  ChatSectionPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
        length: 3,
        child: Scaffold(
            key: scaffoldKey,
            appBar: mainAppBar(
          scaffoldKey,
          context,
          tabBar: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25.w),
              color: AppMainColor.primaryColor
            ),
            labelPadding: EdgeInsets.all(10.w)  ,
            tabs: [
              Text(
                "Buyers",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                ),
              ),
              Text(
                "Swapper",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                 // color: AppMainColor.primaryColor
                ),
              ),
              Text(
                "Seller",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                  //color: AppMainColor.primaryColor
                ),
              ),
            ],
          ),
        ),
          body:  Padding(
            padding:  EdgeInsets.only(top: 20.w),
            child: TabBarView(
                children: [
                  ListView.separated(
                    itemCount: 10,
                      itemBuilder: (context, index){
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person, size: 25.w,),
                          ),
                          title: Text("Name", style: TextStyle(
                            fontSize: 20.w,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                          ),),
                          subtitle: Text("Swapping Book Name", style: TextStyle(
                              fontSize: 16.w,
                              fontWeight: FontWeight.w600,
                              color: AppMainColor.primaryColor
                          ),),
                          trailing: Text("Time 10:15 pm", style: TextStyle(
                              fontSize: 14.w,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54
                          ),),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          thickness: 2.w,
                          color: AppMainColor.primaryColor,
                        );
                  },
                  ),
                  ListView.separated(
                    itemCount: 7,
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person, size: 25.w,),
                        ),
                        title: Text("Name", style: TextStyle(
                            fontSize: 20.w,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                        ),),
                        subtitle: Text("Swapping Book Name", style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.w600,
                            color: AppMainColor.primaryColor
                        ),),
                        trailing: Text("Time 10:15 pm", style: TextStyle(
                            fontSize: 14.w,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54
                        ),),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 2.w,
                      color: AppMainColor.primaryColor,
                    );
                  },
                  ),
                  ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person, size: 25.w,),
                        ),
                        title: Text("Name", style: TextStyle(
                            fontSize: 20.w,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                        ),),
                        subtitle: Text("Swapping Book Name", style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.w600,
                            color: AppMainColor.primaryColor
                        ),),
                        trailing: Text("Time 10:15 pm", style: TextStyle(
                            fontSize: 14.w,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54
                        ),),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 2.w,
                      color: AppMainColor.primaryColor,
                    );
                  },
                  ),

            ]),
          ),
          bottomNavigationBar: const BottomNav(),


        ));
  }
}
