part of '../../imports/notifications_imports.dart';


class _NotificationCardSkeleton extends StatelessWidget {
  const _NotificationCardSkeleton();


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
      EdgeInsets.all(
        AppPadding.pH16,
      ),


      decoration:
      BoxDecoration(

        color:
        AppColors.white,


        borderRadius:
        BorderRadius.circular(
          AppCircular.r12,
        ),


        border:
        Border.all(
          color:
          AppColors.border,
        ),

      ),


      child: Row(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children: [


          Container(

            width:
            AppSize.sH45,

            height:
            AppSize.sH45,


            decoration:
            BoxDecoration(

              color:
              Colors.grey.shade300,


              shape:
              BoxShape.circle,

            ),

          ),



          12.szW,



          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,


              children: [


                Container(

                  height:
                  14,

                  width:
                  100,


                  decoration:
                  BoxDecoration(

                    color:
                    Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(
                      6,
                    ),

                  ),

                ),



                12.szH,



                Container(

                  height:
                  12,

                  width:
                  double.infinity,


                  decoration:
                  BoxDecoration(

                    color:
                    Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(
                      6,
                    ),

                  ),

                ),



                8.szH,



                Container(

                  height:
                  12,

                  width:
                  180,


                  decoration:
                  BoxDecoration(

                    color:
                    Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(
                      6,
                    ),

                  ),

                ),

              ],

            ),

          ),


        ],

      ),

    );

  }

}