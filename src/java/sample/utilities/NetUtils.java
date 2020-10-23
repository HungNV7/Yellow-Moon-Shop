/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utilities;
import java.io.IOException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.ClientProtocolException;
/**
 *
 * @author ASUS
 */
public class NetUtils {
    public static String getResult(String url) throws IOException, ClientProtocolException{
            return Request.Get(url).setHeader("Accept-Charset", "utf-8").execute().returnContent().asString();
    }
}
