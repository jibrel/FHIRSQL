# Comparison of Medplum and Yazid Condition Schemas

## 1. Table Structure

### Medplum:
- Uses a single table `Condition` for all data.
- Stores most fields as TEXT.
- Uses arrays for some fields (compartments, category, evidence, stage).

### Yazid:
- Uses a main `condition` table and several related tables (identifier, category, body_site, participant, stage, evidence, note).
- Stores complex data as JSONB.
- Uses separate tables for repeating elements.

## 2. Primary Key

### Medplum:
- Uses `id` as UUID, NOT NULL PRIMARY KEY.

### Yazid:
- Uses `id` as UUID PRIMARY KEY with DEFAULT gen_random_uuid().

## 3. Data Types

### Medplum:
- Mostly uses TEXT for storing data.
- Uses TIMESTAMP WITH TIME ZONE for `lastUpdated`.
- Uses UUID[] for `compartments`.

### Yazid:
- Uses JSONB for complex data structures (clinical_status, verification_status, severity, code, etc.).
- Uses TIMESTAMP WITH TIME ZONE for date/time fields.
- Uses UUID for reference fields (subject_id, encounter_id, etc.).

## 4. FHIR-specific Fields

### Medplum:
- Includes `content` field (TEXT) to store the entire FHIR resource.
- Has `compartments` field (UUID[]) which is not a standard FHIR element.

### Yazid:
- Does not have a field to store the entire FHIR resource.
- More closely follows the FHIR Condition resource structure with separate fields and tables.

## 5. Timestamps

### Medplum:
- Has only one timestamp: `lastUpdated`.

### Yazid:
- Has `created_at` and `updated_at` timestamps.

## 6. Indexing

### Medplum:
- No indexes defined in the provided SQL.

### Yazid:
- Creates several indexes on the main table and related tables for better query performance.

## 7. References to Other Resources

### Medplum:
- Stores references as TEXT (patient, asserter, encounter, subject).

### Yazid:
- Stores references as UUID with an additional _type field to specify the resource type.

## 8. Extensibility

### Medplum:
- Less flexible for querying specific parts of complex data structures.
- Easier to store non-standard extensions in the `content` field.

### Yazid:
- More flexible for querying specific parts of complex data structures.
- May require schema changes to accommodate non-standard extensions.

## Conclusion

The Medplum schema opts for simplicity and flexibility, storing most data as TEXT and using a single table. This approach makes it easy to store any FHIR-compliant data but may be less efficient for querying specific fields.

The Yazid schema is more normalized and closely follows the FHIR Condition resource structure. It uses separate tables for repeating elements and JSONB for complex structures. This approach allows for more efficient querying of specific fields but requires more complex queries for retrieving the complete resource.

The choice between these schemas would depend on specific use cases, query patterns, and the need for flexibility vs. query performance.


---



This comparison highlights the key differences between the two approaches to implementing the FHIR Condition resource in PostgreSQL. Each approach has its strengths and trade-offs:

The Medplum approach is simpler and more flexible, making it easier to store any FHIR-compliant data without needing to change the schema. However, it may be less efficient for querying specific fields within the resource.
The Yazid approach is more normalized and closely follows the FHIR Condition resource structure. This allows for more efficient querying of specific fields and better enforcement of data integrity. However, it requires more complex queries for retrieving the complete resource and may need schema changes to accommodate non-standard extensions.

The choice between these two approaches would depend on your specific use cases, query patterns, and requirements for flexibility versus query performance. If you need to frequently query specific fields within the Condition resource, the Yazid approach might be more suitable. If you prioritize flexibility and simplicity, and don't need to query specific fields often, the Medplum approach could be a better fit.
