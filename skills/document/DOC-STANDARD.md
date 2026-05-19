# Project Docs Standard

> A portable convention for project documentation: polished in-repo Markdown,
> task-oriented, audience-separated, with zero build step.

This is the standard the `/document` skill applies. It is written to be readable on
GitHub, in Azure DevOps Repos, and in a VS Code Markdown preview without any tooling.

---

## Principles

1. **In-repo Markdown, zero build.** Docs live next to the code as `.md` files. No static
   site generator, no CI pipeline, no hosting decision. They render wherever the repo is
   viewed.
2. **Task-oriented.** A reader arrives with an intent ("deploy this", "extend this").
   Documentation routes them to that task fast — it is not an essay.
3. **Audience-separated.** Operators and contributors get separate documents. Never
   interleave "how to use" with "how to change."
4. **One source of truth.** Each fact lives in exactly one place. Everything else links
   to it. Duplicated prose drifts.
5. **Honest.** Document what is true, not what is aspirational. Flag gaps explicitly
   rather than papering over them.

---

## Repo layout

```
/
├── README.md              ← landing page: tagline, Start-here nav, quick start
├── docs/
│   ├── README.md          ← docs index: one row per document
│   ├── operator-guide.md  ← how to run / deploy / use it
│   ├── contributor-guide.md ← conventions, dev loop, how to extend
│   ├── architecture/      ← system design
│   ├── decisions/         ← DEC-NNNN.md records (historical — do not rewrite)
│   └── runbooks/          ← operational procedures
└── ...
```

Small repos may keep the operator guide inline in the README and skip `docs/operator-guide.md`.
Everything else scales up as the repo grows. Create files lazily — only when there is
something to put in them.

---

## The README — a landing page, not a manual

The README's job is to orient a reader in fifteen seconds and route them onward. It is
short. Depth belongs in `docs/`.

Required elements, in order:

1. **Title** — the repo name as an `# H1`, no emoji.
2. **Tagline** — one sentence, as a `>` blockquote, saying what the project is and for whom.
3. **Start here nav table** — see below. This is mandatory.
4. **Quick start** — the shortest real path to a working result, ~5 lines.
5. **Sections** — only what a landing page needs (prerequisites, overview). Anything
   longer than a screen moves to `docs/`.

### The Start here nav table

The first interactive element. It routes readers by intent:

```markdown
### Start here

| I want to… | Go to |
|---|---|
| Deploy and connect | [Operator guide](docs/operator-guide.md) |
| Understand the design | [Architecture](docs/architecture/ARCHITECTURE.md) |
| Contribute or extend it | [Contributor guide](docs/contributor-guide.md) |
| See why decisions were made | [Decision records](docs/decisions/) |
```

Each row is a *task*, phrased from the reader's point of view, linking to exactly one
document. Order rows by how common the intent is.

### The docs index

`docs/README.md` is a flat table of every document in `docs/`, one row each, with a
one-line purpose. No document in `docs/` should be reachable only by guessing a filename.

---

## Formatting rules

| Element | Rule |
|---|---|
| Headers | Sentence case. No emoji. No numbered prefixes. |
| Tagline | One `>` blockquote line under the H1. |
| Callouts | GitHub alerts — `> [!NOTE]`, `> [!TIP]`, `> [!WARNING]`, `> [!IMPORTANT]`. |
| Diagrams | Mermaid fenced blocks (` ```mermaid `). Renders on GitHub and Azure DevOps. |
| Reference data | Tables — tool lists, key bindings, parameters, env vars. |
| Commands | Fenced code blocks with a language tag (`powershell`, `bash`, `json`). |
| Long optional detail | `<details><summary>…</summary>` collapsible blocks. |
| Dividers | `---` between top-level sections. Use sparingly, not after every heading. |
| Emoji & badges | None. Exception: a badge that reflects live state (CI status). Decorative badges are noise. |

Write in the active voice. Address the reader as "you" in guides. Keep paragraphs to a few
sentences — if a section runs long, it is probably two sections or belongs in `docs/`.

---

## Linking

- **Same repo** — relative paths: `[Architecture](docs/architecture/ARCHITECTURE.md)`.
- **Across repos** — absolute GitHub URLs against the canonical host:
  `https://github.com/<org>/<repo>/blob/main/<path>`. Relative `../other-repo/` paths
  break on every web UI — never use them across repos.
- **Guides and reference docs link home.** Each guide or reference document in `docs/`
  ends with a backlink to `docs/README.md`. Historical and continuity records (decision
  records, work index, session logs) are reached through their index row or directory
  link and need no backlink — they are skill-managed and rewritten often.
- **Name cross-repo relationships.** When repo A links to repo B, say what B *is* to A —
  a dependency, a consumer, the upstream of a vendored copy. A bare link leaves the
  reader guessing.

> [!IMPORTANT]
> A vendored or mirrored copy of another repo's files must state, in prose, that it is a
> copy and which repo is the source of truth. Silent copies rot.

---

## Historical records

Decision records (`DEC-NNNN.md`), session logs, and work indexes are an audit trail.
Their value is being an accurate record of what was decided and when.

- Reformat them only lightly — fix headers, fix broken links, nothing else.
- Never rewrite their substance, reorder their history, or "improve" their reasoning.
- Superseded decisions stay; they are marked superseded, not deleted.

---

## Definition of done

A repo conforms to this standard when:

- [ ] The README is a landing page with a tagline and a Start here nav table.
- [ ] `docs/README.md` indexes every document in `docs/`.
- [ ] Operator and contributor content live in separate documents.
- [ ] Every relative link resolves; every cross-repo link is an absolute GitHub URL.
- [ ] No document is orphaned from the index.
- [ ] Headers are sentence case, no emoji, no decorative badges.
- [ ] Historical records are preserved, not rewritten.
- [ ] Cross-repo relationships are named in prose, not just linked.
