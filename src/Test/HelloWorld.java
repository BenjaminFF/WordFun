package Test;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class HelloWorld extends HttpServlet {

    private String message;
    @Override
    public void init() throws ServletException {
        // 执行必需的初始化
        message = "Hello World";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 设置响应内容类型
        resp.setContentType("text/html");

        // 实际的逻辑是在这里
        PrintWriter out = resp.getWriter();
        out.println("<h1>" + message + "</h1>");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        if(req.getParameter("username").toString().length()!=0){
            try {
                out.write("true");
            }catch (Exception e){
                e.printStackTrace();
            }finally {
                out.close();
            }
        }else {
            try {
                out.write("false");
            }catch (Exception e){
                e.printStackTrace();
            }finally {
                out.close();
            }
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
