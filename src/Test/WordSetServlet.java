package Test;

import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class WordSetServlet extends HttpServlet{

    private HashMap<String,String> WordSet=new HashMap<>();
    @Override
    public void init() throws ServletException {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String userdata=req.getParameter("mydata");
        String title=req.getParameter("title");
        String timestamp=req.getParameter("timestamp");
        try {
            JSONArray jsonArray=new JSONArray(userdata);
            for(int i=0;i<jsonArray.length();i++){
                JSONObject jsonObject=jsonArray.getJSONObject(i);
                String word=jsonObject.getString("word");
                String explain=jsonObject.getString("explain");
                WordSet.put(word,explain);

                Iterator iterator=WordSet.entrySet().iterator();
                while (iterator.hasNext()){
                    Map.Entry entry=(Map.Entry)iterator.next();
                    String myword=(String)entry.getKey();
                    String myexplain=(String)entry.getValue();
                    System.out.println(myword+":"+myexplain);
                }
                WordSet.clear();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}

