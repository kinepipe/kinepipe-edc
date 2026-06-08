---
title: "Appendix Rule 3: Clinical Software Development and Usability Practices"
summary: "Publication-oriented, non-operational adaptation of a development and UI/UX rule for general digital health software workflows."
document_type: "journal_appendix_rule"
language: "en"
version: "1.0"
date: "2026-06-08"
status: "draft"
included_in_published_skill_set: true
intended_use: "Supplementary manuscript appendix; customize according to needs."
---

# Appendix Rule 3: Clinical Software Development and Usability Practices

## Publication Notice

This document is a **publication-oriented adaptation** of an Agent Skills-style rule. It is not an installable `SKILL.md` file and should not be interpreted as a complete software engineering standard. It presents generalized guidance for AI-assisted design, development, debugging, and documentation of digital health tools.

All specific applications, version numbers, institutional systems, local documentation repositories, visual identities, and technology stacks must be replaced with **customize according to needs**.

## Publication-Safe Skill Metadata

```yaml
---
name: clinical-software-development
description: Guide AI-assisted development of usable, robust, and maintainable digital health software. Use when designing interfaces, implementing workflows, debugging features, documenting changes, preserving working functionality, or adapting health software for mobile, tablet, laboratory, clinical, or field environments.
---
```

## Purpose

The purpose of this rule is to translate clinical workflow needs into software development practices that support usability, maintainability, data quality, and safe field operation.

The rule is designed for AI-assisted development contexts where human experts define clinical, methodological, or operational requirements and the AI agent helps implement, document, or refine the software.

## Scope

This rule applies to:

- digital health applications;
- clinical research data capture tools;
- mobile or tablet assessment interfaces;
- clinician-facing dashboards;
- participant-facing forms;
- field assessment workflows;
- import/export utilities;
- debugging and version documentation;
- UI/UX improvements for health contexts.

## Core Principle

Clinical software should be designed for repeated use under real-world constraints: limited time, variable lighting, interruptions, gloves or touch interaction, unstable connectivity, and the need to preserve valid data without increasing user burden.

## Generalized Instructions

1. **Complete requested changes.** Do not leave user-facing tasks partially implemented when a complete and verifiable result is feasible.
2. **Document meaningful changes.** Maintain a clear change log or implementation note with version, date, scope, and unresolved issues. Customize according to needs.
3. **Preserve working functionality.** Avoid rewriting stable modules unless necessary to fix a serious defect, reduce risk, or satisfy a clearly defined requirement.
4. **Support essential data operations.** Where appropriate, provide save, edit, import, export, delete, review, and recovery workflows.
5. **Design for clinical usability.** Use clear labels, readable typography, high contrast, predictable layouts, and accessible interaction patterns.
6. **Optimize for touch and mobility.** Buttons, form fields, sliders, and navigation controls should be usable on tablets and mobile devices.
7. **Avoid unnecessary interruptions.** Reduce intrusive modals, unexpected page changes, and hidden save states.
8. **Use responsive design.** Interfaces should adapt to device orientation, screen size, and common field-use constraints.
9. **Provide flexible import/export.** Health teams may need CSV, spreadsheet, PDF, text, or standards-based formats. Customize according to needs.
10. **Manage context and workload.** For large AI-assisted tasks, break work into reviewable units and validate each unit before continuing.
11. **Use external documentation responsibly.** If a knowledge base, note system, or project repository is used, represent it generically and avoid local path disclosure.

## Customization Guidance for Users

Before adapting this rule, the user should define:

| Customization Area | Questions to Answer |
|---|---|
| User roles | Who uses the system: clinicians, researchers, assistants, participants, administrators, or mixed teams? |
| Clinical setting | Is the tool used in a clinic, laboratory, field visit, classroom, telehealth workflow, or home environment? |
| Accessibility needs | What visual, motor, language, or cognitive accessibility requirements apply? |
| Device profile | Which devices, screen sizes, browsers, operating systems, or peripherals are expected? |
| Design system | Is there an approved visual language, component library, or accessibility standard? |
| Export formats | Which output formats are required for analysis, reporting, audit, or publication? |
| Documentation | Where should change logs, design notes, and unresolved issues be recorded? |
| Validation | What tests, inspections, or human review steps are required before deployment? |

## Instructions for AI Interpretation

When an AI system applies this rule:

1. Do not impose a specific aesthetic style unless the user defines one.
2. Prefer usability, accessibility, readability, and workflow safety over decorative complexity.
3. Preserve existing working features unless the requested change requires modification.
4. Do not add real project names, institutional branding, local paths, or private repositories.
5. Recommend user review for clinical wording, scoring logic, consent text, and safety-critical workflows.
6. Report assumptions, incomplete validation, and unresolved risks clearly.

## Validation Checklist

- [ ] The rule is generalized for digital health or clinical research.
- [ ] Specific app names, local vaults, technologies, and private workflows have been removed or replaced.
- [ ] UI/UX guidance emphasizes usability, accessibility, and field constraints.
- [ ] Versioning and change documentation are described generically.
- [ ] Import/export needs are customizable.
- [ ] The AI instructions prevent unnecessary rewrites and unsupported assumptions.
- [ ] The document is publication-oriented and non-operational.

## Limitations

This rule does not replace formal software lifecycle standards, medical device regulation, cybersecurity review, usability testing, clinical safety assessment, or institutional deployment approval. These must be customized according to needs.

## References

1. Agent Skills. "Specification." Accessed 2026-06-08. <https://agentskills.io/specification>
2. Agent Skills. "Best practices for skill creators." Accessed 2026-06-08. <https://agentskills.io/skill-creation/best-practices>

