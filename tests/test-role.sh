#!/usr/bin/env bash

test_role() {

  local DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)";

  cd ${DIR};

  local TEST_ANSIBLE_INSTALLER_URI='https://raw.githubusercontent.com/shrikeh/ansible-virtualenv/master/init.sh';
  local TEST_ANSIBLE_VENV='.venv';
  local TEST_ANSIBLE_VERSION='v1.9.2-1';
  local TEST_ANSIBLE_CHECKOUT_PATH='./.ansible';
  local TEST_ANSIBLE_INVENTORY_FILE='./inventory';
  local TEST_ANSIBLE_PLAYBOOK='./playbook.yml';
  local TEST_REMOTE_USER='root';

  . <(curl -L --silent "${TEST_ANSIBLE_INSTALLER_URI}") \
    -d "${TEST_ANSIBLE_CHECKOUT_PATH}" \
    --branch "${TEST_ANSIBLE_VERSION}" \
    --venv "${TEST_ANSIBLE_VENV}" \
    --use-pip-version \
  ;

  ( ansible-playbook -i "${TEST_ANSIBLE_INVENTORY_FILE}" \
    "${TEST_ANSIBLE_PLAYBOOK}" \
    -u "${TEST_REMOTE_USER}" \
    -vvvv \
    --extra-vars "test_ip=${TEST_IP}" \
  );
}

test_role;
