#!/usr/bin/env bash

# Create a new virtual environment
py -m venv env

# Activate the virtual environment
source env/scripts/activate.bat

# Create the src directory
mkdir src

# Create the data, model, and utils directories inside the src directory
mkdir src/data src/model src/utils src/services src/constants

# Create the __init__.py file inside the src directory and the main.py file inside the src directory
touch src/__init__.py
touch src/services/__init__.py src/constants/__init__.py src/utils/__init__.py src/model/__init__.py src/services/__init__.py

# Create a main.py file inside the src directory
echo "import src.constants as constants
if __name__ == \"__main__\":
    pass" > src/main.py

echo "from dotenv import load_dotenv 
    load_dotenv() " > src/constants/constants.py


# Install the required packages
pip install pandas numpy python-dotenv pytest requests

# Create a README.md file
curl https://raw.githubusercontent.com/othneildrew/Best-README-Template/master/BLANK_README.md > README.md

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
SOFTWARE." > LICENSE

# Create a .gitignore file
echo "env/
*.pyc
__pycache__/" > .gitignore

# Create a tests directory inside the src directory
mkdir tests
touch tests/__init__.py
touch tests/test.py

# Create a .env file
touch .env

# Freeze the requirements
pip freeze > requirements.txt

# Create a .git directory
git init


# Create setup.py file
# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Prompt the user for the project version
read -p "Enter the project version: " project_version

# Prompt the user for the project description
read -p "Enter the project description: " project_description

# Prompt the user for the project author
read -p "Enter the project author: " project_author

# Prompt the user for the project author email
read -p "Enter the project author email: " project_author_email

# Prompt the user for the project URL
read -p "Enter the project URL: " project_url

# Prompt the user for the project license
read -p "Enter the project license: " project_license

# Create the setup.py file
echo "from setuptools import setup

setup(
    name='$project_name',
    version='$project_version',
    description='$project_description',
    author='$project_author',
    author_email='$project_author_email',
    url='$project_url',
    license='$project_license',
    packages=['$project_name']
)
" > setup.py

echo "Done!"
echo "The setup.py file has been created with the following values:"
echo "Project name: $project_name"
echo "Project version: $project_version"
echo "Project description: $project_description"
echo "Project author: $project_author"
echo "Project author email: $project_author_email"
echo "Project URL: $project_url"
echo "Project license


echo "Done!"
echo "You can now start developing your Python project with the virtual environment, and the required packages and project structure are in place."
