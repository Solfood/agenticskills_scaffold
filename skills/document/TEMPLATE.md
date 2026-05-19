# Doc templates

Copy-paste skeletons for the [Project Docs Standard](./DOC-STANDARD.md). Replace every
`<placeholder>`. Delete sections that do not apply — an empty section is worse than none.

---

## Landing README

````markdown
# <repo-name>

> <One sentence: what this is and who it is for.>

### Start here

| I want to… | Go to |
|---|---|
| <Most common task> | [<Guide>](docs/<guide>.md) |
| Understand the design | [Architecture](docs/architecture/ARCHITECTURE.md) |
| Contribute or extend it | [Contributor guide](docs/contributor-guide.md) |
| See why decisions were made | [Decision records](docs/decisions/) |

## Quick start

```<lang>
<The shortest real path to a working result — about five lines.>
```

## Prerequisites

| Requirement | How to get it |
|---|---|
| <tool> | <install command or link> |

## Overview

<One short paragraph. Link to docs/ for anything deeper.>
````

---

## docs/README.md — the docs index

````markdown
# Documentation

Everything in `docs/`, by audience. New here? Start with the [README](../README.md).

## Guides

| Document | For | Purpose |
|---|---|---|
| [Operator guide](operator-guide.md) | Operators | Deploy, connect, run, troubleshoot. |
| [Contributor guide](contributor-guide.md) | Contributors | Conventions, dev loop, how to extend. |

## Reference

| Document | Purpose |
|---|---|
| [Architecture](architecture/ARCHITECTURE.md) | System design and data flow. |
| [Decision records](decisions/) | `DEC-NNNN.md` — why things are the way they are. |
| [Runbooks](runbooks/) | Step-by-step operational procedures. |
````

---

## Operator guide

````markdown
# Operator guide

> How to deploy, connect to, and run <repo-name>. For design rationale see
> [Architecture](architecture/ARCHITECTURE.md); to change the project see the
> [Contributor guide](contributor-guide.md).

## Prerequisites

| Requirement | How to get it |
|---|---|
| <tool> | <install command> |

## Deploy

<Numbered steps. One command per fenced block. State what each step produces.>

## Connect

<Steps.>

## Troubleshooting

**<Symptom>**
<Cause and fix.>

> [!WARNING]
> <Anything that bites people — call it out, do not bury it.>

---
[← Docs index](README.md)
````

---

## Contributor guide

````markdown
# Contributor guide

> How to make changes to <repo-name>. To run it without changing it, see the
> [Operator guide](operator-guide.md).

## Conventions

<Branching, markers, commit format, naming. Link to CLAUDE.md if it holds the rules.>

## Local dev loop

```<lang>
<Clone → change → validate locally.>
```

## Validation

<The exact checks that must pass before a PR — copy them so they can be run verbatim.>

## How to extend it

<The common extension points and how to add one.>

---
[← Docs index](README.md)
````
