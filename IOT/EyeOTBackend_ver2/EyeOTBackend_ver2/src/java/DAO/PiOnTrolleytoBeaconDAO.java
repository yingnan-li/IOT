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
public class PiOnTrolleytoBeaconDAO {

    public int insertTrolleyAlarmEvent(String beaconID, String piID, long timestamp) {
        int rowInserted = 0;
        String sqlQuery = "insert into trolleypi_beacon_event values (?,(select TrolleyID from pi_on_trolley where PiID=?),?,?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            ps.setString(1, piID);
            ps.setString(2, piID);
            ps.setString(3, beaconID);
            Timestamp ts = new Timestamp(timestamp);
            ps.setTimestamp(4, ts);
            rowInserted = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rowInserted;

    }
}
