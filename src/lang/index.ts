import i18next from 'i18next';
import en from './en';
import ja from './ja';

// eslint-disable-next-line @typescript-eslint/no-unused-vars
const DEFAULT_LANG = 'ja';
const FALLBACK = 'ja';

i18next.init({ // eslint-disable-line
  interpolation: {
    // React already does escaping
    escapeValue: false,
  },
  lng: FALLBACK,
  fallbackLng: FALLBACK,
  // Using simple hardcoded resources for simple example
  resources: {
    ja: {
      translation: ja,
    },
    en: {
      translation: en,
    },
  },
});

export default i18next;
