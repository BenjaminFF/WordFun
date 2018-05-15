package Test;

import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ClientServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        JSONObject jsonObject = new JSONObject();
        if (cookies == null) {
            jsonObject.put("Status", "false");
        } else {
            String username=null;
            String password=null;
            for (int i = 0; i < cookies.length; i++) {
                if ("username".equals(cookies[i].getName())) {
                    username = cookies[i].getValue();
                } else if ("password".equals(cookies[i].getName())) {
                    password = cookies[i].getValue();
                }
            }
            try {
                if(username==null){
                    jsonObject.put("loginurl","index.jsp");
                    jsonObject.put("Status", "false");
                }else if(DbUtil.queryUser(username).equals(password)){
                    jsonObject.put("Status", "true");
                    jsonObject.put("username",username);
                    DbUtil.getTablesByDB(username);
                }else {
                    jsonObject.put("loginurl","index.jsp");
                    jsonObject.put("Status", "false");
                }
                resp.getWriter().write(jsonObject.toString());
                //System.out.println(username);
                //System.out.println(password);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }
}
