import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';

class ModuleListTile extends StatelessWidget {
  final Module module;

  ModuleListTile({this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        onTap: () {
          print(module.id);
          Navigator.pushNamed(context, '/${module.id}');
        },
        leading: CircleAvatar(
          backgroundColor: Color(0xE6344955),
          child: Text(
            module.module[0].toUpperCase(),
          ),
        ),
        title: Text(
          module.module,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          '${module.group} / Sem ${module.sem} / ${module.year}',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: Color(0xE6344955),
          child: Text('${module.kids.length}'),
        ),
      ),
    );
  }
}
