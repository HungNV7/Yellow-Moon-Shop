/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utilities;
import com.google.gson.Gson;
import org.apache.log4j.Logger;
import sample.dtos.UserDTO;
/**
 *
 * @author ASUS
 */
public class APIWrapper {
    private static String appID = "534319810768769";
    private static String appSecret = "461c59beac29baceeaac919d4d9694cb";
    private static String redirectUrl = "http://localhost:8080/Yellow_Moon_Shop/facebook";
    private Logger logger = Logger.getLogger(APIWrapper.class.getName());
    private String accessToken;
    private Gson gson;

    public APIWrapper() {
        gson = new Gson();
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public Gson getGson() {
        return gson;
    }

    public void setGson(Gson gson) {
        this.gson = gson;
    }
    
    public String getAccessToken(String code){
        String accessTokenLink = "https://graph.facebook.com/oauth/access_token?"
                + "client_id=%s"
                + "&client_secret=%s"
                + "&redirect_uri=%s"
                + "&code=%s";
        accessTokenLink = String.format(accessTokenLink, appID, appSecret, redirectUrl, code);
        String token = "";
        try {
            String result = NetUtils.getResult(accessTokenLink);
            token = result.substring(result.indexOf(":") + 2, result.indexOf(",") - 1);
        } catch (Exception e) {
            logger.error("Error in APIWrapper_getAccessToken:" + e);
        }
        return token;
    }
    
    public UserDTO getUser(){
        String url = "https://graph.facebook.com/me?access_token=%s";
        url = String.format(url, this.accessToken);
        UserDTO user = null;
        try {
            String result = NetUtils.getResult(url);
            user = gson.fromJson(result, UserDTO.class);
        } catch (Exception e) {
            logger.error("Error in APIWrapper_getUser: " + e);
        }
        return user;
    }
}
