# Project Guidelines

## Mission
You are producing Deliverable 1 for INF-419: a design document for a Map-Reduce framework on Kubernetes.
Focus on system design quality, correctness, and traceability from requirements to architecture.

## Task For Any Agent
When asked for design content, produce a complete, implementation-ready design document section set, not generic notes.
Every major design claim must map to a concrete artifact: endpoint contract, schema table, sequence flow, or Kubernetes resource mapping.

## Project Context
- Primary language: Python.
- Orchestration: Kubernetes, local development with Minikube.
- Authentication and authorization: Keycloak with OAuth2 and OpenID Connect.
- Persistent state: PostgreSQL.
- Storage for data and shuffle artifacts: S3-compatible object storage or ReadWriteMany shared volume.
- Architecture style: microservice, three-layer structure.

## Service Boundaries
- UI Service: stateless Python deployment, exposes user-facing APIs and CLI scripting flows for jobs and admin operations.
- Manager Service: StatefulSet, owns scheduling and job lifecycle, persists recoverable state in PostgreSQL, resumes work after replica failure.
- Authentication Service: Keycloak, issues and validates tokens, enforces User and Admin role model.
- Worker Execution: Kubernetes Jobs, runs map and reduce task code through a defined worker interface.
- Shared Storage: input datasets, intermediate shuffle outputs, and final results.

## Existing Workspace Sources Of Truth
Use and align with these files before proposing design details:
- k8s/ManagerStatefulSetAndService.yaml
- k8s/UI.yaml
- k8s/RBACforManagerAndWorkers.yaml
- k8s/ConfigMapAndSecrets.yaml
- k8s/MinIODeploymentAndServiceWithPVC.yaml
- k8s/Worker-Job-Template.yaml
- k8s/Render-And-Run-WorkerJob.ps1

## Deliverable 1 Required Sections
The generated design document must include all of the following.

### 1. Scope And Assumptions
- Problem statement, goals, non-goals.
- Explicit assumptions for cluster size, input scale, and trust boundaries.

### 2. Architecture Overview
- Component diagram with UI, Manager, Auth, Workers, PostgreSQL, and shared storage.
- Responsibilities, interfaces, and data flow between components.

### 3. API Specifications
- REST or gRPC contracts for UI, Manager, and Auth integration points.
- Required operation coverage:
	- Submit data
	- Submit code
	- Run compute job
	- Retrieve result
	- Job status and cancellation
	- Admin user or node configuration actions
- For each API operation include purpose, request schema, response schema, success and error codes, and auth requirement.

### 4. UML Use Cases And Flows
- Use case detail for:
	- Submit Data
	- Submit Code
	- Run Compute Job
	- Retrieve Result
- Include actor roles, preconditions, postconditions, and main plus alternate flows.

### 5. Kubernetes Mapping
- Explain how one logical Map-Reduce job expands into Kubernetes resources.
- Include manager scheduling logic, worker Job creation, retries, backoff behavior, and cleanup policy.
- Cover failure handling for deleted worker pods and manager replica failover.

### 6. PostgreSQL Schema
- Relational schema for users, jobs, tasks, assignments, state transitions, and artifacts.
- Include primary keys, foreign keys, indexes, and state transition rules.
- Explain how persisted state enables manager recovery.

### 7. Security And Access Control
- Keycloak token flow and role-based authorization decisions.
- Separation of User vs Admin privileges.
- Secret handling for database and object storage credentials.

### 8. Scalability And Fault Tolerance
- Horizontal scaling strategy for manager and workers.
- Partitioning and reducer grouping strategy for large input.
- Recovery semantics and idempotency expectations.

### 9. Logging, Observability, And Testing
- Logging strategy per service and correlation fields.
- Required tests: unit, integration, and Kubernetes smoke tests.
- Minimum acceptance checks for end-to-end job execution.

## Quality Bar
- Be specific and deterministic; avoid placeholder prose.
- Prefer simple, maintainable designs that satisfy requirements.
- Highlight open decisions explicitly with a short list of unresolved questions.

## Repository-Specific Constraints And Pitfalls
- Keep Kubernetes namespace as mapreduce unless a change is explicitly requested.
- Keep MinIO definition single-source in k8s/MinIODeploymentAndServiceWithPVC.yaml.
- Worker template placeholders are maintained as template content in ConfigMap file k8s/Worker-Job-Template.yaml.
- Avoid proposals that require metadata.generateName in apply-managed template manifests.
- Keep PVC size consistent across manifests to avoid forbidden resize errors on apply.

## Output Style Requirements For Deliverable 1
- Use clear section headings matching the required section list above.
- Provide at least one concrete example payload for each major API group.
- Provide at least one concrete schema example for core tables and relationships.
- Provide concise rationale for each major architectural choice.
- End with a short risk register and mitigation table.