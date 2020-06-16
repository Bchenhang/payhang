package com.weixin.pay;

import com.alibaba.fastjson.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PayApplicationTests  extends Thread{
    public void run() {
        for(int i=0;i<=20;i++){
            System.out.println(i+".线程名称"+
                    Thread.currentThread().getName());
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("code",2);
            jsonObject.put("opid",5);
            jsonObject.put("appid",6);
            jsonObject.put("name","hang");
            jsonObject.put("hang",8);
        }
    }

    @Test
    public void contextLoads() {
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",1);
        jsonObject.put("opid","wocaonima");
        PayApplicationTests t1=new PayApplicationTests();
        t1.start();//线程1


    }

}
