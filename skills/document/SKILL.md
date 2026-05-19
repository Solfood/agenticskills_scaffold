---
name: document
description: Bring a repo's documentation up to the Project Docs Standard — a polished, task-oriented, in-repo Markdown format with audience-separated guides, a "Start here" nav table, and clean cross-repo linking. Use when the user wants to write, restructure, audit, or beautify project documentation, or mentions a docs pass / doc cleanup.
---

<what-to-do>

Bring the current repo's documentation up to the **Project Docs Standard**. The standard
itself lives in [DOC-STANDARD.md](./DOC-STANDARD.md); copy-paste skeletons live in
[TEMPLATE.md](./TEMPLATE.md). Read both before doing anything.

Work in three passes:

1. **Audit.** Inventory every Markdown file in the repo. For each, note its audience
   (operator / contributor / reference / historical), whether it conforms to the standard,
   and any inconsistency (stale commands, broken links, wrong terminology, duplicated
   content). Report the inventory back before changing files.

2. **Restructure.** Apply the standard. Slim the README to a landing page, move depth into
   `docs/`, create a `docs/README.md` index, and split content by audience. Use the
   skeletons in TEMPLATE.md. Never invent content — move and reformat what exists, and
   flag genuine gaps for the user to fill.

3. **Verify.** Check every relative link resolves, every cross-repo link is an absolute
   `https://github.com/<org>/<repo>/blob/<branch>/...` URL, and no doc is orphaned from the
   index. Render-check mermaid blocks and tables.

Preserve historical records as-is — decision records (`DEC-NNNN.md`), session logs, and
work indexes are an audit trail. Reformat them only lightly (headers, links); never rewrite
their substance.

Ask before deleting or merging any file. Surface every contradiction you find between the
docs and the code rather than silently picking one.

</what-to-do>

<supporting-info>

## When this spans repos

If the user wants several repos to share the format, apply the standard to each repo
independently, then wire cross-references: each repo links to the others with absolute
GitHub URLs, and names the relationship explicitly (consumer, dependency, vendored copy).
A vendored or mirrored copy of another repo must say so in prose — readers need to know
which is the source of truth.

## Audience separation

Every repo has at least two audiences. Keep them in separate documents, never interleaved:

- **Operators / users** — people who run, deploy, or consume the project. They want
  task-oriented how-to: prerequisites, steps, troubleshooting.
- **Contributors** — people who change the project. They want conventions, architecture,
  the local dev loop, and how to extend it.

The README's "Start here" nav table is what routes a reader to the right document in one
glance. It is the single most important element of the standard — never omit it.

## Scope discipline

A docs pass is not a content rewrite. Default scope: the README, the `docs/` entry docs
(guides + index), the architecture doc, and consistency fixes everywhere. Confirm with the
user before reformatting large historical trees or per-component files in bulk.

</supporting-info>
