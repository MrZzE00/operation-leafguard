#!/usr/bin/env bash
set -e

# Vérifie qu'on est bien à la racine du repo
if [ ! -d "leafguard-api" ]; then
  echo "❌ ERREUR : lancez ce script depuis la racine du repo (dossier contenant leafguard-api/)"
  exit 1
fi

SERVICE=leafguard-api/src/main/java/com/rte/leafguard/service/SensorService.java
LOG=leafguard-api/logs/app.log

# ─── Injection SensorService.java (version dégradée) ───────────────────────
cat > "$SERVICE" << 'JAVA_EOF'
package com.rte.leafguard.service;

import com.rte.leafguard.model.SensorReading;
import com.rte.leafguard.repository.SensorRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class SensorService {

    private SensorRepository sensorRepository;

    public SensorService(SensorRepository sensorRepository) {
        this.sensorRepository = sensorRepository;
    }

    public SensorReading processReading(SensorReading data) {
        // Validation
        if (data == null) {
            return null;
        }
        boolean flag = false;
        if (data.getSensorId() == null || data.getSensorId().isEmpty()) {
            flag = true;
        }
        if (data.getValue() < 0) {
            flag = true;
        }
        if (data.getTimestamp() == null) {
            flag = true;
        }
        if (flag) {
            return null;
        }

        // Calcul
        double tmp = data.getValue();
        double threshold = 23.4;
        int MAX = 1000;

        if (tmp > 847.5) {
            tmp = 847.5;
        }
        if (tmp > MAX) {
            return null;
        }

        double x = 0;
        if (data.getType() != null && data.getType().equals("temperature")) {
            x = tmp * 1.8 + 32;
        } else if (data.getType() != null && data.getType().equals("humidity")) {
            x = tmp;
        } else if (data.getType() != null && data.getType().equals("co2")) {
            x = tmp * 0.001;
        } else {
            x = tmp;
        }

        if (x > threshold) {
            System.out.println("ALERT: value exceeded threshold for sensor " + data.getSensorId());
        }

        // Persistance
        data.setTimestamp(LocalDateTime.now());
        SensorReading saved = sensorRepository.save(data);
        return saved;
    }

    public List<SensorReading> getAllReadings() {
        return sensorRepository.findAll();
    }

    public SensorReading getReading(String id) {
        return sensorRepository.findById(id);
    }

    public boolean isAnomaly(double value, String type) {
        if (type == null) return false;
        if (type.equals("temperature") && value > 847.5) return true;
        if (type.equals("humidity") && value > 100) return true;
        if (type.equals("co2") && value > 5000) return true;
        return false;
    }
}
JAVA_EOF

# ─── Injection logs/app.log (version dégradée) ─────────────────────────────
cat > "$LOG" << 'LOG_EOF'
2025-05-16 02:47:03.112  INFO  --- [main] com.rte.leafguard.LeafGuardApplication   : Starting LeafGuardApplication v0.1.0
2025-05-16 02:47:03.891  INFO  --- [main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080
2025-05-16 02:47:03.902  INFO  --- [main] com.rte.leafguard.LeafGuardApplication   : Started LeafGuardApplication in 1.823 seconds
2025-05-16 02:47:11.204  INFO  --- [nio-8080-exec-1] c.r.l.controller.SensorController        : Request received
2025-05-16 02:47:11.311 ERROR  --- [nio-8080-exec-1] c.r.l.service.SensorService              : Error occurred
java.lang.NullPointerException: Cannot invoke "String.isEmpty()" because "data.sensorId" is null
	at com.rte.leafguard.service.SensorService.processReading(SensorService.java:34)
	at com.rte.leafguard.controller.SensorController.process(SensorController.java:23)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:897)
2025-05-16 02:47:11.318 ERROR  --- [nio-8080-exec-1] c.r.l.controller.SensorController        : Failed
2025-05-16 02:51:38.005  INFO  --- [nio-8080-exec-3] c.r.l.controller.SensorController        : Request received
2025-05-16 02:51:38.012 ERROR  --- [nio-8080-exec-3] c.r.l.service.SensorService              : Error occurred
java.lang.IllegalArgumentException: null
	at com.rte.leafguard.service.SensorService.processReading(SensorService.java:41)
	at com.rte.leafguard.controller.SensorController.process(SensorController.java:23)
2025-05-16 02:55:02.772  INFO  --- [nio-8080-exec-5] c.r.l.controller.SensorController        : Request received
2025-05-16 02:55:02.779  INFO  --- [nio-8080-exec-5] c.r.l.service.SensorService              : ALERT: value exceeded threshold for sensor SNS-009
2025-05-16 02:55:02.781  INFO  --- [nio-8080-exec-5] c.r.l.service.SensorService              : ALERT: value exceeded threshold for sensor SNS-009
2025-05-16 02:55:02.782  INFO  --- [nio-8080-exec-5] c.r.l.service.SensorService              : ALERT: value exceeded threshold for sensor SNS-009
2025-05-16 03:01:17.334 ERROR  --- [nio-8080-exec-2] c.r.l.service.SensorService              : Error occurred
java.lang.NullPointerException
	at com.rte.leafguard.service.SensorService.isAnomaly(SensorService.java:67)
	at com.rte.leafguard.service.SensorService.processReading(SensorService.java:52)
	at com.rte.leafguard.controller.SensorController.process(SensorController.java:23)
2025-05-16 03:01:17.340 ERROR  --- [nio-8080-exec-2] c.r.l.controller.SensorController        : Failed
2025-05-16 03:12:44.001  INFO  --- [nio-8080-exec-7] c.r.l.controller.SensorController        : Request received
2025-05-16 03:12:44.009  INFO  --- [nio-8080-exec-7] c.r.l.service.SensorService              : ALERT: value exceeded threshold for sensor SNS-014
2025-05-16 03:12:44.011 ERROR  --- [nio-8080-exec-7] c.r.l.service.SensorService              : Error occurred
java.lang.NullPointerException: Cannot invoke "com.rte.leafguard.model.SensorReading.getSensorId()" because "saved" is null
	at com.rte.leafguard.service.SensorService.processReading(SensorService.java:58)
	at com.rte.leafguard.controller.SensorController.process(SensorController.java:23)
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:897)
2025-05-16 03:12:44.019 ERROR  --- [nio-8080-exec-7] c.r.l.controller.SensorController        : Failed
2025-05-16 03:18:29.500  INFO  --- [main] com.rte.leafguard.LeafGuardApplication   : Shutting down application
LOG_EOF

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║     ✅  leafguard-api prêt pour le workshop           ║"
echo "╠══════════════════════════════════════════════════════╣"
echo "║  SensorService.java  → version workshop injectée     ║"
echo "║  logs/app.log        → version workshop injectée     ║"
echo "╠══════════════════════════════════════════════════════╣"
echo "║  Prochaine étape :                                    ║"
echo "║  cd leafguard-api && mvn compile -q                  ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
