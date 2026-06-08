---
title: "Appendix Rule 4: Field Resilience and Failure Control"
summary: "Publication-oriented, non-operational adaptation of a failure control and resilience rule for digital health systems."
document_type: "journal_appendix_rule"
language: "en"
version: "1.0"
date: "2026-06-08"
status: "draft"
included_in_published_skill_set: true
intended_use: "Supplementary manuscript appendix; customize according to needs."
---

# Appendix Rule 4: Field Resilience and Failure Control

## Publication Notice

This document is a **publication-oriented adaptation** of an Agent Skills-style rule. It is not an installable `SKILL.md` file and does not prescribe a specific logging system, database, cloud service, sensor, or hardware platform.

All project-specific folders, debugging labels, device models, cloud services, and local documentation workflows must be replaced with **customize according to needs**.

## Publication-Safe Skill Metadata

```yaml
---
name: field-resilience-failure-control
description: Guide defensive design for digital health systems so clinical or field workflows continue safely when errors, network failures, device disconnections, sensor dropouts, or external service failures occur. Use when designing exception handling, fallback workflows, debugging logs, recovery states, or manual-entry alternatives.
---
```

## Purpose

The purpose of this rule is to reduce the risk that software failure interrupts clinical assessment, health research data capture, or field-based evaluation.

The rule emphasizes graceful degradation, transparent failure states, privacy-preserving logs, and manual fallback workflows.

## Scope

This rule applies to:

- clinical research applications;
- mobile or tablet-based assessments;
- sensor-assisted health workflows;
- wearable or peripheral device integrations;
- offline or low-connectivity environments;
- local and cloud synchronization failures;
- exception handling and debugging;
- user-facing recovery workflows.

## Core Principle

When a digital health system fails, it should fail visibly, recoverably, and safely. A failure should not silently corrupt data, freeze the interface, erase progress, expose sensitive information, or prevent the user from completing the clinical task when a safe manual fallback exists.

## Generalized Instructions

1. **Capture exceptions defensively.** Critical workflows should include structured error handling appropriate to the programming environment.
2. **Prevent abrupt collapse.** The application should avoid freezing, closing unexpectedly, or leaving users without next steps.
3. **Expose clear recovery states.** Users should know whether the system is saving, disconnected, waiting, failed, or ready for manual continuation.
4. **Create privacy-preserving logs.** Technical logs should capture enough information for debugging without exposing personal health information.
5. **Use timestamps and stable event identifiers.** Error events should be traceable without relying on patient-identifying data.
6. **Define manual fallback workflows.** If a sensor, network request, external service, or automated import fails, provide a safe manual alternative when appropriate.
7. **Preserve progress.** Temporary failures should not erase already captured data.
8. **Separate user messages from developer logs.** Clinical users need clear guidance; developers need technical detail. These should not be conflated.
9. **Escalate unresolved failures.** Define when a user should retry, switch to manual entry, contact support, stop the workflow, or document a protocol deviation.
10. **Review failure patterns.** Recurrent errors should feed back into system improvement, training, or protocol adaptation.

## Customization Guidance for Users

Before adapting this rule, the user should define:

| Customization Area | Questions to Answer |
|---|---|
| Failure types | Which failures are most likely: network, sensor, storage, authentication, export, device, or user-flow errors? |
| Manual fallback | What safe manual alternatives exist for each automated step? |
| Logging destination | Where are technical logs stored, reviewed, and protected? |
| Privacy limits | What information must never appear in error logs? |
| User messaging | What wording is appropriate for clinicians, researchers, staff, or participants? |
| Escalation pathway | Who should be notified when a failure blocks the workflow? |
| Sensor policy | Which devices or measurements require fallback entry, retry, or exclusion? |
| Audit requirements | What events must be documented for study integrity or clinical safety? |

## Instructions for AI Interpretation

When an AI system applies this rule:

1. Do not create logs that expose patient identifiers, private paths, credentials, tokens, or sensitive health details.
2. Replace specific cloud services, sensors, folders, and device names with **customize according to needs** unless a publication-safe example is explicitly requested.
3. Treat manual fallback as a safety and continuity feature, not as a lower-quality afterthought.
4. Distinguish between technical error handling, user-facing recovery, and study-protocol documentation.
5. Recommend human review for any safety-critical or regulatory failure pathway.
6. Do not claim that the system is clinically safe based only on software error handling.

## Validation Checklist

- [ ] The rule removes specific debugging folder names and local documentation paths.
- [ ] Error logs are described as privacy-preserving.
- [ ] Manual fallback workflows are included.
- [ ] Sensor, network, and external-service failures are generalized.
- [ ] User-facing messages and developer logs are separated.
- [ ] Escalation and audit needs are customizable.
- [ ] The document is framed as a publication appendix, not operational code.

## Limitations

This rule does not define a complete incident response plan, cybersecurity program, medical device risk management file, or clinical safety case. These must be developed according to the relevant clinical, regulatory, and institutional context.

## References

1. Agent Skills. "Specification." Accessed 2026-06-08. <https://agentskills.io/specification>
2. Agent Skills. "Best practices for skill creators." Accessed 2026-06-08. <https://agentskills.io/skill-creation/best-practices>

