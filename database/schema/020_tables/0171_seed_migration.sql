CREATE TABLE rpg.seed_migration (
  version TEXT PRIMARY KEY,
  checksum TEXT NOT NULL,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE rpg.seed_migration IS
  'Ledger de seeds SQL (version = path relativo a database/seeds; checksum sha256).';
