# somnath-devops-lab

Hands-on DevOps practice projects — real tools, real configs, no toy examples.

## Projects

### `k8-labs/`
Kubernetes manifests written during CKA prep.
- Pod, ReplicaSet, Deployment, Service (ClusterIP, NodePort) configs
- Node affinity, DaemonSet, RBAC examples

### `node-application/`
Node.js app containerized and deployed to Kubernetes.
- Dockerfile with multi-stage build
- Kubernetes Deployment + Service manifest
- Used for practicing `kubectl` workflows end-to-end

### `voting-app/`
Multi-container app (vote, result, worker, redis, db).
- Docker Compose for local dev
- Kubernetes manifests for cluster deployment

### `birthday-app/`
Python app that sends birthday reminders — early boto3 + automation practice.

### `gym-tracker/`
Personal project tracking workouts — FastAPI + SQLite.

### `go-learning/`
Go fundamentals practice — started alongside Python automation track.

---

## Why this repo exists

I'm a reliability engineer transitioning to platform engineering. This repo is where I practice building the things I've been debugging for 6+ years — containers, clusters, infrastructure, automation.

Main project: [shipyard](https://github.com/somnathops/shipyard) — 8-service app on EKS with full CI/CD and observability.

---

**Stack:** Python · Go · Bash · Docker · Kubernetes · Terraform · AWS
