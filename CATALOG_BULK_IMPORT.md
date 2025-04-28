
# Catalog Bulk Import Test Plan

## Unit Tests  
**Scope**: Individual components in isolation  

| Component            | Test Cases                              | Validation Criteria                          |
|----------------------|----------------------------------------|---------------------------------------------|
| **Asset Model**      | - Required fields (`title`,`description`,  `file_url`, `price`)<br>- Price ≥ 0 validation<br>- File URL format validity | Rejects invalid data before persistence     |
| **AssetImportService** | - File size validation (≤5MB)<br>- MIME type rejection<br>- JSON parsing errors<br>- Transaction rollback on partial failure<br>- Empty JSON handling | Returns precise error messages              |
| **Ability Class**    | - Creator access to `bulk_import`<br>- Non-creator denial | Prevents unauthorized actions via CanCanCan |

---

## Integration Tests  
**Scope**: Component interactions & workflows  

| Area                 | Test Scenarios                          | Success Criteria                            |
|----------------------|----------------------------------------|---------------------------------------------|
| **Controller Flow**  | - 403 Forbidden for non-creators<br>- File param forwarding<br>- Error response formatting<br>- Redirect after success/failure | Maintains role-based access control         |
| **Service Integration** | - Valid JSON creates DB records<br>- Mixed data triggers rollback<br>- Owner assignment accuracy<br>- Error propagation to UI | Atomic transaction integrity                |
---

## System Tests  
**Scope**: End-to-end user journeys  

| User Flow            | Key Validations                        | Acceptance Criteria                         |
|----------------------|----------------------------------------|---------------------------------------------|
| **File Upload UI**   | - JSON file type restriction<br>- Upload button state<br>- Alert on invalid selection | Prevents non-JSON submissions client-side   |
| **Feedback & Display** | - Success notice with count<br>- Error message clarity<br>- Pagination sync<br>- Asset list update | Provides real-time user guidance            |
| **Edge Scenarios**   | - 5MB file handling<br>- Mixed encoding files<br>- Concurrent uploads<br>- Special character URLs | Maintains stability under unusual conditions |

---
