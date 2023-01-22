#!/bin/bash

# Prompt the user to enter a name for the project
echo "Please enter a name for your Svelte project:"
read project_name

if [ -d $project_name ]; then
    echo "$project_name already exists. Please choose another name."
    exit 1
else
    echo "Creating a new Svelte project called $project_name..."
fi

# Create a new Svelte project using SvelteKit
npm create svelte@latest $project_name

# Move into the newly created project directory
cd $project_name

npm install

# Install tailwindcss
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init tailwind.config.cjs -p

echo 'import adapter from "@sveltejs/adapter-auto";
import preprocess from "svelte-preprocess";

/** @type {import("@sveltejs/kit").Config} */
const config = {
  kit: {
    adapter: adapter()
  },
  preprocess: [
    preprocess({
      postcss: true,
    }),
  ],
};

export default config;' >svelte.config.js

echo 'module.exports = {
  content: ["./src/**/*.{html,js,svelte,ts}"],
  theme: {
    extend: {}
  },
  plugins: []
};' >tailwind.config.js

if [ ! -f "src/app.css" ]; then
    touch src/app.css
    echo '@tailwind base;
@tailwind components;
@tailwind utilities;' >>src/app.css
fi

# Install axios
npm install axios

# Install Jest
npm i -D jest @types/jest ts-jest @testing-library/jest-dom svelte-jester @testing-library/svelte

echo 'import "@testing-library/jest-dom";' >setupTests.ts

echo 'export default {
    transform: {
        "^.+\\.svelte$": [
            "svelte-jester",
            { preprocess: "./svelte.config.test.cjs" },
        ],
        "^.+\\.ts$": "ts-jest",
        "^.+\\.js$": "ts-jest",
    },
    moduleFileExtensions: ["js", "ts", "svelte"],
    moduleNameMapper: {
        "^\\$lib(.*)$": "<rootDir>/src/lib$1",
        "^\\$app(.*)$": [
            "<rootDir>/.svelte-kit/dev/runtime/app$1",
            "<rootDir>/.svelte-kit/build/runtime/app$1",
        ],
    },
    setupFilesAfterEnv: ["<rootDir>/jest-setup.ts"],
    collectCoverageFrom: ["src/**/*.{ts,tsx,svelte,js,jsx}"],
};' >jest.config.mjs

echo "const preprocess = require('svelte-preprocess');
module.exports = { preprocess: preprocess() };" >svelte.config.test.cjs

# Add Jest
mkdir __tests__

# Create a .env file
touch .env

# Create a LICENSE file
echo "MIT License

Copyright (c) $(date +%Y) [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the \"Software\"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE INITIALIZED WITH THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE." >LICENSE

# Create a directory structure
cd src
mkdir constants params services components widgets types
cd ..

# Create a directory structure for static assets
cd static
mkdir assets
cd assets
mkdir images fonts sounds videos
cd ..
