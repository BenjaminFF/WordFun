package Test;

import java.sql.*;
import java.util.ArrayList;

public class DbUtil {

    public static final  String URL="jdbc:mysql://127.0.0.1:3306/guessword?serverTimezone=Asia/Shanghai";
    public static final String USER = "root";
    public static final String PASSWORD = "Iamaman886.";

    public static String queryUser(String username) throws Exception {
        //1.加载驱动程序
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2. 获得数据库连接
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        //3.操作数据库，实现增删改查
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM userdata " +
                        "WHERE username="+"'"+username+"'");

        while (rs.next()){
            return rs.getString("password");
        }
        if (stmt!=null){
            conn.close();
        }
        return "noUser";
    }

    public static void CreateTable(String tableName) throws Exception{
        //1.加载驱动程序
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2. 获得数据库连接
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        //3.操作数据库，实现增删改查
        Statement stmt = conn.createStatement();

        String sql = "CREATE TABLE " + tableName +
                "(id INTEGER not NULL auto_increment, " +
                " myword VARCHAR(255), " +
                " myexplain VARCHAR(255), " +
                " PRIMARY KEY ( id ))";

        stmt.executeUpdate(sql);

        if (stmt!=null){
            conn.close();
        }
    }

    public static void CreateAndInsert(String tableName,String insertSql) throws Exception{
        //1.加载驱动程序
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2. 获得数据库连接
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        //3.操作数据库，实现增删改查
        Statement stmt = conn.createStatement();

        String createSql = "CREATE TABLE " + tableName +
                "(id INTEGER not NULL auto_increment, " +
                " myword VARCHAR(255), " +
                " myexplain VARCHAR(255), " +
                " PRIMARY KEY ( id ))";

        stmt.executeUpdate(createSql);

        stmt.executeUpdate(insertSql);
        if (stmt!=null){
            conn.close();
        }
    }

    public static void getTablesByDB(String dbname) throws Exception{
        String myurl="jdbc:mysql://127.0.0.1:3306/?serverTimezone=Asia/Shanghai";
        //1.加载驱动程序
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2. 获得数据库连接
        Connection conn = DriverManager.getConnection(myurl, USER, PASSWORD);

        String sql="select * from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='"+
                dbname+"';";

        Statement statement=conn.createStatement();


        ResultSet a=statement.executeQuery(sql);

        while (a.next()){
            System.out.println(a.getString("Table_name"));
        }
    }
}
