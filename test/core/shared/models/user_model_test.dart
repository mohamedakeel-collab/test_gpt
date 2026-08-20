import 'package:clean_arch_base/src/core/shared/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('UserModel.fromJson', () {


    test('parses login response user data', () {

      final user = UserModel.fromJson({

        'id': 2,

        'email': 'engineering.manager@company.com',

        'role': 'manager',

        'image': '/storage/default.png',

        'employee': {

          'id': 1,

          'full_name': 'Greg Greenfelder',

          'phone': '+966576936141',

          'position': 'Software Engineer',

          'remaining_leave_balance': 21,

          'permission_hours': 4,


          'department': {

            'id': 1,

            'name': 'Engineering',

          },


          'team': {

            'id': 1,

            'team_name': 'Engineering Team',

          }

        }

      });


      expect(
        user.id,
        '2',
      );


      expect(
        user.email,
        'engineering.manager@company.com',
      );


      expect(
        user.role,
        'manager',
      );


      expect(
        user.fullName,
        'Greg Greenfelder',
      );


      expect(
        user.phoneNumber,
        '+966576936141',
      );


      expect(
        user.position,
        'Software Engineer',
      );


      expect(
        user.remainingLeaveBalance,
        21,
      );


      expect(
        user.permissionHours,
        4,
      );


      expect(
        user.department?.name,
        'Engineering',
      );


      expect(
        user.team?.teamName,
        'Engineering Team',
      );

    });



    test('empty json returns safe defaults', () {

      final user = UserModel.fromJson({});


      expect(user.id, '');

      expect(user.fullName, '');

      expect(user.email, '');

      expect(user.role, '');

      expect(user.position, '');

      expect(user.remainingLeaveBalance, 0);

      expect(user.permissionHours, 0);

      expect(user.department, null);

      expect(user.team, null);

    });

  });



  group('UserModel.toJson', () {


    test('stores user session payload without token', () {


      final user = UserModel.fromJson({

        'id': 2,

        'full_name': 'Ahmed',

        'email': 'test@test.com',

        'role': 'employee',

        'position': 'Developer',

        'remaining_leave_balance': 20,

        'permission_hours': 5,

        'token': 'secret',

      });


      final json = user.toJson();


      expect(
        json.containsKey('token'),
        false,
      );


      expect(
        json['full_name'],
        'Ahmed',
      );


      expect(
        json['role'],
        'employee',
      );

    });

  });


  test('initial returns safe defaults', () {

    final user = UserModel.initial();


    expect(
      user.id,
      '',
    );


    expect(
      user.role,
      '',
    );


    expect(
      user.remainingLeaveBalance,
      0,
    );


    expect(
      user.permissionHours,
      0,
    );

  });

}