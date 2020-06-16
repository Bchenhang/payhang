package com.weixin.pay.utils;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@Slf4j
public class HttpClientUtils {

private static final String ENCODING = "UTF-8";

private final static Logger logger = LoggerFactory.getLogger(HttpClientUtils.class);


/**
 * Post JOSN
 * @param url
 * @param json
 * @return
 */
public static String post(String url, String json) {
        StringBuffer requestText = new StringBuffer();
        CloseableHttpResponse response = null;//用来接收 post 返回的信息
        CloseableHttpClient client = null;
        HttpPost httpPost = new HttpPost(url);
        StringEntity entityParams = null;
        try {
        entityParams = new StringEntity(json, "utf-8");
        httpPost.setEntity(entityParams);
        httpPost.setHeader("Content-Type", "application/json");
        client = HttpClients.createDefault();
        response = client.execute(httpPost);
        byte[] x = EntityUtils.toByteArray(response.getEntity());
        requestText.append(new String(x, "utf-8"));
        } catch (Exception e) {
                requestText.append("ON");
                log.error("post请求异常,异常原因 mas={}",e.getMessage(),e);
        } finally {
        logger.info("Request=" + requestText.toString());
         httpPost.releaseConnection();
        }
        return requestText.toString();
        }

/**
 * 基于HttpClient 4.5的通用GET方法
 *
 * @param url       提交的URL
 * @return 提交响应
 */
public static String get(String url) throws RuntimeException {
        CloseableHttpClient client = HttpClients.createDefault();
        String responseText = "";
        CloseableHttpResponse response = null;
        try {
        HttpGet get = new HttpGet(url);
        response = client.execute(get);
        HttpEntity entity = response.getEntity();
        if (entity != null) {
        responseText = EntityUtils.toString(entity, ENCODING);
        }
        } catch (Exception e) {
        throw new RuntimeException(e);
        } finally {
        try {
        if (response != null)
        response.close();
        } catch (Exception e) {
         log.error("get请求异常,异常原因 mas={}",e.getMessage(),e);
        }
        }
        return responseText;
        }

        }

