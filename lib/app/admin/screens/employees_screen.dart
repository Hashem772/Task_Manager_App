import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/auth/controller/auth_controller.dart';
import 'package:task_manager/app/model/task_model.dart';
import 'package:task_manager/app/model/user_model.dart';
import 'package:task_manager/app/services/notification_service.dart';
import 'package:task_manager/app/shared_widget/Dialogs/ask_awesome_dialog.dart';
import 'package:task_manager/app/shared_widget/custome_drawer.dart';
import 'package:task_manager/app/shared_widget/not_found_data_screen.dart';
import 'package:task_manager/app/shared_widget/search_widget.dart';
import '../components/new_task_buttom_sheet.dart';
import '../controller/employee_controller.dart';
import 'emp_tasks_root.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class EmployeesScreen extends StatefulWidget {
  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  TextEditingController searchCon = TextEditingController();

  EmployeeController _employeeController = Get.put(EmployeeController());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<UserModel> selectedEmps = [];


  @override
  void initState() {
    _employeeController.getAllEmp();


    super.initState();
  }
  bool isAllSelected =false;
  @override
  Widget build(BuildContext context) {
    //_employeeController.getAllEmp();
    return Scaffold(
      endDrawer: CustomeDrawer(),
     // backgroundColor: Get.theme.primaryColor,

      key: scaffoldKey,
      appBar: AppBar(
        //  backgroundColor: Get.theme.primaryColor,
        centerTitle: selectedMode?false: true,
        elevation: 0.0,

        title: selectedMode?
        Row(
          children: [
            Checkbox(
                fillColor: MaterialStateProperty.all(Colors.white),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                checkColor: Colors.black,
                value: isAllSelected,

                onChanged: (val) {
                 setState(() {
                   isAllSelected = !isAllSelected;
                  if(isAllSelected == true){
                    selectedEmps.clear();
                    _employeeController.empData.forEach((element) {
                      selectedEmps.add(element);
                    });
                  }else{
                    selectedEmps.clear();
                  }
                 });
                }),
           // Text(selectedEmps.isNotEmpty?selectedEmps.length:isAllSelected && selectedEmps.isEmpty?)
            Text('${selectedEmps.length}')
          ],
        )
            :
        Text("Employees")



      ),
      body: SafeArea(

        child: RefreshIndicator(
          onRefresh:() async{
            _employeeController.getAllEmp();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SearchWidget(
                    onChange: (String? val){
                      if(val!.trim().isEmpty){
                        _employeeController.getAllEmp();
                      }else{
                        _employeeController.serachEmpByName(val);
                      }
                    },
                  ),
                ),
                Wrap(

                  children: selectedEmps.map((e) {
                    return Padding(
                      padding:  EdgeInsets.all( 5.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedEmps.removeWhere((element) => element.userId == e.userId);

                          });
                        },
                        child: Chip(
                            label: Text('${e.userName}'),
                          avatar: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Icon(Icons.remove,color: Colors.red,)),
                        ),
                      ),
                    );


                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    ],
                  ),
                ),
                Expanded(
                  child: GetBuilder<EmployeeController>(
                    builder: (controller) {
                      if (controller.loading) {
                        return Center(
                          child: Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                color: Get.theme.primaryColor,
                              )),
                        );
                        //return CustomeShimmerEffectOne();
                      }
                         final bool result = InternetConnectionChecker().hasConnection == true;
                         if (result == false && controller.empData.isEmpty) {
                           return NotFoundDataScreen(
                             icon: Icons.wifi_off_outlined,
                             errorText: 'No internet connection',
                           );
                         }
                      if (controller.empData.isEmpty) {
                        return InkWell(
                          onTap: (){
                           _employeeController.getAllEmp();

                          },
                          child: NotFoundDataScreen(
                            icon: Icons.person_off,
                            errorText: 'There are no Emloyees',
                          )
                        );
                      }

                      return WillPopScope(
                        onWillPop: () async{
                          if(selectedMode){
                            setState(() {
                              selectedEmps.clear();
                            });

                            return false;
                          }
                          return true;
                        },
                        child: ListView.builder(
                          //physics: BouncingScrollPhysics(),
                            itemCount: controller.empData.length,
                            itemBuilder: (c, i){
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Get.theme.primaryColor,width: 2)),
                               // color:Colors.white,
                                child: ListTile(
                                  onTap: (){
                                    if(selectedMode){
                                      selectTapEmp(controller.empData[i]);
                                    }else{
                                      Get.to(() => EmpTasksRoot(controller.empData[i]));

                                    }
                                  },
                                  onLongPress: (){
                                    selectTapEmp(controller.empData[i]);
                                  },
                                  leading:
                                  CircleAvatar(
                                    child:
                                    isSelected(controller.empData[i].userId!)? Icon(Icons.check,color: Colors.white,)
                                    :ClipRRect(
                                      clipBehavior: Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(35),
                                      child: FadeInImage.assetNetwork(
                                        image:
                                        '${controller.empData[i].user_image}',
                                        imageCacheHeight: 70,
                                        imageCacheWidth: 70,
                                        fit: BoxFit.contain,
                                        placeholder: 'assets/images/person2.png',
                                        placeholderCacheHeight: 50,
                                        placeholderCacheWidth: 40,
                                        imageErrorBuilder: (a, b, c) =>
                                            Image.asset('assets/images/person2.png',width: 40,height: 50,fit: BoxFit.contain),
                                      ),
                                    ),
                                    radius: isSelected(controller.empData[i].userId!)? 20:35,
                                    backgroundColor: isSelected(controller.empData[i].userId!)? Colors.green:Colors.white,
                                   // backgroundColor: Colors.white,
                                  ),


                                  title: Text('${controller.empData[i].userName!}',overflow: TextOverflow.ellipsis,),
                                  subtitle: Text(controller.empData[i].userPhone.toString()),
                                ),
                              );

                            }
                            ),
                      );

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

        floatingActionButton: selectedMode?FloatingActionButton(
          //backgroundColor: Get.theme.primaryColor,
        onPressed: (){

         _startAddNewTask(context );
        },
        child: Icon(Icons.add, color: Get.theme.primaryIconTheme.color),
        tooltip: 'Add new task',
      ):null,
    );
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return NewTaskButtomSheet(_addTask);
      },
    );
  }
  bool get  selectedMode => selectedEmps.isNotEmpty;

  void _addTask(String title, String details) async{
    Map<String, ReceiverModel> selectedRec = {};
    for(var emp in selectedEmps){
      selectedRec['${emp.userId}'] = ReceiverModel();
    }
    final task = TaskModel(taskTitle: title, taskDetails: details);
    task.empReceivers = selectedRec;
    task.senderId = AuthController.instance.userId;
    await _employeeController.addNewTask(task,context);

    for(var emp in selectedEmps){
      if(emp.userToken != null){
       await NotificationService().sendPushMessage(
           emp.userToken!,
           '$title',
            '${details}'
       );
      }
    }
    setState(() {
      selectedEmps.clear();
    });
  }

  bool isSelected(String id){
    final x = selectedEmps.firstWhereOrNull((element) => element.userId == id);
    if(x != null) return true;
    return false;
  }

  void selectTapEmp(UserModel emp){
    setState(() {
      if(isSelected(emp.userId!) == false){
        selectedEmps.add(emp);
      }else{

        selectedEmps.removeWhere((element) => element.userId == emp.userId);
      }
    });
  }
}
