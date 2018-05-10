package Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
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
        return "noUser";

    }
}
