package com.rte.leafguard.repository;

import com.rte.leafguard.model.SensorReading;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Repository
public class SensorRepository {

    private final Map<String, SensorReading> store = new ConcurrentHashMap<>();

    public SensorReading save(SensorReading reading) {
        store.put(reading.getSensorId(), reading);
        return reading;
    }

    public List<SensorReading> findAll() {
        return new ArrayList<>(store.values());
    }

    public SensorReading findById(String sensorId) {
        return store.get(sensorId);
    }

    public int count() {
        return store.size();
    }
}
