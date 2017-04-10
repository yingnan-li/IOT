/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.util.ArrayList;

/**
 *
 * @author user
 */
public class Trolley {
    private int trolleyID;
    private String datetime;

    public Trolley(int trolleyID, String datetime) {
        this.trolleyID = trolleyID;
        this.datetime = datetime;
    }

    public int getTrolleyID() {
        return trolleyID;
    }

    public void setTrolleyID(int trolleyID) {
        this.trolleyID = trolleyID;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

}
