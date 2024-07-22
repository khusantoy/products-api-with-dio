import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_with_dio/blocs/products/products_bloc.dart';

class ManageScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final int? price;
  final int? productId;
  final List<String>? images;
  const ManageScreen(
      {super.key,
      this.title,
      this.description,
      this.price,
      this.productId,
      this.images});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.title != null &&
        widget.description != null &&
        widget.price != null &&
        widget.productId != null &&
        widget.images != null) {
      titleController.text = widget.title!;
      descriptionController.text = widget.description!;
      priceController.text = widget.price.toString();
    }
  }

  void addProduct() {
    if (_formkey.currentState!.validate()) {
      context.read<ProductsBloc>().add(
            AddProductEvent(
              titleController.text,
              int.parse(priceController.text),
              descriptionController.text,
              2,
              [
                "https://i.pinimg.com/originals/d1/d0/46/d1d046ff84d4e8cb1adeb35ec5493c9a.jpg"
              ],
            ),
          );
      Navigator.pop(context);
    }
  }

  void editProduct() {
    if (_formkey.currentState!.validate()) {
      context.read<ProductsBloc>().add(
            EditProductEvent(
              widget.productId!,
              titleController.text,
              int.parse(priceController.text),
              descriptionController.text,
              2,
              [
                "https://i.pinimg.com/originals/d1/d0/46/d1d046ff84d4e8cb1adeb35ec5493c9a.jpg"
              ],
            ),
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add product"),
        backgroundColor: Colors.amber,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Fill this space";
                  }
                  null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Fill this space";
                  }
                  null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: "Price",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Fill this space";
                  }
                  null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      widget.productId != null ? editProduct : addProduct,
                  child: widget.productId != null
                      ? const Text("Update product")
                      : const Text("Add product"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
