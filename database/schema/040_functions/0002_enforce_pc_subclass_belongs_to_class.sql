CREATE OR REPLACE FUNCTION rpg.enforce_pc_subclass_belongs_to_class()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.subclass_slug IS NULL THEN
    RETURN NEW;
  END IF;
  IF NOT EXISTS (
    SELECT 1
    FROM rpg.phb_subclass sc
    JOIN rpg.phb_class c ON c.id = sc.class_id
    WHERE sc.slug = NEW.subclass_slug
      AND c.slug = NEW.class_slug
  ) THEN
    RAISE EXCEPTION 'subclass "%" does not belong to class "%"',
      NEW.subclass_slug, NEW.class_slug;
  END IF;
  RETURN NEW;
END;
$$;
