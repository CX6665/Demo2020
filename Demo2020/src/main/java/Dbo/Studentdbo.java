package Dbo;

import Control.student;
import JDBC.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Studentdbo {
    public static student getStudent(ResultSet resultSet) throws SQLException{
        String name = resultSet.getString("name");
        String sex = resultSet.getString("Sex");
        String age = resultSet.getString("Age");
        String foulor = resultSet.getString("Foulor");
        String id =resultSet.getString("id");
        student student1 = new student();
        student1.setName(name);
        student1.setSex(sex);
        student1.setAge(age);
        student1.setFoulor(foulor);
        student1.setId(id);
        return student1;
    }
    public static List<student> getStudents(int page,int limit){
        List<student> students = new ArrayList<student>();
        try {
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareCall("select * from student1 limit ?,?");
            statement.setInt(1,(page-1)*limit);
            statement.setInt(2,limit);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                student student1=getStudent(resultSet);
                students.add(student1);
            }
            DBUtil.close(resultSet, statement, connection);
            return students;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static List<student> getStudents()
    {
        return getStudents(1, 10);
    }
    public static List<student> getStudents1()
    {
        return getStudents(1, Integer.MAX_VALUE);
    }
//2020/11/20
    //SQL注入
    public static student getStuByID(String ID){
        Connection connection =DBUtil.getConnection();
        String sql="select * from student1 where id=?";
        PreparedStatement statement;
        ResultSet resultSet = null;
        student student1=null;
        try{
            statement=connection.prepareCall(sql);
            //设置SQL参数
            statement.setString(1,ID);
            resultSet= statement.executeQuery();
            if(resultSet !=null &&resultSet.next()){
                student1=getStudent(resultSet);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return student1;
    }
    public static int delStudentByID(String id){
        Connection connection=DBUtil.getConnection();
        String sql ="delete from student1 where id=?";
        int rows =0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            statement.setString(1,id);
            rows= statement.executeUpdate();
            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }

    public static int updataStudent(student studets){
        Connection connection=DBUtil.getConnection();
        String sql ="update student1 set name=?,Sex=?,Age=?,Foulor=? where id=?";
        int rows=0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            statement.setString(1,studets.getName());
            statement.setString(2,studets.getSex());
            statement.setString(3,studets.getAge());
            statement.setString(4,studets.getFoulor());
            statement.setString(5,studets.getId());

            rows=statement.executeUpdate();
            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }

    public static int addStudent(student students){
        Connection connection=DBUtil.getConnection();
        String sql ="insert into student1 (name,Sex,Age,Foulor,id) values(?,?,?,?,?)";
        int rows=0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            statement.setString(1,students.getName());
            statement.setString(2,students.getSex());
            statement.setString(3,students.getAge());
            statement.setString(4,students.getFoulor());
            statement.setString(5,students.getId());

            rows=statement.executeUpdate();
            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }
    public static int getCount(){
        Connection connection=DBUtil.getConnection();
        String sql ="select count(*) as count from student1";
        int rows=0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            ResultSet resultSet =statement.executeQuery();
            if(resultSet.next())
                rows= resultSet.getInt(1);


            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }


    //仅测试入口
   public static void main(String[] args) throws SQLException {
        student student1 =getStuByID("1");
        System.out.println(student1);
   }

}
