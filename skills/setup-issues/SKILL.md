---
name: setup-issues
description: Configure the project's issue tracker and triage label vocabulary so /triage, /to-issues, and /to-prd can operate. Records the tracker type and the canonical-role-to-label mapping in project-policy.yaml, and creates any missing labels in the tracker. Use once per repo before first using the issue-workflow skills, or when the label vocabulary changes.
---

# Setup Issues

`/triage`, `/to-issues`, and `/to-prd` operate on an issue tracker using a fixed set of **canonical triage roles**. This skill wires a repo to a concrete tracker: it records the tracker and the canonical-role → label mapping in `policies/project-policy.yaml`, and ensures the labels exist.

Run this once per repo. Re-run it if the label vocabulary changes.

## Canonical roles

A fixed vocabulary — two category roles, five state roles:

- Category: `bug`, `enhancement`
- State: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`

## Steps

1. **Determine the tracker.**
   - Default: **GitHub Issues**. Confirm with `gh auth status` and that the repo has a GitHub remote.
   - If the project uses a different tracker (GitLab, Linear, Jira, …), ask the user which one and how the skills should reach it (CLI, API). Record what you learn.

2. **Decide the label mapping.**
   - Default: each canonical role maps to a label of the same name.
   - If the tracker already has labels that mean these things (e.g. an existing `wont-fix` or `feature`), map the canonical role to the existing label instead of creating a duplicate. List the tracker's current labels and confirm the mapping with the user.

3. **Create missing labels.**
   - GitHub: `gh label create "<name>" --description "<desc>" --color <hex>` for each mapped label that doesn't already exist. Suggested colors — `bug` red, `enhancement` blue, `needs-triage` yellow, `needs-info` orange, `ready-for-agent` green, `ready-for-human` purple, `wontfix` grey.
   - Other trackers: create the labels via that tracker's own mechanism.

4. **Write the mapping to `policies/project-policy.yaml`.**
   - Add (or replace) an `issue_tracker` block:

   ```yaml
   issue_tracker:
     type: "github"            # github | gitlab | linear | other
     labels:
       bug: "bug"
       enhancement: "enhancement"
       needs-triage: "needs-triage"
       needs-info: "needs-info"
       ready-for-agent: "ready-for-agent"
       ready-for-human: "ready-for-human"
       wontfix: "wontfix"
   ```

   - If `policies/project-policy.yaml` doesn't exist, run `/resume` first to create it.

## Result

`/triage`, `/to-issues`, and `/to-prd` read the `issue_tracker` block from `policies/project-policy.yaml`. With it written and the labels created in the tracker, those skills can operate.

## Next

This skill does not auto-chain. With the tracker configured:

- `/triage` — work incoming issues through the triage state machine.
- `/to-issues` / `/to-prd` — turn plans and conversation context into tracker issues.
