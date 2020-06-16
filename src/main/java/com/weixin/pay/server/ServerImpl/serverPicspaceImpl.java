package com.weixin.pay.server.ServerImpl;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.util.Auth;
import com.qiniu.util.Base64;
import com.qiniu.util.StringMap;
import com.qiniu.util.UrlSafeBase64;
import com.weixin.pay.dao.PicspaceDao;
import com.weixin.pay.pojo.picspace;
import  com.weixin.pay.server.serverPicspace;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;

@Slf4j
@Service
public class serverPicspaceImpl implements serverPicspace {
    @Resource
    private PicspaceDao picspaceDao;

    //上传图片到七牛云
    String ak = "OQn06yg8ebBqsecIhVJsSu8zD-vjlQQNkY44Bwgv";     // 钥匙配置
    String sk = "38LlkwAad63fm3zx-5MEgAeIa5oCHsEcSHRQ9gV7";    // 密钥配置
    String bucketname = "xiyunserver";    //空间名


    //查询图片配置参数
    public picspace selectPicspase(String bucket){
        picspace picspace=picspaceDao.selectPicspase(bucket);
        return picspace;
    }

    //获取token
    public String getUpToken(String ak,String sk,String bucketname) {
        Auth auth = Auth.create(ak, sk);    // TODO Auto-generated constructor stub
        return auth.uploadToken(bucketname, null, 3600, new StringMap().put("insertOnly", 1));
    }
    public String put64image(String file641,String ak,String sk,String bucketname,String key) throws Exception {
        /*StringBuffer key = new StringBuffer("url\\appid\\user\\iccid.jpg");*/    //上传的图片名
        String file64 = file641.substring(file641.indexOf(",")+1);
        String url = "http://upload-z2.qiniup.com/putb64/-1/key/"+ UrlSafeBase64.encodeToString(key.toString());
        //非华东空间需要根据注意事项 1 修改上传域名
        RequestBody rb = RequestBody.create(null, file64);
        Request request = new Request.Builder().
                url(url).
                addHeader("Content-Type", "application/octet-stream")
                .addHeader("Authorization", "UpToken " + getUpToken(ak,sk,bucketname))
                .post(rb).build();
        System.out.println("2="+request.headers());
        OkHttpClient client = new OkHttpClient();
        okhttp3.Response response = client.newCall(request).execute();
        System.out.println("3="+response.toString());
        return response.toString();
    }
   public String deleteimage(String ak,String sk,String bucketname,String key){
        String code="";
       Auth auth = Auth.create(ak, sk);
       Configuration config = new Configuration(Zone.autoZone());
       BucketManager bucketMgr = new BucketManager(auth, config);
       //指定需要删除的文件，和文件所在的存储空间
       try {
           Response delete = bucketMgr.delete(bucketname, key);
           delete.close();
           code="OK";
       }catch (Exception e){
           code="NO";
       }
        return code;
    }
}
