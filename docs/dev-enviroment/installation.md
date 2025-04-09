# Run Script (`run.sh`) Guide

This guide explains the `run.sh` script, a utility designed to execute multiple scripts located within a `./scripts/` subdirectory relative to its own location. It provides features for filtering which scripts to run and performing a dry run before actual execution.

## Overview

The `run.sh` script acts as a runner or orchestrator for other scripts. It finds executable files within the `./scripts` directory and executes them, optionally filtering based on a provided pattern and always performing a dry run first to show what will happen.

## How it Works

1.  **Initialization:**
    * Determines its own directory.
    * Finds all executable files directly inside the `./scripts` subdirectory.
    * Initializes variables for filtering and dry-run mode.

2.  **Argument Parsing:**
    * The script accepts optional command-line arguments:
        * `--dry`: If present, the script will only perform the dry run phase and will not ask for confirmation or execute scripts.
        * `<filter>`: Any other argument is treated as a text filter. Only scripts whose paths contain this text will be considered for execution.

3.  **Dry Run Phase:**
    * The script *always* performs a dry run first.
    * It iterates through the found scripts.
    * If a filter was provided, it checks if the script's path matches the filter. Scripts that don't match are skipped.
    * It logs which scripts would be executed and which are filtered out, prefixed with `[DRY_RUN]:`. No scripts are actually executed in this phase.

4.  **Confirmation (Interactive Mode):**
    * If the `--dry` flag was *not* provided initially, the script asks for user confirmation after the dry run is complete.
    * It prompts: "Dry run completed. Do you want to proceed with actual execution? (y/n)".
    * If the user responds with anything other than 'y' or 'Y', the execution is canceled.

5.  **Execution Phase:**
    * This phase only runs if the `--dry` flag was not provided *and* the user confirmed 'y' in the interactive prompt.
    * It iterates through the scripts again, applying the same filtering logic as in the dry run.
    * For each matching script, it logs that it's running the script and then executes it.

6.  **Dry Run Completion Message:**
    * If the `--dry` flag *was* provided initially, after the dry run phase, it simply prints: "Dry run completed. No actual execution requested." and exits.

## Usage Examples

* **Run all scripts in `./scripts` (after dry run and confirmation):**
    ```bash
    ./run.sh
    ```

* **Perform only a dry run of all scripts:**
    ```bash
    ./run.sh --dry
    ```

* **Run only scripts with "aws" in their path (after dry run and confirmation):**
    ```bash
    ./run.sh aws
    ```

* **Perform only a dry run for scripts with "aws" in their path:**
    ```bash
    ./run.sh aws --dry
    # or
    ./run.sh --dry aws
    ```

## Key Features

* **Safety:** Always performs a dry run before making changes.
* **Interactivity:** Requires user confirmation before actual execution unless run explicitly in dry mode.
* **Filtering:** Allows selective execution of scripts based on their path names.
* **Organization:** Expects target scripts to be located within a dedicated `./scripts` directory.