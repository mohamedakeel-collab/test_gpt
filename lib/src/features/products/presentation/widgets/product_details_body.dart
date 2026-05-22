part of '../imports/products_imports.dart';

class _ProductDetailsBody extends StatelessWidget {
  const _ProductDetailsBody();

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<ProductDetailsCubit, ProductEntity>(
      builder: (context, product) {
        return CustomScrollView(
          slivers: [
            SliverAppBar.large(title: Text(product.name), pinned: true),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.imageUrl != null &&
                        product.imageUrl!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            product.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.broken_image_outlined),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          product.price.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Spacer(),
                        Chip(label: Text(product.status.name)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'الوصف',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description.isEmpty
                          ? 'لا يوجد وصف'
                          : product.description,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
