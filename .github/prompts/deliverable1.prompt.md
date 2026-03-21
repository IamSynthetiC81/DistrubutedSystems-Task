---
description: "Generate INF-419 Deliverable 1 design document sections for the Map-Reduce on Kubernetes project with concrete APIs, schemas, flows, and Kubernetes mappings."
name: "Generate Deliverable 1 Design Document"
argument-hint: "Target audience, depth, and any constraints (for example: concise professor-ready draft with full API tables)."
agent: "agent"
---
Produce Deliverable 1 for INF-419 as a complete, implementation-ready design document for this workspace.

Use these required sources of truth before drafting:
- [Project instructions](../copilot-instructions.md)
- [Manager manifest](../../k8s/ManagerStatefulSetAndService.yaml)
- [UI manifest](../../k8s/UI.yaml)
- [RBAC](../../k8s/RBACforManagerAndWorkers.yaml)
- [Config and secrets](../../k8s/ConfigMapAndSecrets.yaml)
- [MinIO and PVC](../../k8s/MinIODeploymentAndServiceWithPVC.yaml)
- [Worker job template ConfigMap](../../k8s/Worker-Job-Template.yaml)
- [Worker render helper](../../k8s/Render-And-Run-WorkerJob.ps1)

Required output sections:
1. Scope And Assumptions
2. Architecture Overview
3. API Specifications
4. UML Use Cases And Flows
5. Kubernetes Mapping
6. PostgreSQL Schema
7. Security And Access Control
8. Scalability And Fault Tolerance
9. Logging, Observability, And Testing

Hard requirements:
- Do not produce generic notes.
- For each major claim, provide at least one concrete artifact:
  - endpoint contract and payload schema
  - schema table and relationships
  - sequence flow steps
  - Kubernetes resource mapping
- Include coverage for:
  - Submit data
  - Submit code
  - Run compute job
  - Retrieve result
  - Job status and cancellation
  - Admin user/node actions
- Include success and error responses for APIs with auth requirements.
- Include role model separation: User vs Admin.
- Include manager recovery semantics from persisted PostgreSQL state.
- Include worker retry/backoff and failure handling.
- Include explicit unresolved questions.
- End with a short risk register and mitigation table.

Output style:
- Use clear headings exactly matching section names.
- Include concrete example payloads for each major API group.
- Include at least one concrete schema example for core tables.
- Keep rationale concise and specific.
