import type { Cap6TransformationRule } from '../types';

export const RULE_LICH: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "undead-form"
      ],
      "pickKeys": [
        "stage1Boon"
      ]
    },
    "2": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage2Boon"
      ]
    },
    "3": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage3Boon"
      ]
    },
    "4": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage4Boon"
      ]
    }
  },
  "subOptions": [],
  "requireMatch": []
};

export const RULE_LYCANTHROPE: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage1Boon"
      ]
    },
    "2": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage2Boon"
      ]
    },
    "3": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage3Boon"
      ]
    },
    "4": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage4Boon"
      ]
    }
  },
  "subOptions": [],
  "requireMatch": []
};

export const RULE_OOZE: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "ooze-form"
      ],
      "pickKeys": [
        "stage1Boon"
      ]
    },
    "2": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage2Boon"
      ]
    },
    "3": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage3Boon"
      ]
    },
    "4": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage4Boon"
      ]
    }
  },
  "subOptions": [],
  "requireMatch": []
};

export const RULE_PRIMORDIAL: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "auto_all",
      "autoBoons": [
        "primordial-form",
        "elemental-affinity"
      ],
      "pickKeys": []
    },
    "2": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage2Boon"
      ]
    },
    "3": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage3Boon"
      ]
    },
    "4": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage4Boon"
      ]
    }
  },
  "subOptions": [
    {
      "key": "elementalAffinity",
      "fromStage": 1,
      "values": [
        {
          "id": "air",
          "label": "Ar"
        },
        {
          "id": "earth",
          "label": "Terra"
        },
        {
          "id": "fire",
          "label": "Fogo"
        },
        {
          "id": "water",
          "label": "Água"
        }
      ]
    },
    {
      "key": "primordialDamageType",
      "fromStage": 3,
      "whenChoice": {
        "key": "stage3Boon",
        "value": "primeval-body"
      },
      "values": [
        {
          "id": "bludgeoning",
          "label": "Contundente"
        },
        {
          "id": "cold",
          "label": "Frio"
        },
        {
          "id": "fire",
          "label": "Fogo"
        },
        {
          "id": "lightning",
          "label": "Elétrico"
        }
      ]
    }
  ],
  "requireMatch": []
};
