- check $HOME/brain/CLAUDE.md always
- DO NOT FUCKING create .md files if i dont ask for it

# MEDIAR AI - GLOBAL MEMORY

## Ecosystem Map
- **terminator** ($HOME/Documents/terminator): Core automation engine, CLI, MCP Agent. (Rust)
- **mediar-web-app** ($HOME/Documents/mediar-web-app): SaaS platform, Dashboard, Workflow Editor. (Next.js + Modal + Rust Executor)
- **mediar-app** ($HOME/Documents/mediar-app): Desktop Client, Local Execution. (Tauri + React)
- **agents** ($HOME/Documents/agents): Cloud Infrastructure, VM Images, Telemetry. (Terraform + Packer)
- **workflows** ($HOME/Documents/workflows): Automation Workflow Registry. (TypeScript + YAML)

## Architecture Overview
**Workflow Execution Flow:**
User -> Next.js API -> Modal/Rust Executor -> GitHub workflows repo -> MCP Agent (VM) -> UIAutomation -> Results -> Supabase

**Data Stores:**
- Supabase: PostgreSQL (workflows, executions, VMs, users) + S3 storage (YAML files, screenshots)
- ClickHouse: Telemetry (traces, logs from VMs + executors via OTEL Collector)
- GitHub: Source of truth for workflow definitions (mediar-ai/workflows repo)

## CRITICAL HYGIENE (The "Mediar Way")
- **Low Entropy**: Delete unused files immediately. No verbose READMEs. Keep it clean.
- **No Fluff**: Do not say "I hope this helps". Be conversational but concise.
- **File Size**: < 1.5k lines. Split modules aggressively.
- **User Approval**: **NEVER** commit without explicit "commit this" command.

## Testing Philosophy - MANDATORY
1. **TDD**: Write tests **FIRST**.
2. **Self-Correction**: Run tests yourself. **NEVER** ask the user to test for you.
3. **Commands**:
   - Rust: cargo test
   - JS/TS: bun test or npm test
   - Full Check: bun run build / cargo check before any commit.
