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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
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
            throws ServletException, IOException, ParseException {
        
        String current_date = request.getParameter("date");
//        current_date = "2017-04-03 17:36:02";
        
        // Declaration
        PrintWriter out = response.getWriter();
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        JsonArray dailyRecordList = new JsonArray();
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
        
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
                int count = 0;
                JsonArray trolleyArray = new JsonArray();
                JsonObject exitObject = new JsonObject();
                String exit = beacon.getLocation();
                JsonObject trolleyObject = new JsonObject();
                for(Trolleypi_beacon_event beacon_event : trolleypi_beacon_eventDAO.getAllBeaconEvent()){
//                    System.out.println("beacon event " + (hour.equalsIgnoreCase( f.parse(beacon_event.getTimestamp()).getHours()+"" )));
//                    System.out.println("date " + (f.parse(beacon_event.getTimestamp()).getDate() == new Date().getDate()));
//                    if(hour.equalsIgnoreCase( f.parse(beacon_event.getTimestamp()).getHours()+"" ) && f.parse(beacon_event.getTimestamp()).getDate() == new Date().getDate()){
                    if(hour.equalsIgnoreCase( addZeros(f.parse(beacon_event.getTimestamp()).getHours()) ) && f.parse(beacon_event.getTimestamp()).getDate() == f.parse(current_date).getDate()){
//                        JsonObject trolleyObject = new JsonObject();
                        //get beacon location
                        String locationOfBeaconEvent = beaconDAO.getBeaconDetails(beacon_event.getBeaconID()).getLocation();
                        if(exit.equalsIgnoreCase(locationOfBeaconEvent)){
//                            trolleyObject.addProperty("Trolley_Name", beacon_event.getTrolleyID());
//                            trolleyObject.addProperty("Timestamp", beacon_event.getTime());
                            trolleyObject.addProperty("occurence", ++count);
//                            trolleyArray.add(trolleyObject);
                        }
                    }    
                }
                trolleyArray.add(trolleyObject);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(RetrieveDailyTriggeredAlarm.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(RetrieveDailyTriggeredAlarm.class.getName()).log(Level.SEVERE, null, ex);
        }
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
private String addZeros(int time)
    {
        String newTime = time+"";
        if(time<10)
        {
             newTime = "0"+time;
        }
        return newTime;
    }
}
