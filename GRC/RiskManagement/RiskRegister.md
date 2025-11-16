# Risk Register Templates

## Corporate Risk

### Corporate Risk Register Template

| ID      | Risk Category | Date Added | Title         | Description                | Risk owner     | C   | I   | A   | Likelihood   | Impact       | Risk Score | Risk Level  | Risk Response | Risk Response Actions        | Risk Treatment Owner  | Risk Response Controls | Residual Likelihood | Residual Impact | Residual Risk Score | Residual Risk Level | Risk Reduction | Reviewed Date | Review Periodicity | Next Review Date | Review Comments                                                   | Status | Risk Comments                                         |
| ------- | ------------- | ---------- | ------------- | -------------------------- | -------------- | --- | --- | --- | ------------ | ------------ | ---------- | ----------- | ------------- | ---------------------------- | --------------------- | ---------------------- | ------------------- | --------------- | ------------------- | ------------------- | -------------- | ------------- | ------------------ | ---------------- | ----------------------------------------------------------------- | ------ | ----------------------------------------------------- |
| RIS-001 | Reputational  | 2023-01-01 | Title of Risk | Risk description goes here | John Doe - CEO | X   | O   | O   | Credible (3) | Moderate (3) | 3.6        | Medium Risk | Mitigate      | Develop Mitigation solutions | Jane Doe - Accounting | Control-X Do the thing | Remote (1)          | Moderate (3)    | 1.2                 | Low Risk            | 33%            | 2023-06-01    | 120d               | 2023-10-01       | 2023-06-01 - JD - All looks good, controls performing as expected | Open   | This risk was found during Go-Live of Project Poodles |

### Corporate Risk Categories

- Reputational
- Commercial
- Product
- Human Resources
- Operational
- Compliance
- Financial
- Other

### Corporate Risk Likelihood

| Likelihood         | Value |
| ------------------ | ----- |
| Remote (1)         | 1     |
| Unlikely (2)       | 2     |
| Credible (3)       | 3     |
| Likely (4)         | 4     |
| Almost Certain (5) | 5     |

### Corporate Risk Impact

| Impact            | Value |
| ----------------- | ----- |
| Insignificant (1) | 1     |
| Minor (2)         | 2     |
| Moderate (3)      | 3     |
| Major (4)         | 4     |
| Catastrophic (5)  | 5     |

### Corporate Risk Score Calculation

```
RISK = ((Liklihood x Impact) x 10) / 25
```

WTF is that!

Many people approach calculating the Risk Score as Likelihood multiplied by Impact. IMHO this leads to excessively high and somewhat incomprehensible scores. For example using a tradition 1 - 5 scale (1 low, 5 high) gives a lower bound of 1 (1 x 1 = 1) and an upper bound of 25 (5 x 5 = 25). I have found that people do not work well with a scale of 1 - 25, compared to a scale of 1 - 10. The above formula (stolen from SimpleRisk's blog here https://www.simplerisk.com/blog/normalizing-risk-scoring-across-different-methodologies) provides a Normalized score on a 1-10 scale.

### Corporate Risk Levels

- 0 -1 Insignificant
- 1-3 Low Risk
- 3-6 Medium Risk
- 6-9 High Risk
- 10 Very High Risk
