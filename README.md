# Map-Reduce on Kubernetes

**Course:** INF-419 Principles of Distributed Systems (Class Project 2026)  
**Instructor:** Vasilis Samoladas  

[![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)](https://www.python.org/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Minikube-326ce5.svg)](https://kubernetes.io/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-DDS-336791.svg)](https://www.postgresql.org/)
[![MinIO](https://img.shields.io/badge/MinIO-S3_Storage-c7202c.svg)](https://min.io/)

## Team Members
| Name | Student ID (AM) | GitHub Username |
| :--- | :--- | :--- |
| Όνομα 1 | 123456 | [@username1](https://github.com/username1) |
| Όνομα 2 | 123456 | [@username2](https://github.com/username2) |
| Όνομα 3 | 123456 | [@username3](https://github.com/username3) |

---

## Project Overview
This project implements a highly available, distributed Map-Reduce framework orchestrated natively by Kubernetes. It allows users to submit custom Python mapper and reducer scripts to process large datasets in parallel, handling all the underlying complexity of resource provisioning, data shuffling, and node failures.

## Key Architectural Features
* **Strict State Consistency:** Uses PostgreSQL as the Distributed Data Service (DDS) to guarantee ACID transactions during the critical synchronization barrier between Map and Reduce phases.
* **Lock-Free Data Shuffling:** Leverages MinIO (S3-compatible Object Storage) with strict namespace isolation (`s3://.../{job_id}/intermediate/`) to allow thousands of ephemeral workers to read/write concurrently without POSIX filesystem contention.
* **Native Fault Tolerance:** Integrates directly with the Kubernetes API. Manager state is protected via `StatefulSet`, while worker failures (e.g., OOM kills) are automatically detected and restarted utilizing K8s `batch/v1 Jobs`.
* **Enterprise Security:** Implements Keycloak for robust Identity and Access Management (IAM), issuing JWTs for secure REST API communication.
* **Observability:** Full tracing of worker stdout/stderr logs and real-time job state monitoring via the Manager CLI.

## System Architecture
The platform is built upon a 3-tier microservices architecture:
1. **UI Service (CLI):** The user-facing gateway for submitting jobs and checking status.
2. **Auth Service:** The SSO and token validation endpoint.
3. **Manager Service:** The core orchestrator that parses the DDS, spawns Kubernetes Jobs, and coordinates the Shuffling phase.
4. **Workers:** Ephemeral K8s pods executing user-defined compute logic.

---

## Local Development & Deployment

### Prerequisites
* Docker & [Minikube](https://minikube.sigs.k8s.io/docs/start/)
* kubectl CLI installed
* Python 3.9+

### Quick Start

**1. Start the Kubernetes Cluster**
```bash
minikube start --cpus=4 --memory=8192
```

**2. Deploy Infrastructure (MinIO & PostgreSQL)**

> [!NOTE]
> Ensure your current directory is the project root and the k8s folder contains your manifests for MinIO and PostgreSQL.

```bash
kubectl apply -f k8s/
```

Project Roadmap (Milestones)
- [x] Milestone 1: System Design (March 22, 2026)
  - Technology Stack Selection
  - REST API Specifications
  - Data Schema (DDS) & Storage Namespaces
  - UML Interaction Diagrams
- [ ] Milestone 2: Implementation (May 31, 2026)
  - Microservices Development (Python/FastAPI)
  - Kubernetes Manifests complete
  - Map-Reduce shuffling logic execution
- [ ] Milestone 3: Final Delivery & Benchmarking
  - Performance evaluation with large datasets
