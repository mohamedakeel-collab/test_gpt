part of '../../imports/orders_imports.dart';


class _OrderCardSkeleton extends StatelessWidget {

  const _OrderCardSkeleton();


  @override
  Widget build(BuildContext context) {

    return Container(

      padding: EdgeInsets.all(
        AppPadding.pH16,
      ),


      decoration: BoxDecoration(

        color: AppColors.white,

        borderRadius:
        BorderRadius.circular(
          AppCircular.r12,
        ),

      ),


      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children: [


          Row(

            children: [


              Container(
                width: AppSize.sH40,
                height: AppSize.sH40,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius:
                  BorderRadius.circular(10),
                ),
              ),



              12.szW,



              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children: [


                    Container(
                      height: 14,
                      width: 140,

                      decoration: BoxDecoration(
                        color:
                        Colors.grey.shade300,

                        borderRadius:
                        BorderRadius.circular(6),
                      ),
                    ),



                    8.szH,



                    Container(
                      height: 12,
                      width: 100,

                      decoration: BoxDecoration(
                        color:
                        Colors.grey.shade300,

                        borderRadius:
                        BorderRadius.circular(6),
                      ),
                    ),


                  ],
                ),

              ),



              8.szW,



              Container(
                width: 70,
                height: 24,

                decoration: BoxDecoration(
                  color:
                  Colors.grey.shade300,

                  borderRadius:
                  BorderRadius.circular(20),
                ),
              ),


            ],
          ),



          16.szH,



          Container(
            height: 1,

            color: Colors.grey.shade200,
          ),



          16.szH,



          Row(

            children: [


              Expanded(
                child: Container(
                  height: 12,
                  width: 90,

                  decoration: BoxDecoration(
                    color:
                    Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),
              ),



              16.szW,



              Expanded(
                child: Container(
                  height: 12,
                  width: 90,

                  decoration: BoxDecoration(
                    color:
                    Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                ),
              ),


            ],
          ),



        ],

      ),

    );

  }

}