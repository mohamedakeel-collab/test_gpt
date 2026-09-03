part of '../../imports/home_imports.dart';


class _HomeHeaderSkeleton extends StatelessWidget {

  const _HomeHeaderSkeleton();


  @override
  Widget build(BuildContext context) {

    return Padding(

      padding:
      EdgeInsets.all(
        AppPadding.pW20,
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children: [


          16.szH,


          Container(

            height: 24,

            width: 220,


            decoration: BoxDecoration(

              color:
              Colors.grey.shade300,


              borderRadius:
              BorderRadius.circular(8),

            ),

          ),



          10.szH,



          Container(

            height: 16,

            width: 170,


            decoration: BoxDecoration(

              color:
              Colors.grey.shade300,


              borderRadius:
              BorderRadius.circular(8),

            ),

          ),


        ],

      ),

    );

  }

}