/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

/**
 *
 * @author ASUS
 */
public class ErrorProductDTO {
    private String errorName, errorDescription, errorLinkImage, errorCreateDate, errorExpirateDate, errorPrice, errorQuantity;

    public ErrorProductDTO() {
    }

    public ErrorProductDTO(String errorName, String errorDescription, String errorLinkImage, String errorCreateDate, String errorExpirateDate, String errorPrice, String errorQuantity) {
        this.errorName = errorName;
        this.errorDescription = errorDescription;
        this.errorLinkImage = errorLinkImage;
        this.errorCreateDate = errorCreateDate;
        this.errorExpirateDate = errorExpirateDate;
        this.errorPrice = errorPrice;
        this.errorQuantity = errorQuantity;
    }

    public String getErrorName() {
        return errorName;
    }

    public void setErrorName(String errorName) {
        this.errorName = errorName;
    }

    public String getErrorDescription() {
        return errorDescription;
    }

    public void setErrorDescription(String errorDescription) {
        this.errorDescription = errorDescription;
    }

    public String getErrorLinkImage() {
        return errorLinkImage;
    }

    public void setErrorLinkImage(String errorLinkImage) {
        this.errorLinkImage = errorLinkImage;
    }

    public String getErrorCreateDate() {
        return errorCreateDate;
    }

    public void setErrorCreateDate(String errorCreateDate) {
        this.errorCreateDate = errorCreateDate;
    }

    public String getErrorExpirateDate() {
        return errorExpirateDate;
    }

    public void setErrorExpirateDate(String errorExpirateDate) {
        this.errorExpirateDate = errorExpirateDate;
    }

    public String getErrorPrice() {
        return errorPrice;
    }

    public void setErrorPrice(String errorPrice) {
        this.errorPrice = errorPrice;
    }

    public String getErrorQuantity() {
        return errorQuantity;
    }

    public void setErrorQuantity(String errorQuantity) {
        this.errorQuantity = errorQuantity;
    }
    
}
