
CREATE TABLE IF NOT EXISTS receipt_designs (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  width INT NOT NULL,
  height INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE receipt_designs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tenant_manage_own_receipt_designs ON receipt_designs;
CREATE POLICY tenant_manage_own_receipt_designs
ON receipt_designs
FOR ALL
USING (tenant_id = auth.uid()::text)
WITH CHECK (tenant_id = auth.uid()::text);


CREATE TABLE IF NOT EXISTS receipt_elements (
  id TEXT PRIMARY KEY,
  design_id TEXT NOT NULL REFERENCES receipt_designs(id) ON DELETE CASCADE,
  tenant_id TEXT NOT NULL,
  element_type TEXT NOT NULL CHECK (
    element_type IN ('text','qr','line','logo','code128','code39','placeholder')
  ),
  position_x INT NOT NULL,
  position_y INT NOT NULL,
  width INT NOT NULL,
  height INT NOT NULL,
  content TEXT,
  properties JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  CONSTRAINT position_x_nonnegative CHECK (position_x >= 0),
  CONSTRAINT position_y_nonnegative CHECK (position_y >= 0)
);

ALTER TABLE receipt_elements ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tenant_manage_own_receipt_elements ON receipt_elements;
CREATE POLICY tenant_manage_own_receipt_elements
ON receipt_elements
FOR ALL
USING (tenant_id = auth.uid()::text)
WITH CHECK (tenant_id = auth.uid()::text);

