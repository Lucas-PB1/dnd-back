import type { Cap6TransformationRule } from '../types';

export const RULE_SERAPH: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "celestial-form"
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

export const RULE_SHADOWSTEEL_GHOUL: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "pick1",
      "autoBoons": [],
      "pickKeys": [
        "stage1Boon"
      ]
    },
    "2": {
      "mode": "pick2",
      "autoBoons": [],
      "pickKeys": [
        "stage2Boon",
        "stage2Boon2"
      ]
    },
    "3": {
      "mode": "auto_single",
      "autoBoons": [
        "cursed-claw"
      ],
      "pickKeys": []
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

export const RULE_SPECTER: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "spectral-form"
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

export const RULE_VAMPIRE: Cap6TransformationRule = {
  "stages": {
    "1": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "fanged-bite"
      ],
      "pickKeys": [
        "stage1Boon"
      ]
    },
    "2": {
      "mode": "pick2",
      "autoBoons": [],
      "pickKeys": [
        "stage2Boon",
        "stage2Boon2"
      ]
    },
    "3": {
      "mode": "pick2",
      "autoBoons": [],
      "pickKeys": [
        "stage3Boon",
        "stage3Boon2"
      ]
    },
    "4": {
      "mode": "fixed_plus_pick1",
      "autoBoons": [
        "regeneration"
      ],
      "pickKeys": [
        "stage4Boon"
      ]
    }
  },
  "subOptions": [],
  "requireMatch": [
    {
      "laterKey": "stage4Boon",
      "earlierKey": "stage1Boon",
      "pairs": {
        "soman-bloodline": "final-soman-bloodline",
        "fzeg-bloodline": "final-fzeg-bloodline",
        "strigoi-bloodline": "final-strigoi-bloodline"
      }
    }
  ]
};
