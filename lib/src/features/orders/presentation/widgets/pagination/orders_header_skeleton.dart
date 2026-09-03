part of '../../imports/orders_imports.dart';


class _OrdersHeaderSkeleton extends StatelessWidget {

  const _OrdersHeaderSkeleton();


  @override
  Widget build(BuildContext context) {

    return Row(

      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [


        Container(
          height: 18,
          width: 100,

          decoration: BoxDecoration(
            color: Colors.grey.shade300,

            borderRadius:
            BorderRadius.circular(6),
          ),
        ),



        Container(
          width: 35,
          height: 35,

          decoration: BoxDecoration(
            color: Colors.grey.shade300,

            borderRadius:
            BorderRadius.circular(10),
          ),
        ),


      ],

    );

  }

}