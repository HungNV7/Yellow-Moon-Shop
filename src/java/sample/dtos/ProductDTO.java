/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class ProductDTO {
    private String id, name, description, linkImage, categoryID;
    private Date createDate, expirateDate;
    private int price, quantity;
    private int status;

    public ProductDTO() {
    }

    public ProductDTO(String id, String name, String description, String linkImage, String categoryID, Date createDate, Date expirateDate, int price, int quantity, int status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.linkImage = linkImage;
        this.categoryID = categoryID;
        this.createDate = createDate;
        this.expirateDate = expirateDate;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
    }
    
    public ProductDTO(String id, String name, int price, int quantity){
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLinkImage() {
        return linkImage;
    }

    public void setLinkImage(String linkImage) {
        this.linkImage = linkImage;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getExpirateDate() {
        return expirateDate;
    }

    public void setExpirateDate(Date expirateDate) {
        this.expirateDate = expirateDate;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
}
