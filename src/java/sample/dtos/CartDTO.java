/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.sql.Date;
import java.util.HashMap;

/**
 *
 * @author ASUS
 */
public class CartDTO {

    private String id;
    private HashMap<String, ProductDTO> cart;
    private int total;
    private String userID;
    private String name, phone, address;
    private Date date;
    private String paymentMethod;
    private int paymentStatus;

    public CartDTO() {
        cart = new HashMap<String, ProductDTO>();
        total = 0;
        userID = null;
        paymentMethod = "Cash";
        paymentStatus = 4;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
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

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    
    public HashMap<String, ProductDTO> getCart() {
        return cart;
    }

    public void setCart(HashMap<String, ProductDTO> cart) {
        this.cart = cart;
    }

    public void add(ProductDTO product) {
        String id = product.getId();
        int quantity = 1;
        if (cart.containsKey(id)) {
            quantity = cart.get(id).getQuantity() + 1;
        }
        product.setQuantity(quantity);
        total += product.getPrice();
        cart.put(id, product);
    }

    public void update(String id, int quantity) {
        for (String productID : cart.keySet()) {
            if (productID.equals(id)) {
                int amount = cart.get(id).getQuantity();
                cart.get(id).setQuantity(quantity);
                total += (quantity - amount) * cart.get(id).getPrice();
                break;
            }
        }
    }

    public void remove(String id) {
        for (ProductDTO product : cart.values()) {
            if (product.getId().equals(id)) {
                total -= product.getQuantity() * product.getPrice();
                break;
            }
        }
        cart.remove(id);
    }
}
