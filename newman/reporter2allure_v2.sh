#!/bin/bash

#newman run <collection-url> -r statsd --reporter-statsd-destination <ip-address> --reporter-statsd-port <port-number>
#newman run nsports_st_2.1.0_c.json -e nsports_st_2.1.0_env.json -r statsd --reporter-statsd-destination 192.168.100.190 --reporter-statsd-port 8125

export JOB_NAME='rb88_transaction_shslrbp4.funpo.com_1.0.0'
export collection_name='rb88_transaction_shslrbp4.funpo.com_1.0.0_c.json'
export env_name='rb88_transaction_shslrbp4.funpo.com_1.0.0_env.json'
export report_name='rb88_transaction_shslrbp4.funpo.com_1.0.0'
export iterations_num='2'
export html_type='full' # original , aggregated , full
export allure_results_folder="/opt/allure-docker/projects/$(echo ${JOB_NAME}|sed 's|_|-|g')/results"
export allure_reports_folder="/opt/allure-docker/projects/$(echo ${JOB_NAME}|sed 's|_|-|g')/reports"

echo " - allure_results_folder:${allure_results_folder}"
echo " - allure_reports_folder:${allure_reports_folder}"

[ ! -d "${allure_results_folder}" ] && mkdir -p "${allure_results_folder}"
[ ! -d "${allure_reports_folder}" ] && mkdir -p "${allure_reports_folder}"

docker run -v /opt/newman-src:/etc/newman -v "${allure_results_folder}":/opt/allure-results --network monitor \
--name "${JOB_NAME}" --rm postman_checks:v0.5 \
run "/etc/newman/${collection_name}" -e "/etc/newman/environments/${env_name}" \
-r html,cli,allure \
--reporter-allure-export /opt/allure-results \
--reporter-html-export "./reports/${report_name}" \
--reporter-html-template ./reports/templates/customTemplate_2.hbs \
--delay-request 500 --timeout 900000 --timeout-request 5000 --timeout-script 5000 \
--reporter-cli-no-failures --reporter-cli-no-assertions --reporter-cli-no-console \
--disable-unicode --color off --suppress-exit-code 1
# --- END --- #
