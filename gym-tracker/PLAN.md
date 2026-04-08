# Gym Membership Tracker — SaaS App Plan

> This document is a living plan. Update it as you learn and build.
> Add notes, questions, and progress as you go.

---

## What are we building?

A SaaS app for gym owners to manage their members.

```
Gym Owner logs in
      ↓
Sees dashboard (total members, active, expiring soon)
      ↓
Adds/edits/deletes members
      ↓
System automatically emails members before expiry
```

---

## Roadmap

| Step | Topic | Status |
|------|-------|--------|
| 1 | Understand tech stack | ✅ Done |
| 2 | Understand Go basics | ✅ Done |
| 3 | Setup project + database | ⬜ Todo |
| 4 | Build Auth (signup/login) | ⬜ Todo |
| 5 | Build Members CRUD | ⬜ Todo |
| 6 | Build Dashboard | ⬜ Todo |
| 7 | Build Email reminders | ⬜ Todo |
| 8 | Test everything with curl | ⬜ Todo |
| 9 | Build the UI | ⬜ Todo |
| 10 | Dockerize (multi-stage) | ⬜ Todo |
| 11 | Docker Compose (app + postgres) | ⬜ Todo |
| 12 | Kubernetes | ⬜ Todo |

> Update status: ⬜ Todo → 🔄 In Progress → ✅ Done

---

## Tech Stack

### Go (Programming Language)
- Created by Google (2009)
- Used by: Docker, Kubernetes, Terraform, Uber, Dropbox
- Compiles to a single binary → perfect for Docker
- Fast, built for backend/infrastructure

### Gin (Web Framework)
- Handles HTTP requests in Go
- Like Flask (Python) / Express (Node.js)
- Handles routing, JSON parsing, middleware

### GORM (Database ORM)
- Talks to PostgreSQL using Go code
- Like SQLAlchemy in Python
- Creates tables automatically
- Maps database rows to Go structs

```go
// Without GORM (raw SQL)
db.Query("SELECT * FROM members WHERE id = ?", id)

// With GORM (clean)
db.First(&member, id)
```

### PostgreSQL (Database)
- Production-grade relational database
- Stores: Users (gym owners) + Members

### JWT (Authentication)
```
1. Gym owner logs in with email + password
2. Server returns a token (like a key card)
3. Every request sends that token
4. Server verifies token and allows access
```

---

## Go Basics — Quick Reference

### Variables
```go
name := "John"              // short declaration
var name string = "John"    // explicit
```

### Functions
```go
func add(a int, b int) int {
    return a + b
}
```

### Structs
```go
type Member struct {
    Name  string
    Email string
}
```

### Error Handling
```go
result, err := someFunction()
if err != nil {
    return err    // something went wrong
}
```

### Packages
```go
package main       // entry point
package models     // models package

import (
    "fmt"
    "github.com/gin-gonic/gin"
)
```

---

## Project Structure

```
gym-tracker/
│
├── main.go          ← starts server, registers all routes
├── go.mod           ← dependencies (like package.json)
├── .env             ← secrets (never commit this)
├── PLAN.md          ← this file
│
├── config/
│   └── config.go    ← reads .env file
│
├── database/
│   └── db.go        ← connects to PostgreSQL, creates tables
│
├── models/
│   ├── user.go      ← gym owner account
│   └── member.go    ← gym member
│
├── handlers/
│   ├── auth.go      ← POST /signup, POST /login
│   ├── members.go   ← GET/POST/PUT/DELETE /members
│   └── dashboard.go ← GET /dashboard
│
└── middleware/
    └── auth.go      ← checks JWT token on every request
```

---

## Data Models

### User (Gym Owner)
```
id
name
email
password     ← hashed, never plain text
gym_name
created_at
```

### Member (Gym Member)
```
id
name
email
phone
membership_type   ← basic / premium / vip
start_date
expiry_date
is_active
user_id           ← which gym owner this belongs to
created_at
```

---

## API Endpoints

### Auth (no token needed)
```
POST /api/signup    ← gym owner creates account
POST /api/login     ← gym owner logs in → gets JWT token
```

### Members (JWT token required)
```
GET    /api/members        ← list all members
POST   /api/members        ← add new member
GET    /api/members/:id    ← get one member
PUT    /api/members/:id    ← update member
DELETE /api/members/:id    ← delete member
```

### Dashboard (JWT token required)
```
GET /api/dashboard    ← stats (total, active, expiring soon)
```

---

## How a Request Flows

Example: "Add a Member"

```
1. POST /api/members + JWT token
         ↓
2. main.go → routes to handlers/members.go
         ↓
3. middleware/auth.go → verifies JWT token
         ↓
4. handlers/members.go → validates data, saves to DB
         ↓
5. Response: { "id": 1, "name": "John", ... }
```

---

## Environment Variables

```
# Database
DB_HOST=localhost
DB_PORT=5432
DB_USER=gymuser
DB_PASSWORD=gympass
DB_NAME=gymdb

# Auth
JWT_SECRET=your_secret_key

# Email
EMAIL_SENDER=yourgmail@gmail.com
EMAIL_PASSWORD=your_app_password

# App
APP_PORT=8080
```

---

## Docker Plan

### Why multi-stage for Go?
```
Stage 1 (builder):
  FROM golang:1.23
  go build → single binary

Stage 2 (production):
  FROM scratch (empty!)
  COPY binary from Stage 1
  Final image: ~15MB only
```

### Docker Compose
```yaml
services:
  app:       ← Go app
  postgres:  ← PostgreSQL database
```

---

## Kubernetes Plan (Phase 3)

```
Deployments:
  - gym-tracker-app
  - postgres

Services:
  - gym-tracker-service (LoadBalancer)
  - postgres-service (ClusterIP)

ConfigMaps:
  - app config (DB_HOST, APP_PORT)

Secrets:
  - DB_PASSWORD, JWT_SECRET, EMAIL_PASSWORD

PersistentVolume:
  - postgres data
```

---

## What I Learned

> Add your learnings here as you go through each step.

### Docker
- Multi-stage builds reduce image size dramatically
- Layer caching: copy package files before source code
- Non-root user is a security best practice
- `.dockerignore` prevents unnecessary files in image
- `--omit=dev` skips dev dependencies in production

### Go
- (add as you learn)

### Kubernetes
- (add as you learn)

---

## Questions & Notes

> Add your questions here. Answer them as you find out.

- [ ] How does GORM handle database migrations automatically?
- [ ] What happens to PostgreSQL data when container restarts?
- [ ] How does JWT token expiry work?

---

## Resources

- Go documentation: https://go.dev/doc/
- Gin framework: https://gin-gonic.com/docs/
- GORM docs: https://gorm.io/docs/
- JWT explained: https://jwt.io/introduction
- PostgreSQL docs: https://www.postgresql.org/docs/

---

*Last updated: 2026-03-31*
*Keep updating this file as you learn and build.*
