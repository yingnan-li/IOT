/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Entity.Officer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author user
 */
public class OfficerDAO {
    
    private final String PHONE_NUM_COL = "phone_num";
    private final String NAME_COL = "name";
    
    public List<Officer> getAvailableOfficerList(){
        List<Officer> officerList = new ArrayList<>();
        
        String sqlQuery="SELECT * FROM officer where status='on'";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
            ResultSet results = ps.executeQuery();
            while(results.next()){
                String phoneNum = results.getString(PHONE_NUM_COL); 
                String name = results.getString(NAME_COL);
                Officer officer = new Officer(phoneNum, name);
                officerList.add(officer);
                
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(BeaconPiDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return officerList;
        
    }
}
