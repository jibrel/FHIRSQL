-- Ensure we're using the medplum schema
SET search_path TO medplum;

-- Create the condition table
CREATE TABLE IF NOT EXISTS medplum.Condition (
    "id" UUID NOT NULL PRIMARY KEY,
    "content" TEXT NOT NULL,
    "lastUpdated" TIMESTAMP WITH TIME ZONE NOT NULL,
    "compartments" UUID[] NOT NULL,
    "code" TEXT,
    "patient" TEXT,
    "abatementAge" TEXT,
    "abatementDate" TEXT,
    "abatementString" TEXT,
    "asserter" TEXT,
    "bodySite" TEXT,
    "category" TEXT[],
    "clinicalStatus" TEXT,
    "encounter" TEXT,
    "evidence" TEXT[],
    "evidenceDetail" TEXT,
    "onsetAge" TEXT,
    "onsetDate" TEXT,
    "onsetInfo" TEXT,
    "recordedDate" TEXT,
    "severity" TEXT,
    "stage" TEXT[],
    "subject" TEXT,
    "verificationStatus" TEXT
  );
