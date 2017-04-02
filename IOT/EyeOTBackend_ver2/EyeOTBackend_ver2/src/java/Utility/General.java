/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utility;

/**
 *
 * @author user
 */
public class General {
    private String apiKey = "0r9RAGF2op";
    private String username = "chuqiankoh";
    
    
    public String sendSMS(String phoneNum, String msg)
   {
       String url = "https://www.textmagic.com/app/api?"+
               "username="+username+"&password="+apiKey+"&cmd=send&text="+
               msg+"&phone="+phoneNum+"&unicode=1";
           
       return url;
   }
    
    
    
    
}
