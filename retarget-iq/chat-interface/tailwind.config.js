/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    "./node_modules/reachat/**/*.{js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {
      colors: {
        // ========================================
        // RETARGETIQ BRAND COLORS
        // TODO: Update these with actual colors from retargetiq.com
        // ========================================

        brand: {
          // Primary - Main brand color
          primary: '#0066FF',       // << UPDATE with RetargetIQ blue
          'primary-dark': '#0052CC',
          'primary-light': '#4D94FF',

          // Secondary - Accent color
          secondary: '#00C2B2',     // << UPDATE if they have a secondary

          // Neutral backgrounds
          'bg-primary': '#FFFFFF',
          'bg-secondary': '#F7F9FC',
          'bg-chat': '#F1F4F9',
        },

        // Chat-specific colors
        chat: {
          'user-bubble': '#0066FF', // Same as brand primary
          'ai-bubble': '#FFFFFF',
          'user-text': '#FFFFFF',
          'ai-text': '#1A1A2E',
          'border': '#E5E7EB',
          'input-bg': '#F9FAFB',
        }
      },

      borderRadius: {
        'bubble': '16px',
        'input': '24px',
        'container': '12px',
      },

      boxShadow: {
        'chat': '0 4px 20px rgba(0, 0, 0, 0.1)',
        'bubble': '0 1px 2px rgba(0, 0, 0, 0.05)',
        'input': '0 2px 8px rgba(0, 0, 0, 0.08)',
      },

      animation: {
        'fade-in': 'fadeIn 0.2s ease-out',
        'slide-up': 'slideUp 0.2s ease-out',
        'pulse-dot': 'pulseDot 1.4s infinite ease-in-out',
      },

      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { opacity: '0', transform: 'translateY(10px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        pulseDot: {
          '0%, 80%, 100%': { transform: 'scale(0)' },
          '40%': { transform: 'scale(1)' },
        },
      },
    },
  },
  plugins: [],
}
