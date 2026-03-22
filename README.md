# Map-Reduce on Kubernetes

**Course:** INF-419 Principles of Distributed Systems (Class Project 2026)  
**Instructor:** Vasilis Samoladas  

## Team Members
| Name              | Student ID (AM) | GitHub Username |
| :---------------- | :-------------- | :-------------- |
| Kritikakis Marios | 2020030213      | IamSynthetiC81  |

---

## Project Overview
This project implements a distributed system for performing parallel computation based on the Map-Reduce paradigm, orchestrated via **Kubernetes**. The system is designed to scale horizontally and handle node failures gracefully, processing large datasets through custom mapper and reducer functions.

## Architecture & Microservices
The system follows a 3-tier microservices architecture:
* **UI Service (CLI):** Allows users to submit jobs and view their status.
* **Authentication Service:** Powered by Keycloak, handling single sign-on (SSO) and user tokens.
* **Manager Service:** The orchestrator of the system. It reads pending jobs, spawns Worker pods, and monitors their execution.
* **Workers:** Ephemeral Kubernetes Jobs that execute the user-provided Map/Reduce code.
* **Distributed Data Service (DDS):** PostgreSQL database storing the state of jobs and tasks.
* **Shared File System:** MinIO (S3-compatible) for storing input data, intermediate shuffle data, and final outputs.

## Prerequisites
To run this project locally, you need the following installed:
* [Docker](https://www.docker.com/)
* [Minikube](https://minikube.sigs.k8s.io/docs/start/) & `kubectl`
* Python 3.9+

## How to Run (Local Development)

**1. Start Minikube**
```bash
minikube start --cpus=4 --memory=8192
```

**2. Deploy Infrastructure (MinIO & PostgreSQL)**
```bash
kubectl apply -f k8s/infrastructure/
```

**3. Build and Push Worker Images**
```bash
cd services/worker
docker build -t iamsynthetic/mr-worker:v1 .
docker push iamsynthetic/mr-worker:v1
```

**4. Deploy Microservices**
```bash
kubectl apply -f k8s/manager/
```

## Repo Structure
```

├── README.md
├── doc/                - Design documents, UML diagrams, and presentation files.
│   ├── report.tex
│   └── diagrams/
├── k8s/                - Kubernetes manifests (Deployments, Services, StatefulSets, Jobs).
│   ├── infrastructure/
├── services/           - Source code for all microservices and workers.
│   ├── ui-service/
│   ├── auth-service/
│   ├── manager-service/
│   └── worker/
├── benchmarks/         - Test datasets and sample mapper/reducer functions.
```