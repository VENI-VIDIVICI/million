source $(dirname "$0")/helpers.sh

index_html_content="<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\" /><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" /><link rel=\"icon\" type=\"image/svg+xml\" href=\"https://raw.githubusercontent.com/aidenybai/million/main/.github/assets/icon.svg\"><title>Million Playground</title><link rel=\"stylesheet\" href=\"./style.css\"><script type=\"module\" src=\"./script.tsx\"></script></head><body></body></html>"
script_tsx_content="import { m, createElement, patch } from '../src/index';

const app = createElement(m('div', { id: 'app' }, ['Hello World']));
document.body.appendChild(app);

setTimeout(() => {
  patch(app, m('div', { id: 'app' }, ['Goodbye World']));
}, 1000);"
style_css_content="body { font-size: 2em; display: flex; justify-content: center; align-items: start; padding-top: 2em; font-family: Arial; }"

if [ "$1" == "--fresh" ]; then
  if [ -d dev ]; then
    info "Found the \`dev\` directory, deleting it now...\n"
    rm -rf dev
  fi
fi

if [ ! -d dev ]; then
  mkdir dev
  echo "$index_html_content" > dev/index.html
  echo "$script_tsx_content" > dev/script.tsx
  echo "$style_css_content" > dev/style.css
  info "Couldn't find an the \`dev\` directory, creating one for you...\n"
fi

npx vite
