package sample.dtos;

import com.google.gson.annotations.*;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ASUS
 */
public class UserDTO {
    @SerializedName(value = "id")
    private String userID;
    
    private String password;
    @SerializedName(value = "name")
    private String name;
    private String roleID, phone, address;

    public UserDTO() {
    }

    public UserDTO(String userID, String password, String name, String roleID, String phone, String address) {
        this.userID = userID;
        this.password = password;
        this.name = name;
        this.roleID = roleID;
        this.phone = phone;
        this.address = address;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    
}
