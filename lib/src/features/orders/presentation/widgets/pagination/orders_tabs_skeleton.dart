part of '../../imports/orders_imports.dart';

class _OrdersTabsSkeleton extends StatelessWidget {
  const _OrdersTabsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,

        (index) => Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == 2 ? 0 : 8),

            height: 36,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
