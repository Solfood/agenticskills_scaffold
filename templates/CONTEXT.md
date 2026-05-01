# <PROJECT_NAME>

<!-- One or two sentences: what this context is and why it exists. -->

## Language

<!--
Add domain terms as /decide and /grill-with-docs surface them.

Format:

**Term**:
A concise definition. What it IS, not what it does.
_Avoid_: Synonyms or aliases that would create ambiguity.

Example:

**Order**:
A request from a Customer to receive goods or services, captured at submit time.
_Avoid_: Purchase, transaction.
-->

## Relationships

<!--
Cross-term relationships using bold names and cardinality.

- An **Order** produces one or more **Invoices**
- An **Invoice** belongs to exactly one **Customer**
-->

## Example dialogue

<!--
A short conversation showing the terms used naturally. Optional but useful — it forces precision about boundaries between related concepts.

> **Dev:** "When a Customer places an Order, do we create the Invoice immediately?"
> **Domain expert:** "No — an Invoice is only generated once Fulfillment is confirmed."
-->

## Flagged ambiguities

<!--
Terms that were used ambiguously, with the resolution.

- "account" was used to mean both **Customer** and **User** — resolved: these are distinct concepts.
-->

---

<!--
Rules:
- One-sentence definitions. Define what the term IS.
- Be opinionated — pick the canonical word, list aliases under _Avoid_.
- Domain-specific only. Don't include general programming concepts.
- Show relationships when they're not obvious from the definitions.
- Update inline when /decide or /grill-with-docs surfaces a new or conflicting term.

This file is auto-managed by /decide and Matt Pocock's /grill-with-docs. You can also edit it by hand.
-->
