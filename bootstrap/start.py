#!/usr/bin/python3

# pylint: disable=missing-docstring

import os
import readline
import subprocess
import string


def query_user(prompt, text):
    def hook():
        readline.insert_text(text)
        readline.redisplay()
    readline.set_pre_input_hook(hook)
    result = input(prompt)
    readline.set_pre_input_hook()
    return result


def fill_template(src, dest):
    with open(src, 'r') as template, open(dest, 'w') as out:
        text = string.Template(template.read())
        out.write(text.safe_substitute(globals()))


def template_list(fmt):
    return '\n'.join(fmt(a) for a in STEAM_APP_ID_LIST.split())


GIT_TOPLEVEL_CMD = ['git', 'rev-parse', '--show-toplevel']

os.chdir(subprocess.check_output(GIT_TOPLEVEL_CMD).strip())

PACKAGE_NAME = query_user('package name: ', os.path.basename(os.getcwd()))
PROJECT_URL = query_user('git project url: ', '')
STEAM_APP_ID_LIST = query_user('steam app_ids: ', '123 456')


DOWNLOAD_LINKS = template_list(
        lambda a: f'<a href="{PACKAGE_NAME}-{a}.tar.xz">download ({a})</a>')
ARTIFACT_DIRS = template_list(
        lambda a: f'    - {a}/')
ARTIFACT_TARBALLS = template_list(
        lambda a: f'    - {a}/dist.tar.xz')
MV_TARBALLS_TO_PUBLIC = template_list(
        lambda a: f'  - mv {a}/dist.tar.xz public/{PACKAGE_NAME}-{a}.tar.xz')

print('+ create index.html')
fill_template('bootstrap/templates/index.html', 'index.html')
print('+ create env.sh')
fill_template('bootstrap/templates/env.sh', 'env.sh')
print('+ create .gitlab-ci.yml')
fill_template('bootstrap/templates/gitlab-ci.yml', '.gitlab-ci.yml')
print(f'+ git submodule add {PROJECT_URL}')
subprocess.call(['git', 'submodule', 'add', PROJECT_URL, 'source'])
print('+ git status')
subprocess.call(['git', 'status'])
