---
description: "Use when editing Kubernetes manifests for this project, including Deployments, StatefulSets, Services, RBAC, ConfigMaps, Secrets, PVCs, and Job template resources."
name: "Kubernetes Manifest Rules"
applyTo: "k8s/**/*.yaml"
---
# Kubernetes Manifest Rules

## Scope
Apply these rules to all files under k8s/.

## Namespace And Resource Consistency
- Keep namespace as mapreduce unless the user explicitly requests a change.
- Keep MinIO resources single-source in k8s/MinIODeploymentAndServiceWithPVC.yaml.
- Keep PVC storage requests consistent across manifests to avoid apply-time resize failures.

## Worker Template Rules
- k8s/Worker-Job-Template.yaml stores template content in a ConfigMap named mr-worker-job-template.
- Preserve placeholders as literal template tokens: {{JOB_ID}}, {{TASK_INDEX}}, {{ROLE}}.
- Do not place placeholder tokens in Kubernetes-validated runtime fields of an apply-managed resource (for example metadata.name of a real Job).
- Avoid designs that require metadata.generateName in apply-managed template manifests.

## Kubernetes Schema Safety
- For Deployment resources (apps/v1), always include spec.selector.matchLabels and matching pod template labels.
- Place pod-level fields such as volumes under spec.template.spec, not at the top deployment spec level.
- Keep Service selectors aligned with workload labels.

## Security And Runtime Baseline
- Preserve existing ServiceAccount usage for manager and worker workloads.
- Keep secrets in Secret resources and consume them via valueFrom references.
- Do not hardcode production credentials in new manifests.

## Operational Validation
- After manifest edits, prefer validating with kubectl apply -f k8s/.
- When introducing template-rendered jobs, keep cluster apply idempotent and avoid creating accidental worker jobs at apply time.
