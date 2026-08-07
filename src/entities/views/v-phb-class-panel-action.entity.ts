import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class_panel_action' })
export class VPhbClassPanelAction {
  @ViewColumn({ name: 'panel_key' })
  panelKey!: string;

  @ViewColumn({ name: 'class_slug' })
  classSlug!: string;

  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string | null;

  @ViewColumn()
  slug!: string;

  @ViewColumn()
  name!: string;

  @ViewColumn()
  title!: string | null;

  @ViewColumn({ name: 'unlock_level' })
  unlockLevel!: number;

  @ViewColumn({ name: 'resource_slug' })
  resourceSlug!: string | null;

  @ViewColumn()
  section!: string;

  @ViewColumn({ name: 'spends_focus' })
  spendsFocus!: boolean;

  @ViewColumn({ name: 'sort_order' })
  sortOrder!: number;
}
