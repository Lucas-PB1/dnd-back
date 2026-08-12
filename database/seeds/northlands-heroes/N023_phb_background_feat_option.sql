-- Escolhas de talento de origem — preordained-hero / seafarer.

INSERT INTO rpg.phb_background_feat_option (background_id, feat_id)
SELECT b.id, f.id
FROM rpg.phb_background b
CROSS JOIN (
  VALUES
    ('blessing-of-baldur'),
    ('blessing-of-boreas'),
    ('blessing-of-eir'),
    ('blessing-of-freyr-and-freyja'),
    ('blessing-of-jormungandr'),
    ('blessing-of-loki'),
    ('blessing-of-sif'),
    ('blessing-of-thor'),
    ('blessing-of-volund'),
    ('blessing-of-wotan')
) AS opt(feat_slug)
JOIN rpg.phb_feat f ON f.slug = opt.feat_slug
WHERE b.slug = 'preordained-hero'
ON CONFLICT (background_id, feat_id) DO NOTHING;

INSERT INTO rpg.phb_background_feat_option (background_id, feat_id)
SELECT b.id, f.id
FROM rpg.phb_background b
CROSS JOIN (
  VALUES
    ('fisher'),
    ('northern-raider')
) AS opt(feat_slug)
JOIN rpg.phb_feat f ON f.slug = opt.feat_slug
WHERE b.slug = 'seafarer'
ON CONFLICT (background_id, feat_id) DO NOTHING;
