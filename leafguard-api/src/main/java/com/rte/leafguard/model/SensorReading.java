package com.rte.leafguard.model;

import java.time.LocalDateTime;

public class SensorReading {

    private String sensorId;
    private double value;
    private LocalDateTime timestamp;
    private String location;
    private String type;

    public SensorReading() {}

    public SensorReading(String sensorId, double value, LocalDateTime timestamp,
                         String location, String type) {
        this.sensorId = sensorId;
        this.value = value;
        this.timestamp = timestamp;
        this.location = location;
        this.type = type;
    }

    public String getSensorId() { return sensorId; }
    public void setSensorId(String sensorId) { this.sensorId = sensorId; }
    public double getValue() { return value; }
    public void setValue(double value) { this.value = value; }
    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
}
