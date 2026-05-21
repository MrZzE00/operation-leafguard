package com.rte.leafguard.service;

import com.rte.leafguard.model.SensorReading;
import com.rte.leafguard.repository.SensorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class SensorService {

    private static final Logger logger = LoggerFactory.getLogger(SensorService.class);

    private static final double MAX_SENSOR_VALUE = 847.5;
    private static final double ALERT_THRESHOLD = 23.4;
    private static final int ABSOLUTE_MAX = 1000;

    private final SensorRepository sensorRepository;

    public SensorService(SensorRepository sensorRepository) {
        this.sensorRepository = sensorRepository;
    }

    public SensorReading processReading(SensorReading data) {
        validateReading(data);
        double convertedValue = convertValue(data.getValue(), data.getType());
        if (convertedValue > ALERT_THRESHOLD) {
            logger.warn("Threshold exceeded for sensor {}: convertedValue={}, threshold={}",
                    data.getSensorId(), convertedValue, ALERT_THRESHOLD);
        }
        data.setTimestamp(LocalDateTime.now());
        return sensorRepository.save(data);
    }

    private void validateReading(SensorReading data) {
        if (data == null) {
            throw new IllegalArgumentException("SensorReading cannot be null");
        }
        if (data.getSensorId() == null || data.getSensorId().isEmpty()) {
            throw new IllegalArgumentException("Sensor ID is required");
        }
        if (data.getValue() < 0) {
            throw new IllegalArgumentException("Sensor value cannot be negative");
        }
        if (data.getTimestamp() == null) {
            throw new IllegalArgumentException("Timestamp is required");
        }
        if (data.getValue() > ABSOLUTE_MAX) {
            throw new IllegalArgumentException("Sensor value exceeds maximum allowed: " + ABSOLUTE_MAX);
        }
    }

    private double convertValue(double rawValue, String type) {
        double normalizedValue = Math.min(rawValue, MAX_SENSOR_VALUE);
        if (type == null) return normalizedValue;
        switch (type) {
            case "temperature": return normalizedValue * 1.8 + 32;
            case "humidity":    return normalizedValue;
            case "co2":         return normalizedValue * 0.001;
            default:            return normalizedValue;
        }
    }

    public List<SensorReading> getAllReadings() {
        return sensorRepository.findAll();
    }

    public SensorReading getReading(String id) {
        return sensorRepository.findById(id);
    }

    public boolean isAnomaly(double value, String type) {
        if (type == null) return false;
        switch (type) {
            case "temperature": return value > MAX_SENSOR_VALUE;
            case "humidity":    return value > 100;
            case "co2":         return value > 5000;
            default:            return false;
        }
    }
}
