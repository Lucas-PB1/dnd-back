import type { Cap6TransformationRule } from '../types';

export const RULE_ABERRANT_HORROR: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "auto_all",
      "autoBoons": [
        "aberrant-form",
        "aberrant-mutation"
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
  "subOptions": [],
  "requireMatch": []
};

export const RULE_FEY: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "fey-form"
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

export const RULE_FIEND: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "fiendish-soul"
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
  "subOptions": [
    {
      "key": "fiendDamageType",
      "fromStage": 1,
      "values": [
        {
          "id": "acid",
          "label": "Ácido"
        },
        {
          "id": "cold",
          "label": "Frio"
        },
        {
          "id": "fire",
          "label": "Fogo"
        }
      ]
    }
  ],
  "requireMatch": []
};

export const RULE_HAG: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "hag-form"
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
  "requireMatch": [
    {
      "laterKey": "stage2Boon",
      "earlierKey": "stage1Boon",
      "pairs": {
        "the-green-sisterhood": "adept-of-the-green-sisterhood",
        "the-red-sisterhood": "adept-of-the-red-sisterhood",
        "the-sea-sisterhood": "adept-of-the-sea-sisterhood"
      }
    },
    {
      "laterKey": "stage3Boon",
      "earlierKey": "stage1Boon",
      "pairs": {
        "the-green-sisterhood": "master-of-the-green-sisterhood",
        "the-red-sisterhood": "master-of-the-red-sisterhood",
        "the-sea-sisterhood": "master-of-the-sea-sisterhood"
      }
    }
  ]
};
