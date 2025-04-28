# Creator Earnings API Test Plan

## Unit Tests  
**Scope**: Earnings calculation logic and permissions  

| Component                | Test Cases                              | Validation Criteria                          |
|--------------------------|----------------------------------------|---------------------------------------------|
| **EarningsService**      | - Single creator with multiple sales<br>- Creator with no purchases<br>- Deleted assets exclusion<br>- Currency formatting<br>- Multi-creator aggregation | Accurate earnings summation                 |
| **Ability Class**        | - Admin access to earnings endpoint<br>- Creator/customer access denial<br>- Unauthenticated blocking | Strict admin-only access enforcement        |

---

## Integration Tests  
**Scope**: API endpoint behavior and data flows  

| Area                     | Test Scenarios                          | Success Criteria                            |
|--------------------------|----------------------------------------|---------------------------------------------|
| **API Response**         | - Proper JSON structure<br>- HTTP 200 for valid requests<br>- Empty array for no creators<br>- Decimal precision handling | Maintains consistent response format        |
| **Data Accuracy**        | - Purchases across multiple assets<br>- Filtered scope (active creators only)<br>- Time-bound earnings (if implemented) | Matches database aggregates                 |
| **Authorization**        | - Admin token validation<br>- Invalid token rejection<br>- Role-based access control | Prevents privilege escalation               |

---

## System Tests  
**Scope**: End-to-end API consumption  

| User Flow                | Key Validations                        | Acceptance Criteria                         |
|--------------------------|----------------------------------------|---------------------------------------------|
| **Admin Access**         | - Successful authentication<br>- Response header validation<br>- TLS enforcement | Secures sensitive financial data            |
| **Data Sanity**          | - Earnings match test seed data<br>- Negative value prevention<br>- NULL handling in joins | Ensures reliable financial reporting        |
| **Performance**          | - 1000-creator load test<br>- Caching behavior (if implemented)<br>- Concurrent access handling | Maintains service reliability               |

---
