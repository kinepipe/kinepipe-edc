---
title: "Published Agent Rules Set: General Operation Guide"
summary: "General operation guide for the publication-oriented set of Agent Skills-style rules included as manuscript appendices."
document_type: "journal_appendix_set_guide"
language: "en"
version: "1.0"
date: "2026-06-08"
status: "draft"
intended_use: "Supplementary manuscript appendix and guide for interpreting the published rule set; customize according to needs."
---

# Published Agent Rules Set: General Operation Guide

## Publication Notice

This document describes the general operation of a **publication-oriented set of Agent Skills-style rules**. The files in this set are not intended to be installed as executable skills. They are methodological appendices that document reusable AI-agent guidance patterns for digital health and clinical research.

The set includes the Markdown-production appendix and the five generalized health-oriented rule appendices derived from the original LaTeX rule set. The Spanish-language source annex is intentionally excluded from this published set.

## Included Documents

| File | Role in the Set |
|---|---|
| [mdmake_publication_appendix.md](mdmake_publication_appendix.md) | Describes the non-operational mdmake adaptation used to structure publication-ready Markdown. |
| [clinical_data_capture_sync_publication.md](clinical_data_capture_sync_publication.md) | Generalizes data persistence, missing-data handling, local backup, and synchronization for health workflows. |
| [document_conversion_publication.md](document_conversion_publication.md) | Generalizes document conversion into structured Markdown for safe AI-assisted review. |
| [clinical_software_development_publication.md](clinical_software_development_publication.md) | Generalizes clinical software development, usability, versioning, and UI/UX practices. |
| [field_resilience_failure_control_publication.md](field_resilience_failure_control_publication.md) | Generalizes defensive error handling, field resilience, fallback workflows, and privacy-preserving logs. |
| [multilingual_path_encoding_compliance_publication.md](multilingual_path_encoding_compliance_publication.md) | Generalizes multilingual text, path, and encoding preservation for health-related workflows. |

## Explicitly Excluded Document

The following file is not part of the publication-oriented set:

```text
anexo_reglas_ESP.md
```

It may remain in the project as a source, translation, or working artifact, but it should not be treated as part of the English publication-ready rule set unless it is separately revised and anonymized.

## General Operating Model

The set is designed to be read as a layered framework:

1. **Start with [mdmake_publication_appendix.md](mdmake_publication_appendix.md).** Use it to understand how publication-ready Markdown should be structured, validated, and anonymized.
2. **Read the rule-specific appendix that matches the task.** Each rule covers one coherent domain of AI-assisted health workflow design.
3. **Customize the rule before reuse.** Replace all placeholders and adapt the guidance to the clinical setting, governance model, data workflow, software environment, and publication policy.
4. **Apply the AI interpretation instructions.** Each rule tells an AI system how to avoid over-specificity, unsafe assumptions, and personal or institutional disclosure.
5. **Run the validation checklist.** Each document includes a checklist to confirm that the adapted rule remains publication-safe and generalizable.

## How the Set Uses Agent Skills Principles

This set follows the Agent Skills specification and best-practice recommendations as an editorial framework rather than an operational package.

It preserves:

- skill-style `name` and `description` examples;
- concise activation descriptions;
- one coherent unit of work per rule;
- moderate detail;
- procedure-first guidance;
- gotchas and validation checklists;
- customization prompts;
- progressive disclosure through separate documents;
- explicit limits and non-operational framing.

It intentionally avoids:

- installable `SKILL.md` packaging;
- executable scripts;
- local paths;
- private project names;
- institution-specific identifiers;
- clinical data examples that could be mistaken for real data;
- claims of legal, regulatory, or clinical compliance.

## Recommended Use by Human Readers

Human readers should use the set as a methodological appendix for designing or reporting AI-agent guidance in digital health.

Before adapting any rule, the reader should define:

- the target clinical or research workflow;
- the intended users and user roles;
- the data governance requirements;
- the technical environment;
- the regulatory or ethics constraints;
- the publication and anonymization requirements;
- the validation procedure.

## Recommended Use by AI Systems

When an AI system reads this set, it should:

1. Treat the documents as publication appendices, not operational instructions.
2. Preserve all anonymization language.
3. Avoid adding personal, institutional, local-path, or project-specific details.
4. Use **customize according to needs** when context-specific details are missing.
5. Follow the validation checklist in each appendix before claiming that an adapted rule is publication-ready.
6. Distinguish between source rule logic, generalized guidance, and implementation-specific decisions.
7. Recommend human review for privacy, ethics, regulatory, clinical safety, and data governance decisions.

## Cross-Rule Customization Matrix

| Customization Domain | Relevant Appendix Area | Examples of What to Customize |
|---|---|---|
| Data governance | Data capture; field resilience | Consent model, privacy requirements, audit trail, data retention. |
| Technical stack | Data capture; document conversion; clinical software development; field resilience | Database, storage, conversion tools, logging systems, device environment. |
| Clinical workflow | Data capture; clinical software development; field resilience | User roles, assessment setting, field constraints, fallback actions. |
| Document workflow | Document conversion; multilingual path and encoding compliance | Source file types, OCR policy, Markdown structure, export target. |
| Multilingual context | Multilingual path and encoding compliance | Language, encoding, locale, path preservation, terminology. |
| AI behavior | All rules | Anonymization, assumptions, uncertainty reporting, validation checklists. |
| Publication policy | All rules | What must be removed, generalized, cited, or marked as customizable. |

## Quality Checklist for the Published Set

- [ ] All included files are written in English.
- [ ] Each rule is in a separate Markdown file.
- [ ] The set includes `mdmake_publication_appendix.md`.
- [ ] The set excludes `anexo_reglas_ESP.md`.
- [ ] Each rule is explicitly non-operational.
- [ ] Each rule contains publication-safe skill metadata.
- [ ] Each rule includes user customization guidance.
- [ ] Each rule includes AI interpretation instructions.
- [ ] Each rule includes a validation checklist.
- [ ] No personal, institutional, project-specific, or local-path details remain.
- [ ] The set cites the Agent Skills specification and best-practice guidance.

## Limitations

This set is a publication artifact. It does not validate software, certify clinical safety, create a regulated medical device process, or guarantee compliance with any local law or institutional policy. Any implementation derived from these documents must be reviewed and customized by qualified human stakeholders.

## References

1. Agent Skills. "Specification." Accessed 2026-06-08. <https://agentskills.io/specification>
2. Agent Skills. "Best practices for skill creators." Accessed 2026-06-08. <https://agentskills.io/skill-creation/best-practices>
