-- Ensure we're using the yazid_test schema
SET search_path TO yazid_test;

-- Create the condition table
CREATE TABLE yazid_test.condition (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    clinical_status JSONB NOT NULL,
    verification_status JSONB,
    severity JSONB,
    code JSONB,
    subject_id UUID NOT NULL,
    encounter_id UUID,
    onset_date_time TIMESTAMP WITH TIME ZONE,
    onset_age JSONB,
    onset_period JSONB,
    onset_range JSONB,
    onset_string TEXT,
    abatement_date_time TIMESTAMP WITH TIME ZONE,
    abatement_age JSONB,
    abatement_period JSONB,
    abatement_range JSONB,
    abatement_string TEXT,
    recorded_date TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create the condition_identifier table
CREATE TABLE yazid_test.condition_identifier (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    condition_id UUID REFERENCES yazid_test.condition(id),
    use TEXT,
    type JSONB,
    system TEXT,
    value TEXT,
    period_start TIMESTAMP WITH TIME ZONE,
    period_end TIMESTAMP WITH TIME ZONE,
    assigner TEXT
);

-- Create the condition_category table
CREATE TABLE yazid_test.condition_category (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    condition_id UUID REFERENCES yazid_test.condition(id),
    category JSONB
);

-- Create the condition_body_site table
CREATE TABLE yazid_test.condition_body_site (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    condition_id UUID REFERENCES yazid_test.condition(id),
    body_site JSONB
);

-- Create the condition_participant table
CREATE TABLE yazid_test.condition_participant (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    condition_id UUID REFERENCES yazid_test.condition(id),
    function JSONB,
    actor_id UUID NOT NULL,
    actor_type TEXT NOT NULL
);

-- Create the condition_stage table
CREATE TABLE yazid_test.condition_stage (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    condition_id UUID REFERENCES yazid_test.condition(id),
    summary JSONB,
    type JSONB
);

-- Create the condition_stage_assessment table
CREATE TABLE yazid_test.condition_stage_assessment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    stage_id UUID REFERENCES yazid_test.condition_stage(id),
    assessment_id UUID NOT NULL,
    assessment_type TEXT NOT NULL
);

-- Create the condition_evidence table
CREATE TABLE yazid_test.condition_evidence (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    condition_id UUID REFERENCES yazid_test.condition(id),
    concept JSONB,
    reference_id UUID,
    reference_type TEXT
);

-- Create the condition_note table
CREATE TABLE yazid_test.condition_note (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    condition_id UUID REFERENCES yazid_test.condition(id),
    author_reference UUID,
    author_string TEXT,
    time TIMESTAMP WITH TIME ZONE,
    text TEXT
);

-- Create indexes for better query performance
CREATE INDEX idx_condition_subject_id ON yazid_test.condition(subject_id);
CREATE INDEX idx_condition_encounter_id ON yazid_test.condition(encounter_id);
CREATE INDEX idx_condition_clinical_status ON yazid_test.condition USING gin(clinical_status);
CREATE INDEX idx_condition_verification_status ON yazid_test.condition USING gin(verification_status);
CREATE INDEX idx_condition_code ON yazid_test.condition USING gin(code);
CREATE INDEX idx_condition_recorded_date ON yazid_test.condition(recorded_date);
CREATE INDEX idx_condition_identifier_value ON yazid_test.condition_identifier(value);
