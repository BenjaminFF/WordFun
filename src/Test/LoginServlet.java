package Test;

import org.json.JSONObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
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
        PrintWriter out = resp.getWriter();
        String username=req.getParameter("username");
        try {
            JSONObject jsonObject=new JSONObject();
            if (DbUtil.queryUser(username).equals("noUser")){
                jsonObject.put("Status","noUser");
                Cookie cookie1=new Cookie("username","");
                resp.addCookie(cookie1);
            }else {
                String password=req.getParameter("password");
                if(password.equals(DbUtil.queryUser(username))){  //queryUser返回密码
                    jsonObject.put("Status","true");
                    jsonObject.put("url","client.jsp");
                    Cookie cookie1=new Cookie("username",username);
                    Cookie cookie2=new Cookie("password",password);
                    resp.addCookie(cookie1);
                    resp.addCookie(cookie2);
                    //123456Wa1.
                }else {
                    jsonObject.put("Status","false");
                    Cookie cookie1=new Cookie("username","");
                    resp.addCookie(cookie1);
                }
            }
            out.write(jsonObject.toString());
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            out.close();
        }
    }
}
