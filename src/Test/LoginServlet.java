package Test;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class LoginServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        String username=req.getParameter("username");
        try {
            if (DbUtil.queryUser(username).equals("noUser")){
                out.write("noUser");
            }else {
                String password=req.getParameter("password");
                if(password.equals(DbUtil.queryUser(username))){  //queryUser返回密码
                    out.write("true");
                }else {
                    out.write("false");
                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            out.close();
        }
    }
}
