

CREATE TABLE IF NOT EXISTS receipt_designs (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  width INT NOT NULL,
  height INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE receipt_designs ENABLE ROW LEVEL SECURITY;


CREATE TABLE IF NOT EXISTS receipt_elements (
  id TEXT PRIMARY KEY,
  design_id TEXT NOT NULL
    REFERENCES receipt_designs(id)
    ON DELETE CASCADE,
  tenant_id TEXT NOT NULL,
  element_type TEXT NOT NULL CHECK (
    element_type IN (
      'text',
      'qr',
      'line',
      'logo',
      'code128',
      'code39',
      'placeholder'
    )
  ),
  position_x INT NOT NULL,
  position_y INT NOT NULL,
  width INT NOT NULL,
  height INT NOT NULL,
  content TEXT,
  properties JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE receipt_elements ENABLE ROW LEVEL SECURITY;
