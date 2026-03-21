---
description: "Generate or refine one section of INF-419 Deliverable 1 at a time with concrete artifacts and traceability checks."
name: "Deliverable 1 Section Writer"
argument-hint: "Section name plus intent, for example: API Specifications draft, or PostgreSQL Schema revise with stronger indexes."
agent: "agent"
---
Work on exactly one Deliverable 1 section at a time for this workspace.

Inputs expected from the user:
- Section name
- Mode: draft or revise
- Optional constraints (length, audience, emphasis)

Before writing, align with:
- [Workspace instructions](../copilot-instructions.md)
- [Manager manifest](../../k8s/ManagerStatefulSetAndService.yaml)
- [UI manifest](../../k8s/UI.yaml)
- [RBAC manifest](../../k8s/RBACforManagerAndWorkers.yaml)
- [Config and secrets](../../k8s/ConfigMapAndSecrets.yaml)
- [MinIO manifest](../../k8s/MinIODeploymentAndServiceWithPVC.yaml)
- [Worker template ConfigMap](../../k8s/Worker-Job-Template.yaml)
- [Worker render script](../../k8s/Render-And-Run-WorkerJob.ps1)

Rules:
- Produce only the requested section content, not the full document.
- Keep claims concrete and tied to artifacts.
- Include at least one explicit artifact in each response, depending on section type:
  - API section: endpoint table and sample payloads
  - UML flow section: actor, preconditions, postconditions, main and alternate flows
  - Kubernetes section: resource mapping and execution sequence
  - Schema section: tables, keys, indexes, state-transition constraints
  - Security section: token flow, role checks, secret handling decisions
  - Scalability section: partitioning strategy, retry semantics, idempotency notes
  - Testing section: test matrix and acceptance checks
- If mode is revise, start with a short gap list, then provide improved section text.
- End with a short self-check list for requirement coverage specific to that section.

Output format:
1. Section heading
2. Section body
3. Self-check list
