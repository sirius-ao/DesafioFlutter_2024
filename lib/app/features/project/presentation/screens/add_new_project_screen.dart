import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:project_management_app/app/core/common/widgets/loader.dart';
import 'package:project_management_app/app/core/constants/app_colors.dart';
import 'package:project_management_app/app/core/enums/route_path.dart';
import 'package:project_management_app/app/core/utils/pick_image.dart';
import 'package:project_management_app/app/core/utils/show_snackbar.dart';
import 'package:project_management_app/app/features/project/presentation/bloc/project_bloc.dart';
import 'package:project_management_app/app/features/project/presentation/widgets/project_editor.dart';

class AddNewProjectScreen extends StatefulWidget {
  const AddNewProjectScreen({super.key});

  @override
  State<AddNewProjectScreen> createState() => _AddNewProjectScreenState();
}

class _AddNewProjectScreenState extends State<AddNewProjectScreen> {
  final _titleController =  TextEditingController();
  final _contentController =  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;
  void selectImage () async {
    final pickedImage = await pickImage();
    if(pickedImage != null){
      setState(() {
        image = pickedImage;
      });
    }
  }
  void uploadProject(){
     if (_formKey.currentState!.validate() &&  selectedTopics.isNotEmpty && image != null) {
      final posterId = (context.read<AppUserCubit>().state as AppUserLoggedInState).user.id;
      context.read<ProjectBloc>().add(ProjectUpLoadEvent(
        image: image!, 
        title: _titleController.text.trim(), 
        content: _contentController.text.trim(), 
        posterId: posterId, 
        topics: selectedTopics
        )
      );
    }
  }
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
             uploadProject();
            }, 
            icon: const Icon(Icons.done_rounded)
          )
        ],
      ),
      body: BlocConsumer<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if(state is ProjectFailureState){
            showSnackBar(context, state.error);
          }else if(state is ProjectUploadSuccessState){
            RoutePath.project.pushAndRemoveUntil(context);
          }
        },
        builder: (context, state) {
          if (state is ProjectLoadingState) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    image != null ?
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ):  
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        color: AppColor.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(height: 15,),
                              Text(
                                'Select your image',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Tecnology',
                          'Business',
                          'Programing',
                          'Entrtainment'
                        ].map((e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              }else{
                                selectedTopics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              label: Text(e),
                              color: selectedTopics.contains(e) ? const MaterialStatePropertyAll(AppColor.gradient1Color) : null,
                              side: const BorderSide(
                                color: AppColor.borderColor 
                                ),
                              ),
                          ),
                        )
                        ).toList(),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ProjectEditor(controller: _titleController, hintText: 'Title'),
                    const SizedBox(height: 10,),
                    ProjectEditor(controller: _contentController, hintText: 'Content')
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}