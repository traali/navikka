---
name: recurse_code_review_subtask
description: Recursively review a specific part of the codebase when the full task is too large/complex. Use this to decompose and analyze deeply.
---

# Recursive Code Review Subtask

## Purpose
This skill allows the agent to spawn a focused, deep-dive review process for a specific subset of the codebase. It is designed to handle complexity by breaking down large review tasks into manageable, recursive subtasks.

## Input Parameters
When activating this skill, you must define the following context:

1. **subtask_description** (string): 
   - One clear sentence: what exactly this recursive review should focus on.
   - Example: "Audit the `WeatherRepository` for proper error handling propagation."

2. **scope** (string):
   - Files, line ranges, or code section to review in this call.
   - Example: `lib/features/weather/data/repositories/weather_repository_impl.dart` and `lib/core/error/failures.dart`.

3. **specific_instructions** (string):
   - Detailed rules/guidance for this sub-review.
   - Example: "Focus specifically on whether `ServerException` is correctly caught and mapped to `ServerFailure` using `fpdart`'s `Left`."

## Execution Steps
You are now executing a recursive code review subtask.

**Focus ONLY on**: `{{specific_instructions}}`
**Scope**: `{{scope}}`
**Description**: `{{subtask_description}}`

### 1. Context Acquisition
- Use `view_file` to read the files defined in the **scope**.
- If the scope is broad (e.g., a directory), use `list_dir` or `find_by_name` first to identify relevant files.

### 2. Analysis & Recursive Decomposition
- Output your review findings in the standard format: file, lines, code snippet, description, severity, proof.
- **If this subtask is still too large**: stop, and validly "call" `recurse_code_review_subtask` again with a smaller scope.

### 3. Reporting
- When finished, output **FINAL SUBTASK REVIEW:** followed by your results.


## Example Usage
> "I need to review the authentication flow." -> Too big.
> 
> **Uses Skill**:
> - **subtask_description**: "Verify token persistence in `AuthLocalDataSource`."
> - **scope**: `lib/features/auth/data/sources/auth_local_data_source.dart`
> - **specific_instructions**: "Check that `sembast` is used correctly to store the token and that no plain-text logging of the token occurs."
