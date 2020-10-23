package sample.utilities;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.log4j.PropertyConfigurator;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author ASUS
 */
public class ContextListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent event) {
        String log4jConfigFile = "D:\\FPT\\CN5\\LAB231\\Yellow Moon Shop\\src\\java\\sample\\properties\\log4j.properties";
        PropertyConfigurator.configure(log4jConfigFile);
    }

    public void contextDestroyed(ServletContextEvent sce) {

    }

}
