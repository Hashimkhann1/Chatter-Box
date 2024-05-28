import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class CallHistoryView extends StatelessWidget {
  const CallHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.02,),
              const MyText(title: 'Recent Calls',fontSize: 18,fontWeight: FontWeight.bold,),
              SizedBox(height: height * 0.03,),

              Expanded(
                child: ListView.builder(
                  itemCount: MyColor.images.length,
                    itemBuilder: (context , index) {
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                          horizontalTitleGap: 12,
                          leading: CircleAvatar(radius: 30,backgroundImage: NetworkImage(MyColor.images[index].toString(),),),
                          title: const MyText(title: 'Caller Name',fontSize: 18,fontWeight: FontWeight.w600,),
                          subtitle: const MyText(title: 'Yesterday, 8:47 PM'),
                          trailing: IconButton(onPressed: (){},icon: const Icon(Icons.call),),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
