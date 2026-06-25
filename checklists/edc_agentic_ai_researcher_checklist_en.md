---
title: "Checklist for starting the development of an agentic AI-based EDC"
document_type: "researcher_checklist"
language: "en"
status: "publication_draft"
version: "1.0"
date: "2026-06-25"
intended_use: "Extensive guide for researchers planning electronic data capture systems for clinical data supported by agentic AI."
audience:
  - "Clinical researchers"
  - "Medical informatics teams"
  - "Study coordinators"
  - "Development and validation teams"
keywords:
  - "EDC"
  - "agentic AI"
  - "clinical data capture"
  - "medical informatics"
  - "human-in-the-loop"
---

# Checklist for starting the development of an agentic AI-based EDC

## Purpose

This checklist is designed to support researchers and medical informatics teams before starting the development of an electronic data capture (EDC) application supported by agentic AI. Its purpose is to turn implicit decisions into explicit, reviewable, and traceable criteria.

It should be understood as a methodological planning guide, not as a technical, regulatory, ethical, or clinical certification. Each item should be adapted to the needs of the study, local regulations, data type, available resources, and project risk level.

## How to use this checklist

- [ ] Complete the general project information first.
- [ ] Review each section before starting development.
- [ ] Mark as pending any item that requires an institutional, technical, or clinical decision.
- [ ] Record responsible parties and evidence of completion when needed.
- [ ] Repeat the review whenever the protocol, clinical workflow, data model, technology platform, or agent rules change.

## General project information

- [ ] Project or study name: **[COMPLETE]**
- [ ] Institution or responsible team: **[COMPLETE]**
- [ ] Principal investigator or methodological lead: **[COMPLETE]**
- [ ] Technical lead: **[COMPLETE]**
- [ ] Planning start date: **[COMPLETE]**
- [ ] Checklist version: **[COMPLETE]**
- [ ] Expected scope of the EDC: **[COMPLETE]**
- [ ] Population, clinical setting, or context of use: **[COMPLETE]**

## A. General planning

- [ ] Clearly define the clinical, operational, or research objective that the application will address.
- [ ] Describe the workflows that the EDC should support, replace, or improve.
- [ ] Identify end users: researchers, clinicians, patients, evaluators, monitors, administrators, or others.
- [ ] Describe the main needs of each user type.
- [ ] Define minimum operating criteria before starting development.
- [ ] Define which elements belong to the minimum viable product and which elements will remain for later phases.
- [ ] Identify institutional, regulatory, logistical, or budgetary constraints.
- [ ] Define how relevant decisions will be documented during development.

**Customize as needed:** study type, number of centers, complexity of the clinical workflow, desired level of automation, user availability for validation, and requirements from the ethics committee or institution.

## B. Agent rules and development context

- [ ] Define permanent rules to guide AI use during development.
- [ ] Document whether skills, operational instructions, base prompts, repository rules, or other guidance mechanisms will be used.
- [ ] Select and document existing reusable capabilities, if applicable.
- [ ] Identify new rules that must be developed specifically for the project.
- [ ] Declare the technical knowledge level of the research team to adjust the type of instructions.
- [ ] Request step-by-step instructions when procedures are manual, critical, or potentially risky.
- [ ] Define which tasks the AI may propose and which tasks require explicit human authorization.
- [ ] Define how AI-generated outputs will be reviewed before being incorporated into the project.

**Customize as needed:** technical experience of the team, available AI tools, institutional AI policies, working language, depth of human supervision, and permitted level of autonomy.

## C. Technology environment

- [ ] Define the target platform: web, Android, iOS, Windows, hybrid application, desktop application, or another option.
- [ ] Specify the development operating system.
- [ ] Record versions of Python, Node.js, Java, Android SDK, Gradle, or other relevant dependencies.
- [ ] Identify external tools required for development, testing, deployment, or documentation.
- [ ] Define the primary language of the interface and documentation.
- [ ] Define character encoding and file naming rules.
- [ ] Define regional formats: decimal separator, date, time, units, and time zone.
- [ ] Assess whether the system will require internationalization or multilingual support.
- [ ] Record limitations of the local, institutional, or connectivity environment.

**Customize as needed:** institutional infrastructure, available devices, field connectivity, interoperability requirements, and tools approved by the organization.

## D. System architecture

- [ ] Document the general architecture before starting development.
- [ ] Keep technical documentation accessible to the team and to the AI.
- [ ] Define the project directory structure.
- [ ] Document selected technologies, libraries, and frameworks.
- [ ] Identify external services, APIs, databases, or institutional systems.
- [ ] Document the main data flows.
- [ ] Record critical dependencies and their role within the system.
- [ ] Define data exchange contracts, for example JSON, CSV, HL7 FHIR, or other formats.
- [ ] Clearly separate frontend, backend, persistence, external services, and clinical logic.
- [ ] Define which components should be replaceable without compromising the whole system.

**Customize as needed:** project complexity, offline use, integration with clinical systems, data regulations, and the technical capacity of the team.

## E. Data model

- [ ] Design data schemas before developing the interface.
- [ ] Define allowed data types for each variable.
- [ ] Establish validation rules for required fields, ranges, formats, and expected values.
- [ ] Define unique identifiers for patients, records, visits, sessions, or measurements.
- [ ] Use consistent naming for variables, tables, forms, and exports.
- [ ] Define the format of dates, times, time zones, and timestamps.
- [ ] Define the export architecture for analysis: CSV, JSON, XLSX, or another format.
- [ ] Establish conventions for decimals, measurement units, encoding, and missing values.
- [ ] Define how data model changes will be handled during the study.
- [ ] Document data dictionaries, labels, operational definitions, and derived rules.

**Customize as needed:** statistical analysis plan, clinical instruments, primary variables, interoperability standards, audit needs, and export requirements.

## F. Persistence and security

- [ ] Define where data will be stored: institutional server, Supabase, local database, private cloud, or another option.
- [ ] Define whether data redundancy will be required.
- [ ] Establish whether the application will need offline functionality.
- [ ] Define automatic or manual synchronization rules.
- [ ] Define failure recovery mechanisms.
- [ ] Identify sensitive data, personal data, and protected clinical data.
- [ ] Define role-based authentication and authorization.
- [ ] Establish access policies, event logging, and audit procedures.
- [ ] Assess informed consent, privacy, and local regulatory requirements.
- [ ] Define procedures for security incidents or data loss.

**Customize as needed:** applicable law, institutional policies, data sensitivity, geographic location of storage, and clinical risk level.

## G. Development strategy

- [ ] Divide development into small, verifiable, and independent tasks.
- [ ] Prioritize a minimum viable product before adding advanced features.
- [ ] Validate each modification before continuing with new features.
- [ ] Avoid broad or ambiguous requests to the AI when technical precision is required.
- [ ] Record design decisions, discarded alternatives, and justifications.
- [ ] Maintain a list of pending tasks, blockers, and risks.
- [ ] Separate functional, visual, documentation, and infrastructure changes.
- [ ] Periodically check that development remains aligned with the clinical objective.

**Customize as needed:** team availability, study timeline, delivery criteria, working model, and project management tools.

## H. Human supervision and human-in-the-loop

- [ ] Define who is responsible for supervising AI actions.
- [ ] Review generated code before incorporating it into stable versions.
- [ ] Validate that clinical logic is correct and understandable.
- [ ] Review user experience with representative users.
- [ ] Evaluate visibility, control size, navigation, accessibility, and clinical usability.
- [ ] Define which decisions cannot be delegated to AI.
- [ ] Record discrepancies between AI recommendations and final human decisions.
- [ ] Establish a review process for changes that affect clinical data or safety.

**Customize as needed:** risk level, team experience, patient participation, clinical supervision, and audit requirements.

## I. Testing strategy

- [ ] Define a test plan before starting development.
- [ ] Include normal use scenarios.
- [ ] Include adverse scenarios and field conditions.
- [ ] Test loss of Internet connection.
- [ ] Test loss of Bluetooth connection, if applicable.
- [ ] Test application suspension and resumption.
- [ ] Test screen orientation, screen lock, and device changes.
- [ ] Test low battery, reduced screen brightness, and operating system interruptions.
- [ ] Define objective acceptance criteria.
- [ ] Record test results, errors found, and corrections made.
- [ ] Repeat tests after changes that affect data, interface, or synchronization.

**Customize as needed:** available real devices, context of use, data criticality, expected connectivity, and fieldwork conditions.

## J. Traceability and version control

- [ ] Select a version control strategy.
- [ ] Record the initial system architecture.
- [ ] Document relevant changes in code, data, interface, and agent rules.
- [ ] Record deployed versions and delivery dates.
- [ ] Maintain a history of incidents, corrections, and decisions.
- [ ] Keep documentation synchronized with the actual state of the code.
- [ ] Define conventions for branch names, commits, releases, and tags.
- [ ] Link relevant changes to requests, issues, or documented decisions.

**Customize as needed:** repository used, publication policies, private or public repositories, DOI integration, Zenodo, or other preservation systems.

## K. Backup and recovery

- [ ] Define backup frequency.
- [ ] Back up source code.
- [ ] Back up the database or data files.
- [ ] Back up documentation, configurations, and deployment files.
- [ ] Maintain identifiable stable functional versions.
- [ ] Periodically verify that restoration works.
- [ ] Define responsible parties for backup and recovery.
- [ ] Document the location, access, and restrictions of each backup.
- [ ] Define procedures for device loss, data corruption, or human error.

**Customize as needed:** study criticality, data volume, capture frequency, institutional policies, and restoration capacity.

## L. Operational limitations of AI

- [ ] Identify the AI platform used during development.
- [ ] Document context, usage, cost, API, availability, and model limits.
- [ ] Record model or tool versions when relevant.
- [ ] Define alternatives if the AI service is unavailable.
- [ ] Assess the impact of free, freemium, or changing commercial plans.
- [ ] Establish which decisions require human review even if generated by AI.
- [ ] Record uncertainties, assumptions, and errors detected in AI responses.
- [ ] Define how the project will be updated if agent capabilities change.

**Customize as needed:** AI provider, privacy restrictions, budget, institutional access, technology dependency, and risk tolerance.

## Preparation close-out

Before starting development, the team should be able to answer yes to the following:

- [ ] The system objective is clearly defined.
- [ ] The initial data model is documented.
- [ ] The initial architecture is documented.
- [ ] The AI use rules are documented.
- [ ] Human leads exist for clinical, technical, and methodological supervision.
- [ ] Minimum acceptance criteria exist.
- [ ] A testing strategy exists.
- [ ] A backup strategy exists.
- [ ] There is enough traceability to reconstruct relevant decisions.

## Adaptation note

This checklist may be expanded, shortened, or reorganized according to the type of research, technological maturity of the team, data sensitivity, and regulatory requirements. For best results, replace each **[COMPLETE]** marker with project-specific information and add technical appendices when decisions require greater detail.
