
import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/view/chat_view/chat_view.dart';
import 'package:flutter/material.dart';

class AllUsersView extends StatelessWidget {
  final String userName;
  final String? imagesPath;
  final String reciverId;
  const AllUsersView({super.key,required this.userName,this.imagesPath,required this.reciverId});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatView(userName: userName,reciverId: reciverId,)));
      },
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: Container(
        width: width * 0.20,
        height: height * 0.30,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imagesPath.toString()),
            fit: BoxFit.cover
          )
        ),
      ),
      title: MyText(title: userName.toString(),fontSize: 20,fontWeight: FontWeight.w600,),
      subtitle: Row(
        children: [
          Icon(Icons.done_all,size: 18,color: MyColor.blueColor,),
          SizedBox(width: width * 0.01,),
          Expanded(child: MyText(title: 'What was the best year of your life?',color: MyColor.grayColor,overflow: TextOverflow.ellipsis,fontSize: 13,maxLines: 1,)),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(title: '04.01',fontSize: 14,fontWeight: FontWeight.w300,),
          SizedBox(height: height * 0.008,),
          CircleAvatar(
            radius: 11,
            backgroundColor: MyColor.blueColor,
            child: MyText(title: '2',),
          ),
        ],
      ),
    );
  }
}
