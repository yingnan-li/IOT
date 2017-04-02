/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BeaconDAO;
import DAO.Trolleypi_beacon_eventDAO;
import Entity.Beacon;
import Entity.Trolleypi_beacon_event;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Jason
 */
@WebServlet(name = "RetrieveDailyTriggeredAlarm", urlPatterns = {"/RetrieveDailyTriggeredAlarm"})
public class RetrieveDailyTriggeredAlarm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Declaration
        PrintWriter out = response.getWriter();
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        JsonArray dailyRecordList = new JsonArray();
        
        BeaconDAO beaconDAO = new BeaconDAO();
        Trolleypi_beacon_eventDAO trolleypi_beacon_eventDAO = new Trolleypi_beacon_eventDAO();
        String[] timestampInHour = new String[24];
        
        for(int i = 0; i < 24; i++){
            if(i < 10){
                timestampInHour[i] = "0" + i;
            } else {
                timestampInHour[i] = "" + i;
            }
        }
        
        for(String hour : timestampInHour){
            JsonObject timeObject = new JsonObject();            
            JsonArray exitArray = new JsonArray();
            
            // get all exits
            for(Beacon beacon : beaconDAO.getAllExitBeaconDetails()){ // every beacon is an exit
                JsonArray trolleyArray = new JsonArray();
                JsonObject exitObject = new JsonObject();
                String exit = beacon.getLocation();
                for(Trolleypi_beacon_event beacon_event : trolleypi_beacon_eventDAO.getAllBeaconEvent()){
                    if(hour.equalsIgnoreCase(beacon_event.getTimestamp())){
                        JsonObject trolleyObject = new JsonObject();
                        //get beacon location
                        String locationOfBeaconEvent = beaconDAO.getBeaconDetails(beacon_event.getBeaconID()).getLocation();
                        System.out.println(exit);
                        System.out.println(locationOfBeaconEvent);
                        if(exit.equalsIgnoreCase(locationOfBeaconEvent)){
                            trolleyObject.addProperty("Trolley_Name", beacon_event.getTrolleyID());
                            trolleyObject.addProperty("Timestamp", beacon_event.getTime());
                            trolleyArray.add(trolleyObject);
                        }
                    }    
                }
                exitObject.add(exit, trolleyArray);
                exitArray.add(exitObject);
            }            
            timeObject.add(hour, exitArray);
            dailyRecordList.add(timeObject);
        }
        
        out.println(gson.toJson(dailyRecordList));
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
