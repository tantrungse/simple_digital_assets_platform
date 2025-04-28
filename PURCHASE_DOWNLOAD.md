# Purchase & Download Test Plan

## Unit Tests  
**Scope**: Core model validations and permissions  

| Component            | Test Cases                              | Validation Criteria                          |
|----------------------|----------------------------------------|---------------------------------------------|
| **Purchase Model**   | - Unique asset per customer constraint<br>- Customer/asset associations<br>- Error on duplicate purchase | Prevents duplicate purchases                |
| **Asset Model**      | - Price ≥ 0 validation<br>- Creator association<br>- Purchases relationship<br>- Buyers through purchases | Maintains asset integrity                   |
| **Ability Class**    | - Customer access to shop/purchases<br>- Purchase creation rights<br>- Creator shop access denial | Enforces role-based access control          |

---

## Integration Tests  
**Scope**: Controller workflows and business logic  

| Area                 | Test Scenarios                          | Success Criteria                            |
|----------------------|----------------------------------------|---------------------------------------------|
| **Purchase Flow**    | - Successful purchase creation<br>- Duplicate purchase rejection<br>- Correct asset assignment<br>- Purchase history update | Maintains transactional integrity           |
| **Shop Interface**   | - Available assets display<br>- "Already Purchased" tagging<br>- Guest user restrictions<br>- Pagination consistency | Ensures accurate store representation       |
| **Authorization**    | - Customer access to shop/purchases<br>- Creator purchase attempt blocking<br>- Unauthenticated redirects | Validates CanCanCan permission enforcement  |

---

## System Tests  
**Scope**: End-to-end customer journey  

| User Flow            | Key Validations                        | Acceptance Criteria                         |
|----------------------|----------------------------------------|---------------------------------------------|
| **Shop Browsing**    | - Asset list with prices/creators<br>- Purchase button visibility<br>- Signed-in state detection<br>- Pagination navigation | Provides intuitive shopping experience      |
| **Purchase Process** | - Purchase confirmation dialog<br>- Success notification<br>- Automatic history update<br>- Disabled repurchase option | Delivers immediate feedback                 |
| **Asset Access**     | - Download link functionality<br>- Purchased asset persistence<br>- Cross-user access prevention<br>- Link expiration (if implemented) | Guarantees secure asset delivery            |

---
