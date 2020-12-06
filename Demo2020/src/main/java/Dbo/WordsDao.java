package Dbo;

import Control.Words;
import JDBC.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WordsDao {
    public static Words getWord(ResultSet resultSet) throws SQLException {
        String Szm=resultSet.getString("Szm");
        String Word=resultSet.getString("words");
        String Meaning=resultSet.getString("Meaning");
        String Example=resultSet.getString("Example");
        Words allwords=new Words();
        allwords.setSzm(Szm);
        allwords.setWord(Word);
        allwords.setMeaning(Meaning);
        allwords.setExample(Example);
        return allwords;
    }
    public static List<Words> getWords(int page, int limit){
        List<Words> words = new ArrayList<Words>();
        try {
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareCall("select * from english limit ?,?");
            statement.setInt(1,(page-1)*limit);
            statement.setInt(2,limit);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Words allwords=getWord(resultSet);
                words.add(allwords);
            }
            DBUtil.close(resultSet, statement, connection);
            return words;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static List<Words> getWords()
    {
        return getWords(1, 10);
    }
    public static List<Words> getWords1(){ return getWords(1, Integer.MAX_VALUE); }

        public static Words getWBywords(String words){
        Connection connection =DBUtil.getConnection();
        String sql="select * from english where words=?";
        PreparedStatement statement;
        ResultSet resultSet = null;
        Words allword=null;
        try{
            statement=connection.prepareCall(sql);
            statement.setString(1,words);
            resultSet= statement.executeQuery();
            if(resultSet !=null &&resultSet.next()){
                allword=getWord(resultSet);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return allword;
    }
    public static int delWByWords(String words){
        Connection connection=DBUtil.getConnection();
        String sql ="delete from english where words=?";
        int rows =0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            statement.setString(1,words);
            rows= statement.executeUpdate();
            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }

    public static int updataWords(Words words){
        Connection connection=DBUtil.getConnection();
        String sql ="update english set Szm=?,Meaning=?,Example=? where words=?";
        int rows=0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            statement.setString(1,words.getSzm());
            statement.setString(2,words.getMeaning());
            statement.setString(3,words.getExample());
            statement.setString(4,words.getWord());

            rows=statement.executeUpdate();
            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }

    public static int addWords(Words words){
        Connection connection=DBUtil.getConnection();
        String sql ="insert into english (Szm,words,Meaning,Example) values(?,?,?,?)";
        int rows=0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            statement.setString(1,words.getSzm());
            statement.setString(2,words.getWord());
            statement.setString(3,words.getMeaning());
            statement.setString(4,words.getExample());

            rows=statement.executeUpdate();
            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }
    public static int getCount(){
        Connection connection=DBUtil.getConnection();
        String sql ="select count(*) as Count from english";
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
        System.out.println("*******连接数据库*******");
    }
}
