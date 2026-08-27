-- Bundle de catálogo: thread + goals + milestones + benefits

CREATE OR REPLACE VIEW rpg.v_phb_character_thread_bundle AS
SELECT
  t.slug,
  t.edition_slug,
  t.name,
  t.summary,
  t.special_rules_text,
  t.sort_order,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'sortOrder', g.sort_order,
        'text', g.text
      )
      ORDER BY g.sort_order
    )
    FROM rpg.phb_character_thread_goal g
    WHERE g.thread_slug = t.slug
  ), '[]'::jsonb) AS goals,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', m.id,
        'rank', m.rank,
        'sortOrder', m.sort_order,
        'benefits', COALESCE((
          SELECT jsonb_agg(
            jsonb_build_object(
              'benefitKey', b.benefit_key,
              'name', b.name,
              'description', b.description,
              'choiceGroup', b.choice_group,
              'sortOrder', b.sort_order
            )
            ORDER BY b.sort_order, b.benefit_key
          )
          FROM rpg.phb_character_thread_milestone_benefit b
          WHERE b.milestone_id = m.id
        ), '[]'::jsonb)
      )
      ORDER BY m.sort_order
    )
    FROM rpg.phb_character_thread_milestone m
    WHERE m.thread_slug = t.slug
  ), '[]'::jsonb) AS milestones
FROM rpg.phb_character_thread t;
