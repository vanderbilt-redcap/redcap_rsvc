# REDCap Regulatory & Software Validation Committee (RSVC)

Welcome to the Regulatory and Software Validation Committee (RSVC) GitHub repository. This repository is dedicated to hosting automated validation test scripts for REDCap's core functionality, as developed and maintained by our automated testing subcommittee.

## About RSVC

The Regulatory and Software Validation Committee (RSVC) is a dedicated group committed to ensuring regulatory compliance with Good Clinical Practice (GCP) International Council for Harmonisation (ICH) E6(R2) and The United States Food and Drug Administration (FDA) Code of Federal Regulations (CFR) Title 21 Part 11 regulations while validating the core functionality of REDCap. Our committee compiles valuable resources, creates step-by-step feature tests, and provides a platform for collaboration and knowledge sharing.

## Automated Validation Test Scripts

Within this repository, you will find a collection of validation test scripts meticulously crafted by the Regulatory and Software Validation committee. These scripts are designed to assess and validate REDCap's core functionality comprehensively. Consortium partners and REDCap users can utilize these scripts to ensure the robustness and compliance of their REDCap installations.  These scripts are intended to be run using the [REDCap Cypress Developer Toolkit](https://github.com/vanderbilt-redcap/redcap_cypress_docker/blob/main/README.md).

## Core vs. Non-Core Definitions

- **Core:** Functions that are fundamental to REDCap’s operation as an electronic data capture (EDC) system. These are the baseline features that every REDCap site depends on (e.g., data entry, user rights, logging, project setup). RSVC/RVP always assigns these functions into **Tier A or B** depending on where testing occurs (admin vs. project level).   
- **Non-Core:** Functions that extend or enhance REDCap but are **not required for baseline operation**. They may be valuable, widely used, or site-specific (e.g., survey queue, action tags, scheduling). Some non-core items are maintained and tested by RSVC/RVP (**Tier C**), while others are left to site responsibility (**Tier D**).
    
## RSVC/RVP Tier Definitions (A–E)

| Tier                                | Definition                                                                                                                            | Ownership / Notes                                                                                |
|-------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
|**A – Core<br>Admin-Level**            |Core REDCap functionality that is primarily **Control Center** or otherwise requires **Admin-level testing**.                          |RSVC defines requirements; sites execute tests (manual or automated where possible).              |
|**B – Core<br>Project-Level**          |Core REDCap functionality that is **not in Tier A**, generally at the **project level** and does not require admin testing.            |RSVC defines requirements and provides automated tests where possible; sites run locally.         |
|**C – Non-Core<br>RSVC/RVP Maintained**|Non-core functionality that RSVC/RVP have chosen to **own and maintain**. Requirements and tests are updated with each package release.|RSVC/RVP responsibility to publish tests; sites may choose to run.                                |
|**D – Site-Managed**                 |Either: (1) Core features that RSVC/RVP **cannot feasibly test**, or (2) Non-core features **not covered by RSVC/RVP**.                |Site responsibility to determine scope and perform validation. RSVC list is **not comprehensive**.|
|**E – External Modules**             |Functionality provided by external modules, developed outside Vanderbilt’s core REDCap code.                                           |Always **site responsibility** to validate; module developer may assist but RSVC/RVP do not test. |

## Contribution

We welcome contributions and collaboration from the REDCap community and regulatory compliance enthusiasts. If you have expertise in regulatory compliance, validation, or REDCap, feel free to join our efforts by contributing to this repository.  The stable version of the scripts used to validate the last LTS package can be found in the `main` branch.  Pull requests should be made against the `staging` branch, as it contains the changes being actively developed for staging the next LTS package.  Anyone is welcome to take on any task in the `Unassigned` column of [our work queue](https://github.com/orgs/vanderbilt-redcap/projects/2).  If you do so, please move the task to the `In Progress` column and comment on it, or assign it to yourself if you have the appropriate access.  This indicates ownership and avoids duplicate effort. Once you've completed one or more features, they can submitted via a pull request (if you're familiar with that process), or by emailing the relevant files to mark.mcever@vumc.org.

## Managing Our Work Queue

[Our work queue](https://github.com/orgs/vanderbilt-redcap/projects/2) uses standard GitHub issues to track individual items that need to be addressed.  Issues can be added via the following steps:
1. Ensure you are added to both [our GitHub organization](https://github.com/vanderbilt-redcap) and [our project](https://github.com/orgs/vanderbilt-redcap/projects/2/settings/access) so that you have access to add items 
1. Click `+ Add Item` at the bottom of the `Unassigned` column
1. Type a short title/summary of the new issue
1. Click `Create new issue`
1. Select `vanderbilt-redcap/redcap_rsvc` from the `Repository` dropdown
1. Click the `Blank issue` template
1. Enter a description of the issue including any details needed to make progress on it
1. Click the `Create` button
1. If the issue is high priority, drag it to/near the top of the `Unassigned` column so it is worked on before the issues below it

Issues can also be added en masse included auto-populated links to feature files by placing their test IDs (e.g. A.3.14.1300.) one per line in `features.csv` and running `create_issues.sh`.

## More Information

For more information about the Regulatory & Software Validation Committee (RSVC) and our initiatives, including regulatory compliance resources and feature tests, please refer to our [main page](link-to-main-page).

Thank you for your interest in ensuring the quality and compliance of REDCap through manual validation test scripts. Together, we can enhance the reliability of REDCap for critical research and clinical projects.

## Reference

Baker TA, Bosler T, De Fouw ALC, Jones M, Harris PA, Cheng AC. Consortium-Driven Rapid Software Validation for Research Electronic Data Capture (REDCap). Journal of Clinical and Translational Science. Published online 2024:1-18. doi:10.1017/cts.2024.671
