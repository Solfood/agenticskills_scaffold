---
name: threat-model
description: Walk a STRIDE-based threat model for a change touching auth, crypto, data export/import, network perimeter, or other security-sensitive areas. Required for medium/high-risk decisions. Use when /decide classifies risk as medium or high, when retrofitting an existing system, or before any irreversible migration.
---

Walk a structured threat model for a change.

## Steps

1. **Copy template.**
   - Copy the plugin's `templates/threat-model.md` to `docs/threat-models/TM-<NNNN>.md`. Number by scanning existing TMs.
   - If `docs/threat-models/` doesn't exist, create it.

2. **Identify Assets.**
   What's worth attacking in this system / change? Common candidates:
   - User data (PII, content, behavior logs)
   - Auth tokens, sessions, credentials
   - Money flows, payment data
   - Intellectual property, secrets
   - Service availability itself

3. **Map Trust Boundaries.**
   Where does data cross from one trust zone to another? Examples:
   - Browser → server
   - Server → database
   - Internal service → third-party API
   - Authenticated session → privileged operation

4. **List Entry Points.**
   Every place untrusted input enters the system or this change. Forms, API endpoints, file uploads, deserialization, environment variables, query parameters.

5. **Enumerate Abuse Cases.**
   What could go wrong if someone with bad intent had access to each entry point? Cover at least:
   - External attacker (no credentials)
   - Authenticated but malicious user
   - Compromised internal service
   - Insider with elevated access

6. **Walk STRIDE.**
   For each category, list applicable threats. Skip categories that genuinely don't apply (and say why).
   - **S — Spoofing.** Can an attacker impersonate a user, service, or device?
   - **T — Tampering.** Can data in transit or at rest be modified without detection?
   - **R — Repudiation.** Can a user deny an action with no audit trail to contradict them?
   - **I — Information Disclosure.** Can sensitive data leak to unauthorized parties?
   - **D — Denial of Service.** Can an attacker degrade or disable the service?
   - **E — Elevation of Privilege.** Can a low-privilege actor gain higher-privilege capabilities?

7. **For each threat: Severity, Mitigation, Residual Risk.**
   Fill the table in the template. Severity = critical / high / medium / low. Mitigation = the specific control (input validation, authz check, rate limit, audit log, etc.). Residual Risk = what remains after the mitigation.

8. **Approval.**
   Note who approved (or who needs to). For solo work, this is just the user; for shared work, link to the reviewer.

## Tier 2 lazy behavior

Create `docs/threat-models/` if missing. Link the TM from the parent DEC by editing `docs/decisions/DEC-<NNNN>.md`.

## When to skip

- Low-risk changes that don't touch the categories above.
- Pure refactors with no surface-area change.
- Internal-only tooling with no untrusted input.
