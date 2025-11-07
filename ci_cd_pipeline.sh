#!/bin/bash
# ==========================================================
# 🚀 CI/CD PIPELINE BÁSICO - AthenIA Backend (VM local)
# ==========================================================

LOG_DIR="$HOME/ci_logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/pipeline_$TIMESTAMP.log"

echo "🕒 [$TIMESTAMP] Iniciando pipeline..." | tee -a "$LOG_FILE"

# 1️⃣ Actualizar código del repositorio
echo "📥 Actualizando código..." | tee -a "$LOG_FILE"
git pull origin main >> "$LOG_FILE" 2>&1

# 2️⃣ Ejecutar tests
echo "🧪 Ejecutando pruebas con Maven..." | tee -a "$LOG_FILE"
mvn -B clean test >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
  echo "✅ Tests superados correctamente." | tee -a "$LOG_FILE"
  
  # 3️⃣ Empaquetar la aplicación
  echo "📦 Compilando y empaquetando aplicación..." | tee -a "$LOG_FILE"
  mvn -B clean package >> "$LOG_FILE" 2>&1
  
  # 4️⃣ Reiniciar backend
  echo "🔁 Reiniciando backend..." | tee -a "$LOG_FILE"
  pkill -f "athenia-backend.jar" >> "$LOG_FILE" 2>&1
  nohup java -jar target/athenia-backend-1.0.0.jar > "$LOG_DIR/app_$TIMESTAMP.log" 2>&1 &
  
  echo "🎯 Despliegue completado correctamente." | tee -a "$LOG_FILE"
else
  echo "❌ Falló una prueba. Deteniendo pipeline." | tee -a "$LOG_FILE"
fi

echo "📄 Log completo: $LOG_FILE"
