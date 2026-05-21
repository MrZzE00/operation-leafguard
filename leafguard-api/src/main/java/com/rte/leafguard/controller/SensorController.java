package com.rte.leafguard.controller;

import com.rte.leafguard.model.SensorReading;
import com.rte.leafguard.service.SensorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/sensors")
public class SensorController {

    private final SensorService sensorService;

    public SensorController(SensorService sensorService) {
        this.sensorService = sensorService;
    }

    @PostMapping("/process")
    public ResponseEntity<SensorReading> process(@RequestBody SensorReading reading) {
        SensorReading result = sensorService.processReading(reading);
        return ResponseEntity.ok(result);
    }

    @GetMapping
    public ResponseEntity<List<SensorReading>> getAll() {
        return ResponseEntity.ok(sensorService.getAllReadings());
    }

    @GetMapping("/{id}")
    public ResponseEntity<SensorReading> getById(@PathVariable String id) {
        return ResponseEntity.ok(sensorService.getReading(id));
    }
}
