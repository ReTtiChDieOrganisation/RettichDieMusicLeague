/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // SoundCloud-inspired color palette
        'soundcloud-orange': '#ff5500',
        'soundcloud-coral': '#ff7043',
        'soundcloud-peach': '#ff8a65',
        'charcoal': {
          50: '#f5f5f5',
          100: '#e5e5e5',
          200: '#cccccc',
          300: '#b3b3b3',
          400: '#999999',
          500: '#808080',
          600: '#666666',
          700: '#4d4d4d',
          800: '#1e1e1e',
          900: '#1a1a1a',
          950: '#111111'
        }
      },
      boxShadow: {
        'glow-orange': '0 0 20px rgba(255, 85, 0, 0.3)',
        'glow-orange-lg': '0 0 30px rgba(255, 85, 0, 0.4)',
        'glow-orange-xl': '0 0 40px rgba(255, 85, 0, 0.5)',
        'glass': '0 8px 32px 0 rgba(0, 0, 0, 0.37)',
      },
      backdropBlur: {
        xs: '2px',
      },
      animation: {
        'pulse-glow': 'pulse-glow 2s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'gradient': 'gradient 8s ease infinite',
      },
      keyframes: {
        'pulse-glow': {
          '0%, 100%': {
            boxShadow: '0 0 20px rgba(255, 85, 0, 0.3)',
          },
          '50%': {
            boxShadow: '0 0 30px rgba(255, 85, 0, 0.5)',
          },
        },
        gradient: {
          '0%, 100%': {
            backgroundPosition: '0% 50%',
          },
          '50%': {
            backgroundPosition: '100% 50%',
          },
        },
      },
      backgroundSize: {
        '300%': '300%',
      },
    },
  },
  plugins: [],
}
