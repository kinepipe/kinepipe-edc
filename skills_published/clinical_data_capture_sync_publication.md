---
title: "Appendix Rule 1: Clinical Data Capture and Synchronization"
summary: "Publication-oriented, non-operational adaptation of a data capture and synchronization rule for digital health and clinical research workflows."
document_type: "journal_appendix_rule"
language: "en"
version: "1.0"
date: "2026-06-08"
status: "draft"
included_in_published_skill_set: true
intended_use: "Supplementary manuscript appendix; customize according to needs."
---

# Appendix Rule 1: Clinical Data Capture and Synchronization

## Publication Notice

This document is a **publication-oriented adaptation** of an Agent Skills-style rule. It is not an installable `SKILL.md` file and should not be treated as an operational software artifact. It is intended to document a reusable methodological pattern for digital health, clinical research, and field-based health data capture.

All identifying information, local infrastructure, institution-specific workflows, project names, country-specific identifiers, and proprietary configurations must be replaced with **customize according to needs** before publication or reuse.

## Publication-Safe Skill Metadata

```yaml
---
name: clinical-data-capture-sync
description: Guide safe capture, persistence, backup, and synchronization of clinical or health research data. Use when designing or reviewing digital forms, field data collection workflows, offline-first capture, missing-data handling, or synchronization logic in health-related software.
---
```

## Purpose

The purpose of this rule is to preserve the integrity, traceability, and continuity of clinical or health research data captured through digital forms, mobile interfaces, tablets, wearable devices, or hybrid field workflows.

This rule generalizes the original data capture logic into a broader digital health context where data may be entered by clinicians, evaluators, researchers, participants, or trained staff under variable connectivity and workload conditions.

## Scope

This rule applies to:

- clinical data capture forms;
- participant or patient assessment workflows;
- mobile or tablet-based field data collection;
- offline-first health applications;
- synchronization between local and remote data stores;
- explicit missing-data recording;
- clinical audit trails and recovery workflows;
- health research systems where data loss could affect validity, safety, or reproducibility.

## Core Principle

Every data field in a health workflow should be treated as potentially meaningful. The system should distinguish between:

- data that were intentionally entered;
- data that were intentionally left blank;
- data that were unavailable;
- data that failed to load;
- data that failed to synchronize;
- data that were later corrected.

## Generalized Instructions

1. **Persist data early and frequently.** Save user-entered values as soon as they are typed, selected, scanned, uploaded, or otherwise captured.
2. **Do not rely only on final submission.** A final "save" or "submit" button may remain useful, but it should not be the only persistence mechanism.
3. **Record missingness explicitly.** Empty, skipped, not applicable, refused, unavailable, and failed-to-load fields should be distinguishable according to the study or clinical workflow.
4. **Maintain a local backup before remote synchronization.** Use a local persistence layer suitable for the device and privacy model.
5. **Synchronize with stable identifiers.** Use non-identifying, study-approved, or governance-approved identifiers rather than personal identifiers whenever possible.
6. **Support offline-first operation.** Field conditions, clinics, laboratories, homes, and community settings may have unstable connectivity.
7. **Track synchronization state.** Represent whether records are pending, synced, conflicted, failed, or manually resolved.
8. **Protect sensitive data.** Apply data minimization, encryption, access control, and governance procedures appropriate to the health context.
9. **Preserve an audit trail.** Record timestamps, actor roles, version changes, and correction events when required by the protocol.
10. **Validate before finalization.** Run field-level, form-level, and record-level checks before a record is considered complete.

## Customization Guidance for Users

Before adapting this rule, the user should define:

| Customization Area | Questions to Answer |
|---|---|
| Data governance | What privacy, ethics, regulatory, or institutional requirements apply? |
| Identifier strategy | What participant, patient, encounter, device, or record identifiers are allowed? |
| Local storage | What local persistence mechanism is acceptable for the device and risk profile? |
| Remote backend | What database, registry, EDC system, or secure repository will receive synchronized data? |
| Missing-data codes | How should blank, unknown, refused, not applicable, unavailable, and failed fields be represented? |
| Synchronization model | Is the workflow one-way push, two-way sync, batch upload, or manual reconciliation? |
| Conflict resolution | Who resolves conflicting records and according to what rule? |
| Audit trail | What events must be logged for reproducibility or compliance? |
| Clinical context | Is the workflow used in a clinic, laboratory, community setting, home visit, or emergency context? |

## Instructions for AI Interpretation

When an AI system applies this rule:

1. Do not insert real personal identifiers, patient data, institutional names, or local paths.
2. Replace specific databases, applications, sensors, or national identifiers with **customize according to needs** unless the user explicitly provides a publication-safe substitute.
3. Prioritize data integrity, privacy, and explicit missing-data handling over interface convenience.
4. Treat offline-first persistence and synchronization state as core design requirements, not optional enhancements.
5. Recommend human review for any identifier, privacy, encryption, or regulatory decision.
6. Avoid claiming compliance with a regulation unless the user provides the relevant legal or institutional context.

## Validation Checklist

- [ ] The rule does not include personal, institutional, local-path, or project-specific identifiers.
- [ ] The identifier strategy is generalized or marked as **customize according to needs**.
- [ ] Missing-data categories are explicit.
- [ ] Local backup and remote synchronization are described separately.
- [ ] Synchronization states and failure states are represented.
- [ ] Privacy and data governance are included as design constraints.
- [ ] The rule is framed for broad digital health or clinical research use.
- [ ] The document is written as a publication appendix, not an operational implementation file.

## Limitations

This rule does not define a specific database schema, encryption method, consent model, or regulatory compliance pathway. Those elements must be customized according to the clinical setting, study protocol, data governance framework, and local regulations.

## References

1. Agent Skills. "Specification." Accessed 2026-06-08. <https://agentskills.io/specification>
2. Agent Skills. "Best practices for skill creators." Accessed 2026-06-08. <https://agentskills.io/skill-creation/best-practices>

