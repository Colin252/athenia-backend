# ☁️ Athenia Backend — Cloud API with Spring Boot & Apache Spark

### 🌍 Live Frontend: [https://athenia-demo.art](https://athenia-demo.art)

**Athenia Backend** is the core API powering the Athenia medical platform.  
It’s a **Spring Boot 3** application deployed on a **Google Cloud VM (GCP)**, integrating **Apache Spark** for data processing and **GitHub Actions** for continuous integration and delivery (CI/CD).

---

## 🚀 Overview

- Developed with **Java 17 + Spring Boot 3**
- Integrated with **Apache Spark** for scalable data analytics
- Deployed on a **Google Cloud Compute Engine** instance (Debian)
- Automated builds & deployments via **GitHub Actions**
- Serves as backend for **React + Vite frontend** hosted at [https://athenia-demo.art](https://athenia-demo.art)

---

## 🧩 Architecture Overview

+-------------------------------------------+
| React Frontend (Nginx) |

https://athenia-demo.art
- Hosted on GCP VM
- Built with React + Vite
- Served via Nginx static files
+---------------------+---------------------+

markdown
Copiar código
                  |
                  | HTTP (API Requests)
                  v
+-------------------------------------------+
| Athenia Backend (Spring Boot) |
| - Java 17 + Spring Boot 3 |
| - JWT Authentication |
| - Apache Spark Integration |
| - REST APIs (Patients, Doctors, etc.) |
| - Deployed on GCP VM |
+---------------------+---------------------+
|
v
+-------------------------------------------+
| MySQL 8 Database (Local VM) |
| - Persistent data storage |
+-------------------------------------------+

yaml
Copiar código

---

## ⚙️ Tech Stack

| Category | Technology |
|-----------|-------------|
| **Language** | Java 17 |
| **Framework** | Spring Boot 3 |
| **Database** | MySQL 8 |
| **Data Processing** | Apache Spark |
| **Build Tool** | Maven |
| **Cloud Platform** | Google Cloud (Compute Engine) |
| **Web Server** | Nginx |
| **Version Control** | Git + GitHub |
| **CI/CD** | GitHub Actions + SSH |
| **Security** | Spring Security + JWT |
| **Logs** | journalctl / nohup logs |

---

## 🔁 CI/CD Pipeline

**File:** `.github/workflows/deploy-backend.yml`

```yaml
name: Backend CI/CD Deploy

on:
  push:
    branches: [ "main" ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: 🧩 Checkout repository
        uses: actions/checkout@v4

      - name: ☕ Build project with Maven
        run: mvn clean package -DskipTests

      - name: 🚀 Deploy to GCP VM via SSH
        uses: appleboy/ssh-action@v1.0.0
        with:
          host: ${{ secrets.GCP_VM_IP }}
          username: ${{ secrets.GCP_USER }}
          key: ${{ secrets.GCP_SSH_KEY }}
          script: |
            cd ~/athenia-backend
            sudo systemctl stop athenia.service || true
            cp target/athenia-backend.jar ~/athenia-backend/
            sudo systemctl start athenia.service
🔐 Security & Access
Layer	Description
Authentication	JWT-based token validation
Encryption	HTTPS enabled through Nginx reverse proxy
SSH Access	Restricted to authorized public keys only
Firewall	Only ports 22 (SSH) and 80 (HTTP) open
Secrets	Stored securely in GitHub Actions secrets

🧪 API Endpoints
Method	Endpoint	Description
POST	/api/auth/login	Authenticate user (JWT token)
POST	/api/auth/register	Register new user
GET	/api/patients	List patients
POST	/api/patients	Add new patient
GET	/api/reports	Generate medical reports (Spark)

🧱 Local Setup
1️⃣ Clone the repository
bash
Copiar código
git clone https://github.com/Colin252/athenia-backend.git
cd athenia-backend
2️⃣ Build & Run
bash
Copiar código
mvn clean install
mvn spring-boot:run
Default port: 8080

☁️ GCP Deployment Summary
Step	Description
VM Setup	Debian 12, OpenJDK 17, Maven 3.6+
Backend Location	/home/ec2-user/athenia-backend
Service Management	systemctl enable athenia.service
Frontend Delivery	/var/www/html via Nginx
Monitoring	journalctl -u athenia.service -f

💡 Key Learnings
Spring Boot + Apache Spark integration

CI/CD automation with GitHub Actions and SSH

Secure VM configuration on GCP

Nginx reverse proxy and firewall management

Coordinated frontend-backend deployments under one domain

🧭 Future Roadmap
🐳 Dockerize backend for scalable deployment

☁️ Add Cloud SQL integration

🔒 Implement HTTPS with Let’s Encrypt

🧠 Extend Spark analytics with healthcare data insights

🧪 Add unit & integration tests (JUnit + Mockito)

👨‍💻 Author
Helton Emerson Quiroz López
Full Stack Developer | Cloud Engineer (GCP, Java, React, Spark)

📧 heltonquiroz.dev@gmail.com
🐙 GitHub Profile
🌐 Athenia App
