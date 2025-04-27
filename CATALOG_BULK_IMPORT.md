# Catalog Bulk Import Test Specification

## Feature Overview
**Objective**: Allow creators to upload multiple assets via JSON file  
**Key Flows**:
1. Creator uploads valid JSON file ➔ Assets created
2. Invalid file/format submitted ➔ Clear error displayed
3. Partial valid data ➔ Atomic rollback

---

## Test Categories

### 1. Authorization & Permissions
- ✅ Creator role sees upload UI elements
- ❌ Non-creator roles get 403 errors on:
  - Accessing `/creator/assets`
  - POST to `/bulk_import`
- 🛡️ Tampered session/user_id fails authorization

### 2. File Validation
**Client-Side (Browser)**:
- Blocks non-JSON file selection
- Disables upload button until valid file chosen

**Server-Side**:
- Rejects files >5MB (`MAX_FILE_SIZE`)
- Blocks non-JSON MIME types (`ALLOWED_CONTENT_TYPES`)
- Detects renamed non-JSON files (e.g., .exe → .json)

### 3. Data Integrity
**Valid Cases**:
- Creates assets with exact JSON attributes
- Associates assets to uploader via `assetable` poly
- Handles price as numeric (integer/decimal)

**Invalid Cases**:
- Missing required fields (`title`, `description`, `file_url`, `price`)
- Negative/zero price values
- Duplicate `file_url` entries
- Malformed URLs in `file_url`

### 4. Transaction Safety
- All records succeed → Full commit
- Any record fails → Zero records created
- Mid-process failure → Database consistency

### 5. User Feedback
**Success**:
- Green notice with exact imported count
- Immediate list update (pagination-aware)

**Errors**:
- File errors: Clear MIME/size messages
- Data errors: Field-specific validation texts
- JSON parse errors: Syntax guidance

### 6. Security
- Sanitizes HTML/script in `title`/`description`
- Validates `file_url` protocol (HTTP/HTTPS)
- Prevents path traversal via filename
- Obfuscates server errors (no stack traces)

### 7. Performance
**Thresholds**:
- 100 assets processed in <3s
- Memory ≤150MB for 1,000 assets
- 10 concurrent uploads handled

**Metrics**:
- DB transaction duration
- JSON parse time
- ActiveRecord object allocation

### 8. Edge Cases
**Files**:
- Empty JSON array (`[]`)
- 5MB boundary file (exact size)
- UTF-8 with BOM encoding
- UNIX vs Windows line endings

**Data**:
- Minimum price ($0)
- 255-character titles
- Special characters in URLs
- Mixed valid/invalid entries

### 9. Browser Compatibility
- File picker works on Chrome/Firefox/Safari
- AJAX form submission states (loading/error)
- Large file selection feedback

---

## Test Data Requirements
| File Type          | Purpose                          |
|--------------------|----------------------------------|
| `valid_10.json`    | 10 perfect records               |
| `mixed_5.json`     | 3 valid + 2 invalid              |  
| `empty.json`       | Empty array                      |
| `5mb_exact.json`   | Max allowed size                 |
| `hacks.json`       | XSS/SQLi attempts                |
