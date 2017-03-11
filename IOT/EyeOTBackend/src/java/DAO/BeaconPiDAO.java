/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author user
 */
public class BeaconPiDAO {
    
    public int insertIntoBeaconPi(String beaconID,String piID, long timestamp, double distance){
        int rowInserted=0;
        String sqlQuery="insert into beaconpi_proximity values (?,?,?,?, (select TrolleyID from trolleybeacon where BeaconID=?))";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            ps.setString(1, beaconID);
            ps.setString(2, piID);
            Timestamp ts = new Timestamp(timestamp);
            ps.setTimestamp(3,ts);
            ps.setDouble(4, distance);
            ps.setString(5,beaconID);
            rowInserted = ps.executeUpdate();
          
        } catch (SQLException ex) {
            Logger.getLogger(BeaconPiDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rowInserted;
        
    }
}
